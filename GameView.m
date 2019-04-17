//
//  GameView.m
//  PingPong
//
//  Created by Anton Kuznetsov on 17/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "GameView.h"
#import "PaddleView.h"
#import "BallView.h"

@interface GameView ()



@property (assign, nonatomic) CGFloat ballDiameter;
@property (assign, nonatomic) CGFloat paddleWidth;
@property (assign, nonatomic) CGFloat paddleHeight;

@end

@implementation GameView

- (void)loadUISettings
{
    self.ballDiameter = 25.0f;
    self.paddleWidth = 100;
    self.paddleHeight = 20;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUISettings]; 
        self.backgroundColor = [UIColor whiteColor];
        self.autoresizesSubviews = NO;
        [self createPaddles];
        [self createBall];
        [self createScoreLabels];
        [self createPauseButton];
        
    }
    return self;
}

- (void)createPaddles
{
    self.topPaddle = [[PaddleView alloc] initWithPositionForAView:self isTop:YES withWidth:self.paddleWidth withHeight:self.paddleHeight];
    self.bottomPaddle = [[PaddleView alloc] initWithPositionForAView:self isTop:NO withWidth:self.paddleWidth withHeight:self.paddleHeight];
    
    [self addSubview:self.topPaddle];
    [self addSubview:self.bottomPaddle];
}

- (void)createBall
{
        self.ball = [[BallView alloc] initWithDiameter:self.ballDiameter];

    [self addSubview:self.ball];

}


- (void)createScoreLabels
{
    self.topScoreCounterLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 16, 200, 50)];
    self.topScoreCounterLabel.textColor = [UIColor greenColor];
    self.topScoreCounterLabel.text = @"0";
    
    self.bottomScoreCounterLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 48, 200, 50)];
    self.bottomScoreCounterLabel.textColor = [UIColor blueColor];
    self.bottomScoreCounterLabel.text = @"0";
    
    [self addSubview:self.topScoreCounterLabel];
    [self addSubview:self.bottomScoreCounterLabel];
}

- (void)createPauseButton
{
    self.pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.pauseButton.frame = CGRectMake(CGRectGetWidth(self.frame) - 16.0 - 50, 32.0, 50.0, 50.0);
    self.pauseButton.backgroundColor = [UIColor grayColor];
    
    self.pauseButton.layer.cornerRadius = self.pauseButton.frame.size.width / 10;
    self.pauseButton.layer.borderWidth = 0.2;
    self.pauseButton.alpha = 0.5;
    self.pauseButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    [self.pauseButton setTitle:@"||" forState:UIControlStateNormal];
    [self.pauseButton addTarget:self action:@selector(pauseGame) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: self.pauseButton];
    [self sendSubviewToBack:self.pauseButton];
}

- (void)pauseGame
{
    [self.delegate pauseButtonPressed];
}

@end
