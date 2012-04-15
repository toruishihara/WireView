//
//  WVTuple.h
//  WireView
//
//  Created by 1 torui on 12/04/10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WVTuple : NSObject {
    double x;
    double y;
    double z;
    char    type; // 0:xyz or 1:sphere
}

- (id)initWithX:(double)in_x Y:(double)in_y Z:(double)in_z;
- (double)dot:(WVTuple*)t1;
- (WVTuple*)unify;
- (WVTuple*)cross:(WVTuple*)t1;
- (WVTuple*)mul:(double)v;
- (WVTuple*)add:(WVTuple*)t1;
- (WVTuple*)sub:(WVTuple*)t1;
- (WVTuple*)unify;
- (WVTuple*)xy2sp;
- (WVTuple*)sp2xy;
- (NSString*)str;
- (NSString*)strsp;

@end
