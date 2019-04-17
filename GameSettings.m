//
//  GameSettings.m
//  PingPong
//
//  Created by Anton Kuznetsov on 07/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "GameSettings.h"

@implementation GameSettings

- (instancetype)init
{    
    self.gameSpeed = 0.005f;
    self.speedMultiplier = 1.0f;
    self.score = 0;
    self.isPaused = NO;
    return self;
}

@end
