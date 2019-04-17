//
//  PaddleView.m
//  PingPong
//
//  Created by Anton Kuznetsov on 07/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "PaddleView.h"

@implementation PaddleView

- (id)initWithPositionForAView:(UIView *)view isTop:(BOOL)top withWidth:(CGFloat)width withHeight:(CGFloat)height
{
    if ( self = [super init] )
    {
        if (top) {
            self.frame = CGRectMake(view.bounds.size.width / 2 - width / 2, height, width, height);
            self.backgroundColor = [UIColor greenColor];
        }
        else
        {
            self.frame = CGRectMake(view.bounds.size.width / 2 - width / 2, view.bounds.size.height - height, width, height);
            self.backgroundColor = [UIColor blueColor];
        }
        
        self.layer.cornerRadius = self.frame.size.width / 10;
        self.layer.borderWidth = 0.2;
        self.layer.borderColor = [UIColor blackColor].CGColor;
    }
    return self;
}

@end
