//
//  SettingsViewPresenter.h
//  PingPong
//
//  Created by Anton Kuznetsov on 07/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewPresenterProtocol.h"
#import "SettingsViewController.h"

@interface SettingsViewPresenter : NSObject <SettingsViewPresenterProtocol>
@property (assign, nonatomic) SettingsViewController *settingsViewController;

- (instancetype)initForAView:(SettingsViewController *) viewController;
- (void)saveSpeed;
- (void)loadSpeed;

@end

