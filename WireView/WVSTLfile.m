//
//  WVTLSfile.m
//  WireView
//
//  Created by 1 torui on 12/04/12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WVSTLfile.h"
#import "WVAppDelegate.h"

@implementation WVSTLfile


+ (void)read
{
    @try {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"diamond" ofType:@"txt"];
        //NSLog([path substringToIndex:100]);
        //NSLog([path substringFromIndex:100]);
 
        NSString *s = [NSString stringWithContentsOfFile:path usedEncoding:nil error:nil];
        NSArray *texts = [s componentsSeparatedByString: @"\n"];
        NSEnumerator *enum0 = [texts objectEnumerator];
        
        NSString* ln;
        NSEnumerator *enum1 = [texts objectEnumerator];
        NSMutableArray *ma = [[NSMutableArray alloc]initWithCapacity:2000];
        
        while (ln = [enum1 nextObject]) {
            //NSLog(ln);
            NSArray *arr = [ln componentsSeparatedByCharactersInSet:
                            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            //NSLog(@"arr=%@", arr);
            int idx = [arr indexOfObject:@"vertex"];
            if (idx >=0 && idx < [arr count]) {
                    NSLog(@"vt[%@ %@ %@]", [arr objectAtIndex:idx+1], [arr objectAtIndex:idx+2],
                          [arr objectAtIndex:idx+3]);
                double x = [[arr objectAtIndex:idx+1] doubleValue];
                double y = [[arr objectAtIndex:idx+2] doubleValue];
                double z = [[arr objectAtIndex:idx+3] doubleValue];
                Tuple *tuple = [[Tuple alloc]initWithX:(double)x Y:(double)y Z:(double)z];
                [ma addObject:tuple];
            }
        }
        WVAppDelegate *app = [UIApplication sharedApplication].delegate;
        app.triangles = [[NSArray alloc]initWithArray:ma];
    }
    @catch (NSException *e) {
        NSLog(@"err=%@",e.name);
        
    }
    @finally {
        
    }

}

@end
