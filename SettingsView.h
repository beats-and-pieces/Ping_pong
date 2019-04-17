//
//  SettingsView.h
//  PingPong
//
//  Created by Anton Kuznetsov on 17/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettingsView : UIView

@property (nonatomic, weak, nullable) id<SettingsViewDelegate> delegate;
@property (nonatomic, strong) UISlider *slider;

@end

NS_ASSUME_NONNULL_END
