//
//  GameViewController.m
//  PingPong
//
//  Created by Anton Kuznetsov on 07/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gameView = [[GameView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height)];
    [self.view addSubview:self.gameView];
    self.gameView.delegate = self;
    [self.gameViewPresenter startGame];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint currentPoint = [touch locationInView:self.gameView];
    [self.gameViewPresenter movePlayerPaddleTo:currentPoint];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.gameViewPresenter togglePause];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.gameViewPresenter updateSpeed];

}

- (void)pauseButtonPressed {
    NSLog(@"togglePause");
    [self.gameViewPresenter togglePause];
}

@end
