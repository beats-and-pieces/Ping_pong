//
//  GameView.h
//  PingPong
//
//  Created by Anton Kuznetsov on 17/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameViewDelegate.h"
#import "PaddleView.h"
#import "BallView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameView : UIView

@property (nonatomic, weak, nullable) id<GameViewDelegate> delegate;

@property (strong, nonatomic) PaddleView *bottomPaddle;
@property (strong, nonatomic) PaddleView *topPaddle;
@property (strong, nonatomic) BallView *ball;
@property (strong, nonatomic) UILabel *topScoreCounterLabel;
@property (strong, nonatomic) UILabel *bottomScoreCounterLabel;
@property (strong, nonatomic) UIButton *pauseButton;

@end

NS_ASSUME_NONNULL_END
