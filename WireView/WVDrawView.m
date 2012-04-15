//
//  WVDrawView.m
//  WireView
//
//  Created by 1 torui on 12/04/10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WVDrawView.h"

@implementation WVDrawView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context    = UIGraphicsGetCurrentContext();

    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);

    CGContextSetLineWidth(context, 1.0);

    for (int i=0;i<1000;++i) {
        CGContextMoveToPoint(context, i/100,i/200); //start at this point
        CGContextAddLineToPoint(context, i%300, i%400); //draw to this point
        CGContextStrokePath(context);
    }
}

@end
