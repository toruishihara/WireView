//
//  WVPoleView.m
//  WireView
//
//  Created by 1 torui on 12/04/13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#include <math.h>
#import "WVPoleView.h"
#import "WVAppDelegate.h"
#import "WVViewController.h"
#import "Tuple.h"

@implementation WVPoleView

@synthesize drawview;

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
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextSetLineWidth(context, 1.0);
    
    int w = [self frame].size.width;
    int h = [self frame].size.height;
    int wh = MIN(w,h);
    int r;
    for (r=10;r<wh/2;r+=10) {
        CGContextAddArc(context, wh/2, wh/2, r, 0, 2*M_PI, 0);
        CGContextStrokePath(context);
    }
    r -= 10;
    for(double th=0;th<M_PI;th+= M_PI/6) {
        double th2 = th + M_PI;
        CGContextMoveToPoint(context, wh/2 + r*cos(th), wh/2 + r*sin(th)); 
        CGContextAddLineToPoint(context, wh/2 + r*cos(th2), wh/2 + r*sin(th2)); 
        CGContextStrokePath(context);
    }
}

#pragma mark -
#pragma mark === Touch handling  ===
#pragma mark

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{    
	NSLog(@"delegate touchesBegan");
    for (UITouch *touch in touches) {
        NSLog(@"Touch %f %f", [touch locationInView:self].x, [touch locationInView:self].y);
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{  
	NSLog(@"delegate touchesMoved");
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    WVAppDelegate *app = [UIApplication sharedApplication].delegate;

    Tuple *inc = [[Tuple alloc] initWithX:0.1 Y:0.2 Z:0.3];
    [[app.poleUnitZ add:inc] setLength:1.0];
    app.poleUnitY = [[app.poleUnitZ cross:[[Tuple alloc]initWithX:1.0 Y:0.0 Z:0.0]] setLength:1.0];
    app.poleUnitX = [app.poleUnitY cross:app.poleUnitZ];
    
    [drawview setNeedsDisplay];
}

@end
