//
//  SettingsViewPresenterProtocol.h
//  PingPong
//
//  Created by Anton Kuznetsov on 17/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "SettingsViewController.h"

@class SettingsViewController;
@protocol SettingsViewPresenterProtocol <NSObject>

@property (assign, nonatomic) SettingsViewController *settingsViewController;

- (void)saveSpeed;
- (void)loadSpeed;

@end
