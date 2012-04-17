//
//  Tuple.h
//  WireView
//
//  Created by 1 torui on 12/04/10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum cordination {
    xyz, sphere
};

@interface Tuple : NSObject {
    double x;
    double y;
    double z;
    enum cordination    type;
}

- (id)initWithX:(double)in_x Y:(double)in_y Z:(double)in_z;
- (id)initWithTuple:(Tuple*)t;
- (double)dot:(Tuple*)t;
- (Tuple*)unify;
- (Tuple*)cross:(Tuple*)t;
- (Tuple*)mul:(double)v;
- (Tuple*)add:(Tuple*)t;
- (Tuple*)sub:(Tuple*)t;
- (Tuple*)xy2sp;
- (Tuple*)sp2xy;
- (NSString*)str;
- (NSString*)strsp;

@end
