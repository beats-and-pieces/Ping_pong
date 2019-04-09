//
//  BallView.m
//  PingPong
//
//  Created by Anton Kuznetsov on 07/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "BallView.h"

@implementation BallView


- (id)initWithDiameter:(CGFloat)diameter
{
    if ( self = [super initWithFrame:CGRectMake(0.0, 0.0, diameter, diameter)] )
    {
        self.backgroundColor = [UIColor grayColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = self.frame.size.width / 2;
        self.layer.borderWidth = 0.2;
        self.layer.borderColor = [UIColor blackColor].CGColor;
    }
    return self; 
}

@end
