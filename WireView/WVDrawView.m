//
//  WVDrawView.m
//  WireView
//
//  Created by 1 torui on 12/04/10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WVDrawView.h"
#import "WVAppDelegate.h"

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
    WVAppDelegate *app = [UIApplication sharedApplication].delegate;
    CGContextRef context    = UIGraphicsGetCurrentContext();

    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);

    CGContextSetLineWidth(context, 1.0);

    Tuple* tuples[3];
    double zoom = 40;
    int j=0;
    for (id i in app.triangles) {
        tuples[j%3] = [[Tuple alloc]initWithTuple:i];
        if (j%3 == 2) {
            double x0 = 160 + zoom*[tuples[0] dot:app.poleUnitX];
            double y0 = 160 + zoom*[tuples[0] dot:app.poleUnitY];
            double x1 = 160 + zoom*[tuples[1] dot:app.poleUnitX];
            double y1 = 160 + zoom*[tuples[1] dot:app.poleUnitY];
            double x2 = 160 + zoom*[tuples[2] dot:app.poleUnitX];
            double y2 = 160 + zoom*[tuples[2] dot:app.poleUnitY];
            CGContextMoveToPoint(context, x0, y0);
            CGContextAddLineToPoint(context, x1, y1);
            CGContextAddLineToPoint(context, x2, y2);
            CGContextAddLineToPoint(context, x0, y0);
            CGContextStrokePath(context);
        }
        ++j;
    }
}

@end
