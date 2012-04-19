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

    TupleInt* tuples[3];
    for(int i=0; i<3;++i) {
        tuples[i] = [[TupleInt alloc]init];
    }
    int halfWidth = rect.size.width/2;
    int halfHeight = rect.size.height/2;
    int zoom = app.zoomValue*halfWidth;
    Tuple* unitX = [[[Tuple alloc]initWithTuple:app.poleUnitX]setLength:zoom];
    Tuple* unitY = [[[Tuple alloc]initWithTuple:app.poleUnitY]setLength:zoom];
    TupleInt* unitXInt = [[TupleInt alloc]initWithTuple:unitX];
    TupleInt* unitYInt = [[TupleInt alloc]initWithTuple:unitY];
    int j=0;
    for (id i in app.triangles) {
        [tuples[j%3] copyValue:i];
        //[tuples[j%3] sub:app.centerPoint];
        if (j%3 == 2) {
            int x0 = halfWidth  + [tuples[0] dot:unitXInt]/UINT16_MAX;
            int y0 = halfHeight + [tuples[0] dot:unitYInt]/UINT16_MAX;
            int x1 = halfWidth  + [tuples[1] dot:unitXInt]/UINT16_MAX;
            int y1 = halfHeight + [tuples[1] dot:unitYInt]/UINT16_MAX;
            int x2 = halfWidth  + [tuples[2] dot:unitXInt]/UINT16_MAX;
            int y2 = halfHeight + [tuples[2] dot:unitYInt]/UINT16_MAX;
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
        app.poleUnitY = [[app.poleUnitZ cross:[[Tuple alloc]initWithX:1.0 Y:0.0 Z:0.0]] setLength:1.0];
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
