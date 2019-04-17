//
//  SettingsViewController.m
//  PingPong
//
//  Created by Anton Kuznetsov on 09/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "SettingsViewController.h"
//#import "SettingsViewDelegate.h"
#import "SettingsView.h"

@interface SettingsViewController ()




//- (double)sliderValue;
- (void)saveSpeed;

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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:NO forKey:@"Speed has changed"];
}


-(void)saveSpeed
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:self.sliderValue forKey:@"Selected speed"];
    [defaults setBool:YES forKey:@"Speed has changed"];
//    [defaults synchronize];
    NSLog(@"Speed saved!");
}
@end

