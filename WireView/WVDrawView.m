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
    double zoom = app.zoomValue;
    int j=0;
    for (id i in app.triangles) {
        tuples[j%3] = [[Tuple alloc]initWithTuple:i];
        [tuples[j%3] sub:app.centerPoint];
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

#pragma mark -
#pragma mark === Touch handling  ===
#pragma mark
-(void)moveViewPole:(NSSet *)touches
{
    WVAppDelegate *app = [UIApplication sharedApplication].delegate;
    int width = [self bounds].size.width;
    double x, y;
    for (UITouch *touch in touches) {
        x = [touch locationInView:self].x - width/2;
        x /= (double)(width/4);
        y = [touch locationInView:self].y - width/2;
        y *= -1.0;
        y /= (double)(width/4);
        [app.poleUnitZ initWithR:1.0 Th:atan2(y,x) Ph:sqrt(x*x + y*y)*M_PI_2];
        [app.poleUnitZ sp2xy];
        app.poleUnitY = [[app.poleUnitZ cross:[[Tuple alloc]initWithX:1.0 Y:0.0 Z:0.0]] unify];
        app.poleUnitX = [app.poleUnitY cross:app.poleUnitZ];
    }
    [self setNeedsDisplay];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{    
    [self moveViewPole:touches];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{  
    [self moveViewPole:touches];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}

@end
