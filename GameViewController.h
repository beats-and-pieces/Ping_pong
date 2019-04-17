//
//  GameViewController.h
//  PingPong
//
//  Created by Anton Kuznetsov on 07/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameViewDelegate.h"
#import "GameView.h"
#import "GameViewPresenter.h"

@class GameViewPresenter;

@interface GameViewController : UIViewController <GameViewDelegate>

@property (strong, nonatomic) GameView *gameView;
@property (strong, nonatomic) GameViewPresenter *gameViewPresenter;

@end

