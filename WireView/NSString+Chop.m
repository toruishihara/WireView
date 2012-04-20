//
//  NSString+Chop.m
//  WireView
//
//  Created by 1 torui on 12/04/20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSString+Chop.h"

@implementation NSString (Chop)

- (NSString*)chopExtraSpace
{
    int i;
    unsigned char c;
    unsigned char last_c = 0;
    NSMutableString *str = [[NSMutableString alloc]init];
    
    for(i=0;i<[self length];++i) {
        c = [self characterAtIndex:i];
        if (c <= ' ') {
            if (last_c > ' ') {
                [str appendFormat:@" "];
            }
        } else {
            [str appendFormat:@"%c", c];
        }
        last_c = c;
    }
    
    return [NSString stringWithString:str];
}

@end
