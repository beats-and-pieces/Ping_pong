//
//  SettingsViewController.h
//  PingPong
//
//  Created by Anton Kuznetsov on 09/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewDelegate.h"
#import "SettingsView.h"
#import "SettingsViewPresenter.h"

@class SettingsViewPresenter;

@interface SettingsViewController : UIViewController <SettingsViewDelegate>

@property (strong, nonatomic) SettingsViewPresenter *settingsViewPresenter;

@property (assign, nonatomic) double sliderValue;
@property (strong, nonatomic) SettingsView *settingsView;

@end
