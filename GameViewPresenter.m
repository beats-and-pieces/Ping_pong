//
//  GameViewController.m
//  PingPong
//
//  Created by Anton Kuznetsov on 07/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "GameViewPresenter.h"

@interface GameViewPresenter ()

@property (assign, nonatomic) double currentSpeed;
@property (assign, nonatomic) double speedMultiplier;
@property (assign, nonatomic) CGFloat dX;
@property (assign, nonatomic) CGFloat dY;

@property (assign, nonatomic) BOOL isPaused;
@property (assign, nonatomic) uint32_t score;
@property (strong, nonatomic) NSTimer *gameTimer;

@end

@implementation GameViewPresenter

- (instancetype)initForAView:(GameViewController *)viewController withSettings:(GameSettings *)settings
{
    self = [super init];
    if (self) {
        self.gameViewController = viewController;
        self.currentSpeed = settings.gameSpeed;
        self.speedMultiplier = settings.speedMultiplier;
        self.score = settings.score;
        self.isPaused = settings.isPaused;
    }
    
    [self startTimer];
    self.isPaused = NO;
    return self;
}

- (void)startGame
{
    self.gameViewController.gameView.ball.center = self.gameViewController.gameView.center;
    self.dX = 1.0;
    self.dY = 1.0;
    
    [self startTimer];
}

- (void)moveBall
{
    if (self.gameViewController.gameView.ball.center.x >= self.gameViewController.gameView.frame.size.width - self.gameViewController.gameView.topPaddle.frame.size.width / 2)
    {
        self.gameViewController.gameView.topPaddle.center = CGPointMake(self.gameViewController.gameView.frame.size.width - self.gameViewController.gameView.topPaddle.frame.size.width / 2, self.gameViewController.gameView.topPaddle.frame.size.height / 2);
    }
    else if (self.gameViewController.gameView.ball.center.x <= self.gameViewController.gameView.topPaddle.frame.size.width / 2)
    {
        self.gameViewController.gameView.topPaddle.center = CGPointMake(self.gameViewController.gameView.topPaddle.frame.size.width / 2, self.gameViewController.gameView.topPaddle.frame.size.height / 2);
    }
    else
    {
        self.gameViewController.gameView.topPaddle.center = CGPointMake(self.gameViewController.gameView.ball.center.x, self.gameViewController.gameView.topPaddle.frame.size.height / 2);
    }
    
    [self bounceBallIfNeeded];
    [self checkIfComputerScored];
    self.gameViewController.gameView.ball.center = CGPointMake(self.gameViewController.gameView.ball.center.x + self.dX, self.gameViewController.gameView.ball.center.y + self.dY);
}

- (void)bounceBallIfNeeded
{
    if (CGRectIntersectsRect(self.gameViewController.gameView.ball.frame, self.gameViewController.gameView.topPaddle.frame) || CGRectIntersectsRect(self.gameViewController.gameView.ball.frame, self.gameViewController.gameView.bottomPaddle.frame))
    {
        self.dY *= -1;
    }
    
    if ((self.gameViewController.gameView.ball.frame.origin.x + self.gameViewController.gameView.ball.frame.size.width > self.gameViewController.view.frame.size.width) ||
        (self.gameViewController.gameView.ball.frame.origin.x < 0))
    {
        self.dX *= -1;
    }
}

- (void)checkIfComputerScored
{
    if (self.gameViewController.gameView.ball.frame.origin.y + self.gameViewController.gameView.ball.frame.size.height > self.gameViewController.view.frame.size.height){
        self.score++;
        NSLog(@"%d", self.score);
        self.gameViewController.gameView.topScoreCounterLabel.text = [NSString stringWithFormat:@"%d",self.score];
        [self resetGame];
    }
    
}

- (void)resetGame
{
    [self stopTimer];
    self.gameViewController.gameView.ball.center = self.gameViewController.gameView.center;
    self.dY *= -1;
    self.dX *= -1;
    
    [self startTimer];
}

- (void)startTimer
{
    self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:self.currentSpeed / self.speedMultiplier target:self selector:@selector(moveBall) userInfo:nil repeats:YES];
}

-(void)stopTimer
{
    [self.gameTimer invalidate];
    self.gameTimer = nil;
}

- (void)movePlayerPaddleTo:(CGPoint) currentPoint
{
    if (currentPoint.x >= self.gameViewController.gameView.frame.size.width - self.gameViewController.gameView.ball.bounds.size.width)
    {
        NSLog(@"first");
        self.gameViewController.gameView.bottomPaddle.center = CGPointMake(self.gameViewController.gameView.frame.size.width - self.gameViewController.gameView.ball.bounds.size.width, self.gameViewController.gameView.frame.size.height - self.gameViewController.gameView.bottomPaddle.bounds.size.height / 2);
    }
    else if (currentPoint.x <= self.gameViewController.gameView.ball.bounds.size.width)
    {
        self.gameViewController.gameView.bottomPaddle.center = CGPointMake(self.gameViewController.gameView.ball.bounds.size.width, self.gameViewController.gameView.frame.size.height - self.gameViewController.gameView.bottomPaddle.bounds.size.height / 2);
    }
    else
    {
        self.gameViewController.gameView.bottomPaddle.center = CGPointMake(currentPoint.x, self.gameViewController.gameView.frame.size.height - self.gameViewController.gameView.bottomPaddle.bounds.size.height / 2);
    }
}
-(void)pauseGame
{
    if (!self.isPaused)
    {
        [self stopTimer];
        self.isPaused = YES;
        [self.gameViewController.gameView.pauseButton setTitle:@">" forState:UIControlStateNormal];
    }
    else
    {
        self.isPaused = NO;
        [self startTimer];
        [self.gameViewController.gameView.pauseButton setTitle:@"||" forState:UIControlStateNormal];
    }
    
}


- (void)updateSpeed
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];    
    self.speedMultiplier = [defaults floatForKey:@"Selected speed"];
    [self resetGame];
    NSLog(@"Speed loaded!");
}

- (void)togglePause
{
    NSLog(@"togglePause - VP");
    [self stopTimer];
    if (!self.isPaused)
    {
        [self stopTimer];
        self.isPaused = YES;
        [self.gameViewController.gameView.pauseButton setTitle:@">" forState:UIControlStateNormal];
    }
    else
    {
        [self startTimer];
        self.isPaused = NO;
        [self.gameViewController.gameView.pauseButton setTitle:@"||" forState:UIControlStateNormal];
    }
}
@end
