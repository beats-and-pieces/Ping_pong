//
//  SettingsViewController.m
//  PingPong
//
//  Created by Anton Kuznetsov on 09/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (assign, nonatomic) double selectedSpeed;

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createSlider];
    [self createLabel];
    [self createButton];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:NO forKey:@"Speed has changed"];
}

- (void)createSlider
{
    
    CGRect frame = CGRectMake(self.view.bounds.size.width / 2 - 100, self.view.bounds.size.height / 2, 200.0, 30.0);
    UISlider *slider = [[UISlider alloc] initWithFrame:frame];
    [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [slider setBackgroundColor:[UIColor clearColor]];
    slider.minimumValue = 0.5;
    slider.maximumValue = 2.0;
    slider.continuous = YES;
    slider.value = 1.0;
    [self.view addSubview:slider];
    
}

- (void)createLabel
{
    CGRect frame = CGRectMake(self.view.bounds.size.width / 2 - 100, self.view.bounds.size.height / 2 - 100, 200.0, 20.0);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Скорость игры";
    [self.view addSubview:label];
}

-(void)sliderAction:(id)sender
{
    UISlider *slider = (UISlider*)sender;
    float value = slider.value;
    self.selectedSpeed = value;
    NSLog(@"%f", value);

}
- (void)createButton
{
    CGRect frame = CGRectMake(self.view.bounds.size.width / 2 - 100, self.view.bounds.size.height / 2 + 100, 200.0, 30.0);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.backgroundColor = [UIColor grayColor];
    
    button.layer.cornerRadius = button.frame.size.width / 20;
    button.layer.borderWidth = 0.2;

    button.layer.borderColor = [UIColor blackColor].CGColor;
    
    [button setTitle:@"Сохранить" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveSpeed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: button];
}

-(void)saveSpeed
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:self.selectedSpeed forKey:@"Selected speed"];
    [defaults setBool:YES forKey:@"Speed has changed"];
    [defaults synchronize];
    NSLog(@"Speed saved!");
}
@end

