//
//  GameViewPresenter.h
//  PingPong
//
//  Created by Anton Kuznetsov on 07/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameViewPresenterProtocol.h"
#import "GameViewController.h"
#import "GameSettings.h"


@interface GameViewPresenter : NSObject <GameViewPresenterProtocol>

@property (assign, nonatomic) GameViewController *gameViewController;

- (instancetype)initForAView:(GameViewController *) viewController withSettings:(GameSettings *)settings;

- (void)togglePause;
- (void)updateSpeed;
- (void)movePlayerPaddleTo:(CGPoint) currentPoint;

@end

