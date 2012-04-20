//
//  WVTLSfile.m
//  WireView
//
//  Created by 1 torui on 12/04/12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WVSTLfile.h"
#import "WVAppDelegate.h"
#import "NSString+Chop.h"

@implementation WVSTLfile

+ (void)read
{
    @try {
        double max[3] = {-1*MAXFLOAT, -1*MAXFLOAT, -1*MAXFLOAT};
        double min[3] = {MAXFLOAT, MAXFLOAT, MAXFLOAT};
        NSString *path = [[NSBundle mainBundle] pathForResource:@"diamond" ofType:@"stl"];
        //NSLog([path substringToIndex:100]);
        //NSLog([path substringFromIndex:100]);
 
        NSString *s = [NSString stringWithContentsOfFile:path usedEncoding:nil error:nil];
        NSArray *texts = [s componentsSeparatedByString: @"\n"];
        
        NSString* oneLine;
        NSEnumerator *enum1 = [texts objectEnumerator];
        
        while (oneLine = [enum1 nextObject]) {
            [oneLine chopExtraSpace];
            NSArray *arr = [oneLine componentsSeparatedByCharactersInSet:
                            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            int idx = [arr indexOfObject:@"vertex"];
            if (idx >=0 && idx < [arr count]) {
                double x = [[arr objectAtIndex:idx+1] doubleValue];
                double y = [[arr objectAtIndex:idx+2] doubleValue];
                double z = [[arr objectAtIndex:idx+3] doubleValue];
                max[0] = MAX(max[0], x);
                max[1] = MAX(max[1], y);
                max[2] = MAX(max[2], z);
                min[0] = MIN(min[0], x);
                min[1] = MIN(min[1], y);
                min[2] = MIN(min[2], z);
            }
        }
        double maxXYZ = MAX(MAX(max[0]-min[0], max[1]-min[1]),max[2]-min[2]);
        Tuple *center = [[Tuple alloc] initWithX:(max[0]+min[0])/2.0 Y:(max[1]+min[1])/2.0 Z:(max[2]+min[2])/2.0];

        NSEnumerator *enum2 = [texts objectEnumerator];
        NSMutableArray *ma = [[NSMutableArray alloc]initWithCapacity:2000];
        
        while (oneLine = [enum2 nextObject]) {
            [oneLine chopExtraSpace];
            NSArray *arr = [oneLine componentsSeparatedByCharactersInSet:
                            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            int idx = [arr indexOfObject:@"vertex"];
            if (idx >=0 && idx < [arr count]) {
                double x = [[arr objectAtIndex:idx+1] doubleValue];
                double y = [[arr objectAtIndex:idx+2] doubleValue];
                double z = [[arr objectAtIndex:idx+3] doubleValue];
                Tuple *tuple = [[Tuple alloc]initWithX:(double)x Y:(double)y Z:(double)z];
                [[tuple sub:center] mul:UINT16_MAX/maxXYZ];
                TupleInt *tupleInt = [[TupleInt alloc] initWithTuple:tuple];
                [ma addObject:tupleInt];
            }
        }
        WVAppDelegate *app = [UIApplication sharedApplication].delegate;
        app.triangles = [[NSArray alloc]initWithArray:ma];
        app.defaultZoomValue = 1.0;
        app.zoomValue = 1.0;
    }
    @catch (NSException *e) {
        NSLog(@"err=%@",e.name);
        
    }
    @finally {
        
    }

}


@end
