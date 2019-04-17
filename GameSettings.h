//
//  GameSettings.h
//  PingPong
//
//  Created by Anton Kuznetsov on 07/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameSettings : NSObject

@property (assign, nonatomic) double gameSpeed;
@property (assign, nonatomic) double speedMultiplier;
@property (assign, nonatomic) uint32_t score;
@property (assign, nonatomic) BOOL isPaused;

@end

