//
//  SettingsView.m
//  PingPong
//
//  Created by Anton Kuznetsov on 17/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "SettingsView.h"


@implementation SettingsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createSlider];
        [self createLabel];
        [self createButton];
    }
    return self;
}

- (void)createSlider
{
    CGRect frame = CGRectMake(self.bounds.size.width / 2 - 100, self.bounds.size.height / 2, 200.0, 30.0);
    UISlider *slider = [[UISlider alloc] initWithFrame:frame];
    [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [slider setBackgroundColor:[UIColor clearColor]];
    slider.minimumValue = 0.5;
    slider.maximumValue = 2.0;
    slider.continuous = YES;
    slider.value = 1.0;
    [self addSubview:slider];
}

- (void)createLabel
{
    CGRect frame = CGRectMake(self.bounds.size.width / 2 - 100, self.bounds.size.height / 2 - 100, 200.0, 20.0);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Скорость игры";
    [self addSubview:label];
}

-(void)sliderAction:(id)sender
{
    UISlider *slider = (UISlider*)sender;
    float value = slider.value;
    self.delegate.sliderValue = value;
    NSLog(@"%f", value);
    
}

- (void)createButton
{
    CGRect frame = CGRectMake(self.bounds.size.width / 2 - 100, self.bounds.size.height / 2 + 100, 200.0, 30.0);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.backgroundColor = [UIColor grayColor];
    
    button.layer.cornerRadius = button.frame.size.width / 20;
    button.layer.borderWidth = 0.2;
    
    button.layer.borderColor = [UIColor blackColor].CGColor;
    
    [button setTitle:@"Сохранить" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveSpeed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: button];
}

- (void)saveSpeed
{
    [self.delegate saveSpeed];
}

@end
