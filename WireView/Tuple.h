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
    @public
    double x;
    double y;
    double z;
    enum cordination    type;
}

- (id)init;
- (id)initWithX:(double)in_x Y:(double)in_y Z:(double)in_z;
- (id)initWithR:(double)in_r Th:(double)in_th Ph:(double)in_ph;
- (id)initWithTuple:(Tuple*)t;
- (id)initWithTupleInt:(id)t;
- (void)setX:(double)in_x Y:(double)in_y Z:(double)in_z;
- (void)setR:(double)in_r Th:(double)in_th Ph:(double)in_ph;
- (double)dot:(Tuple*)t;
- (Tuple*)setLength:(double)length;
- (Tuple*)cross:(Tuple*)t;
- (Tuple*)mul:(double)v;
- (Tuple*)add:(Tuple*)t;
- (Tuple*)sub:(Tuple*)t;
- (Tuple*)xy2sp;
- (Tuple*)sp2xy;
- (NSString*)str;

@end

@interface TupleInt : NSObject {
    @public
    int x;
    int y;
    int z;
    enum cordination    type;
}

- (id)init;
- (id)initWithX:(int)in_x Y:(int)in_y Z:(int)in_z;
- (id)initWithR:(int)in_r Th:(int)in_th Ph:(int)in_ph;
- (id)initWithTuple:(Tuple*)t;
- (id)initWithTupleInt:(TupleInt*)t;
- (id)copyValue:(TupleInt*)t;
- (void)setX:(int)in_x Y:(int)in_y Z:(int)in_z;
- (void)setR:(int)in_r Th:(int)in_th Ph:(int)in_ph;
- (int)dot:(TupleInt*)t;
- (TupleInt*)setLength:(int)length;
- (TupleInt*)cross:(TupleInt*)t;
- (TupleInt*)mul:(int)v;
- (TupleInt*)add:(TupleInt*)t;
- (TupleInt*)sub:(TupleInt*)t;
- (TupleInt*)xy2sp;
- (TupleInt*)sp2xy;
- (NSString*)str;

@end
