//
//  SettingsViewController.h
//  PingPong
//
//  Created by Anton Kuznetsov on 09/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewDelegate.h"

@interface SettingsViewController : UIViewController <SettingsViewDelegate>

@property (assign, nonatomic) double sliderValue;

@end
