//
//  GameViewPresenterProtocol.h
//  PingPong
//
//  Created by Anton Kuznetsov on 17/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "GameViewController.h"

@class GameViewController;
@protocol GameViewPresenterProtocol <NSObject>

@property (assign, nonatomic) GameViewController *gameViewController;

- (void)startGame;
- (void)bounceBallIfNeeded;
- (void)checkIfComputerScored;
- (void)resetGame;
- (void)startTimer;
- (void)stopTimer;
- (void)pauseGame;

@end
