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

@interface ViewController ()

@property (strong, nonatomic) PaddleView *bottomPaddle;
@property (strong, nonatomic) PaddleView *topPaddle;
@property (strong, nonatomic) BallView *ball;
@property (strong, nonatomic) UIView *gameField;

@property (strong, nonatomic) UILabel *topScoreCounterLabel;
@property (strong, nonatomic) UILabel *bottomScoreCounterLabel;
@property (assign, nonatomic) double currentSpeed;
@property (assign, nonatomic) double speedMultiplier;
@property (assign, nonatomic) CGFloat dX;
@property (assign, nonatomic) CGFloat dY;
@property (assign, nonatomic) CGFloat ballDiameter;
@property (assign, nonatomic) CGFloat paddleWidth;
@property (assign, nonatomic) CGFloat paddleHeight;
@property (strong, nonatomic) UIButton *pauseButton;
@property (assign, nonatomic) BOOL isPaused;
@property (assign, nonatomic) uint32_t score;
@property (strong, nonatomic) NSTimer *gameTimer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initGameField];

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
- (void)initGameField

{
    [self loadUISettings];
    self.view.backgroundColor = [UIColor whiteColor];
    self.gameField = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height)];
    self.view.autoresizesSubviews = NO;
    self.topPaddle = [[PaddleView alloc] initWithPositionForAView:self.gameField isTop:YES withWidth:self.paddleWidth withHeight:self.paddleHeight];
    self.bottomPaddle = [[PaddleView alloc] initWithPositionForAView:self.gameField isTop:NO withWidth:self.paddleWidth withHeight:self.paddleHeight];
    self.ball = [[BallView alloc] initWithDiameter:self.ballDiameter];
    
    [self.view addSubview:self.gameField];
    
    [self.gameField addSubview:self.topPaddle];
    [self.gameField addSubview:self.bottomPaddle];
    [self.gameField addSubview:self.ball];
    
    self.topScoreCounterLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 16, 200, 50)];
    self.topScoreCounterLabel.textColor = [UIColor greenColor];
    self.topScoreCounterLabel.text = @"0";
    [self.gameField addSubview:self.topScoreCounterLabel];
    self.bottomScoreCounterLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 48, 200, 50)];
    self.bottomScoreCounterLabel.textColor = [UIColor blueColor];
    self.bottomScoreCounterLabel.text = @"0";
    [self.gameField addSubview:self.bottomScoreCounterLabel];
    
    self.pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.pauseButton.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 16.0 - 50, 32.0, 50.0, 50.0);
    self.pauseButton.backgroundColor = [UIColor grayColor];
    
    self.pauseButton.layer.cornerRadius = self.pauseButton.frame.size.width / 10;
    self.pauseButton.layer.borderWidth = 0.2;
    self.pauseButton.alpha = 0.5;
    self.pauseButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    [self.pauseButton setTitle:@"||" forState:UIControlStateNormal];
    [self.pauseButton addTarget:self action:@selector(pauseGame) forControlEvents:UIControlEventTouchUpInside];
    [self.gameField addSubview: self.pauseButton];
    [self.gameField sendSubviewToBack:self.pauseButton];
    
    [self startGame];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint currentPoint = [touch locationInView:self.view];
    
    if (currentPoint.x >= self.gameField.frame.size.width - self.ballDiameter)
    {
        self.bottomPaddle.center = CGPointMake(self.gameField.frame.size.width - self.ballDiameter, self.gameField.frame.size.height - self.paddleHeight / 2);
    }
    else if (currentPoint.x <= self.ballDiameter)
    {
        self.bottomPaddle.center = CGPointMake(self.ballDiameter, self.gameField.frame.size.height - self.paddleHeight / 2);
    }
    else
    {
        self.bottomPaddle.center = CGPointMake(currentPoint.x, self.gameField.frame.size.height - self.paddleHeight / 2);
    }
}

- (void)startGame
{
    self.ball.center = self.view.center;
    self.dX = 1.0;
    self.dY = 1.0;
    
    [self startTimer];
}

- (void)moveBall
{
    if (self.ball.center.x >= self.gameField.frame.size.width - self.topPaddle.frame.size.width / 2)
    {
        self.topPaddle.center = CGPointMake(self.gameField.frame.size.width - self.paddleWidth / 2, self.paddleHeight / 2);
    }
    else if (self.ball.center.x <= self.topPaddle.frame.size.width / 2)
    {
        self.topPaddle.center = CGPointMake(self.topPaddle.frame.size.width / 2, self.paddleHeight / 2);
    }
    else
    {
        self.topPaddle.center = CGPointMake(self.ball.center.x, self.paddleHeight / 2);
    }
    
    [self bounceBallIfNeeded];
    [self checkIfComputerScored];
    self.ball.center = CGPointMake(self.ball.center.x + self.dX, self.ball.center.y + self.dY);
    
    
}

- (void)bounceBallIfNeeded
{
    if (CGRectIntersectsRect(self.ball.frame, self.topPaddle.frame) || CGRectIntersectsRect(self.ball.frame, self.bottomPaddle.frame))
    {
        self.dY *= -1;
    }
    
    if ((self.ball.frame.origin.x + self.ball.frame.size.width > self.view.frame.size.width) ||
        (self.ball.frame.origin.x < 0))
    {
        self.dX *= -1;
    }
}

- (void)checkIfComputerScored
{
    if (self.ball.frame.origin.y + self.ball.frame.size.height > self.view.frame.size.height){
        self.score++;
        NSLog(@"%d", self.score);
        self.topScoreCounterLabel.text = [NSString stringWithFormat:@"%d",self.score];
        [self resetGame];
    }
    
}

-(void)resetGame
{
    [self stopTimer];
    self.ball.center = self.view.center;
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
        [self.pauseButton setTitle:@">" forState:UIControlStateNormal];
    }
    else
    {
        self.isPaused = NO;
        [self startTimer];
        [self.pauseButton setTitle:@"||" forState:UIControlStateNormal];
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
@end
