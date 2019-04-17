//
//  SettingsViewPresenter.m
//  PingPong
//
//  Created by Anton Kuznetsov on 07/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "SettingsViewPresenter.h"

@interface SettingsViewPresenter ()

@end

@implementation SettingsViewPresenter

- (instancetype)initForAView:(SettingsViewController *) viewController
{
    self.settingsViewController = viewController;
    return self;
}

- (void)loadSpeed
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:self.settingsViewController.sliderValue forKey:@"Selected speed"];
}

- (void)saveSpeed
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:self.settingsViewController.sliderValue forKey:@"Selected speed"];
    NSLog(@"speed now is %f", self.settingsViewController.sliderValue);
}

@end
