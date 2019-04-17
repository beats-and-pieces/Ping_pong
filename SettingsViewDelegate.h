//
//
//  SettingsViewDelegate.h
//  PingPong
//
//  Created by Anton Kuznetsov on 17/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//



@protocol SettingsViewDelegate <NSObject>

@property (assign, nonatomic) double sliderValue;

//- (double)sliderValue;
- (void)saveSpeed;


@end
