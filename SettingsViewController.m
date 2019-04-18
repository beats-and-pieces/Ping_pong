//
//  SettingsViewController.m
//  PingPong
//
//  Created by Anton Kuznetsov on 09/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsView.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    SettingsView *settingsView = [[SettingsView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview: settingsView];
    settingsView.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.settingsViewPresenter loadSpeed];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:self.sliderValue forKey:@"Selected speed"];
    self.settingsView.slider.value = self.sliderValue;

}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.settingsViewPresenter saveSpeed];
}

@end
