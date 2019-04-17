//
//  PaddleView.h
//  PingPong
//
//  Created by Anton Kuznetsov on 07/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PaddleView : UIView

- (id)initWithPositionForAView:(UIView *)view isTop:(BOOL)top withWidth:(CGFloat)width withHeight:(CGFloat)height;
@end

NS_ASSUME_NONNULL_END
