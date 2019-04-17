//
//  ViewController.m
//  PingPong
//
//  Created by Anton Kuznetsov on 07/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "ViewController.h"
#import "PaddleView.h"
#import "BallView.h"
#import "GameView.h"

@interface ViewController ()

//@property (strong, nonatomic) PaddleView *bottomPaddle;
//@property (strong, nonatomic) PaddleView *topPaddle;
//@property (strong, nonatomic) BallView *ball;
//@property (strong, nonatomic) UIView *gameField;
@property (strong, nonatomic) GameView *gameView;

//@property (strong, nonatomic) UILabel *topScoreCounterLabel;
//@property (strong, nonatomic) UILabel *bottomScoreCounterLabel;
@property (assign, nonatomic) double currentSpeed;
@property (assign, nonatomic) double speedMultiplier;
@property (assign, nonatomic) CGFloat dX;
@property (assign, nonatomic) CGFloat dY;
@property (assign, nonatomic) CGFloat ballDiameter;
@property (assign, nonatomic) CGFloat paddleWidth;
@property (assign, nonatomic) CGFloat paddleHeight;
//@property (strong, nonatomic) UIButton *pauseButton;
@property (assign, nonatomic) BOOL isPaused;
@property (assign, nonatomic) uint32_t score;
@property (strong, nonatomic) NSTimer *gameTimer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self initGameField];
    self.gameView = [[GameView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height)];
    [self.view addSubview:self.gameView];
    self.gameView.delegate = self;
    [self loadUISettings];
    [self startGame];
}

- (void)loadUISettings
{
    self.ballDiameter = 25.0f;
    self.paddleWidth = 100;
    self.paddleHeight = 20;
    self.currentSpeed = 0.005f;
    self.speedMultiplier = 1.0f;
    self.score = 0;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint currentPoint = [touch locationInView:self.gameView];
    NSLog(@"%f", currentPoint.x);
    
    if (currentPoint.x >= self.gameView.frame.size.width - self.ballDiameter)
    {
        NSLog(@"first");
        self.gameView.bottomPaddle.center = CGPointMake(self.gameView.frame.size.width - self.ballDiameter, self.gameView.frame.size.height - self.paddleHeight / 2);
    }
    else if (currentPoint.x <= self.ballDiameter)
    {
        self.gameView.bottomPaddle.center = CGPointMake(self.ballDiameter, self.gameView.frame.size.height - self.paddleHeight / 2);
    }
    else
    {
        self.gameView.bottomPaddle.center = CGPointMake(currentPoint.x, self.gameView.frame.size.height - self.paddleHeight / 2);
    }
}

- (void)startGame
{
    self.gameView.ball.center = self.view.center;
    self.dX = 1.0;
    self.dY = 1.0;
    
    [self startTimer];
}

- (void)moveBall
{
    if (self.gameView.ball.center.x >= self.gameView.frame.size.width - self.gameView.topPaddle.frame.size.width / 2)
    {
        self.gameView.topPaddle.center = CGPointMake(self.gameView.frame.size.width - self.paddleWidth / 2, self.paddleHeight / 2);
    }
    else if (self.gameView.ball.center.x <= self.gameView.topPaddle.frame.size.width / 2)
    {
        self.gameView.topPaddle.center = CGPointMake(self.gameView.topPaddle.frame.size.width / 2, self.paddleHeight / 2);
    }
    else
    {
        self.gameView.topPaddle.center = CGPointMake(self.gameView.ball.center.x, self.paddleHeight / 2);
    }
    
    [self bounceBallIfNeeded];
    [self checkIfComputerScored];
    self.gameView.ball.center = CGPointMake(self.gameView.ball.center.x + self.dX, self.gameView.ball.center.y + self.dY);
    
    
}

- (void)bounceBallIfNeeded
{
    if (CGRectIntersectsRect(self.gameView.ball.frame, self.self.gameView.topPaddle.frame) || CGRectIntersectsRect(self.gameView.ball.frame, self.self.gameView.bottomPaddle.frame))
    {
        self.dY *= -1;
    }
    
    if ((self.gameView.ball.frame.origin.x + self.gameView.ball.frame.size.width > self.view.frame.size.width) ||
        (self.gameView.ball.frame.origin.x < 0))
    {
        self.dX *= -1;
    }
}

- (void)checkIfComputerScored
{
    if (self.gameView.ball.frame.origin.y + self.gameView.ball.frame.size.height > self.view.frame.size.height){
        self.score++;
        NSLog(@"%d", self.score);
        self.gameView.topScoreCounterLabel.text = [NSString stringWithFormat:@"%d",self.score];
        [self resetGame];
    }
    
}

-(void)resetGame
{
    [self stopTimer];
    self.gameView.ball.center = self.gameView.center;
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

-(void)pauseGame
{
    if (!self.isPaused)
    {
        [self stopTimer];
        self.isPaused = YES;
        [self.gameView.pauseButton setTitle:@">" forState:UIControlStateNormal];
    }
    else
    {
        self.isPaused = NO;
        [self startTimer];
        [self.gameView.pauseButton setTitle:@"||" forState:UIControlStateNormal];
    }

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self pauseGame];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.isPaused) {
        [super viewWillAppear:animated];
        [self pauseGame];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults boolForKey:@"Speed has changed"])
        {
            self.speedMultiplier = [defaults floatForKey:@"Selected speed"];
            [self resetGame];
        }
        
        NSLog(@"Speed loaded!");
    }

}

- (void)pauseButtonPressed {
    if (!self.isPaused)
    {
        [self stopTimer];
        self.isPaused = YES;
        [self.gameView.pauseButton setTitle:@">" forState:UIControlStateNormal];
    }
    else
    {
        self.isPaused = NO;
        [self startTimer];
        [self.gameView.pauseButton setTitle:@"||" forState:UIControlStateNormal];
    }
}


@end
