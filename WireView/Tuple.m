//
//  WVt1.m
//  WireView
//
//  Created by 1 torui on 12/04/10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Tuple.h"

@implementation Tuple : NSObject

- (id)init
{
    self = [super init];
    [self setX:0.0 Y:0.0 Z:0.0];
    return self;
}

- (id)initWithX:(double)in_x Y:(double)in_y Z:(double)in_z
{
    self = [super init];
    [self setX:in_x Y:in_y Z:in_z];
    return self;
}

- (id)initWithR:(double)in_r Th:(double)in_th Ph:(double)in_ph
{
    self = [super init];
    [self setR:in_r Th:in_th Ph:in_ph];
    return self;
}
- (void)setX:(double)in_x Y:(double)in_y Z:(double)in_z
{
	x = (double)in_x;
	y = (double)in_y;
	z = (double)in_z;
    type = xyz;
}

- (void)setR:(double)in_r Th:(double)in_th Ph:(double)in_ph
{
	x = (double)in_r;
	y = (double)in_th;
	z = (double)in_ph;
    type = sphere;
}

- (id)initWithTuple:(Tuple*)t
{
    self = [super init];
	x = t->x;
	y = t->y;
	z = t->z;
    type = t->type;
    return self;
}

- (id)initWithTupleInt:(id)t
{
    self = [super init];
    TupleInt *tupleInt = t;
	x = tupleInt->x;
	y = tupleInt->y;
	z = tupleInt->z;
    type = tupleInt->type;
    return self;
}

- (double)dot:(Tuple*)t {
	return x*t->x + y*t->y + z*t->z;
}

- (Tuple*)setLength:(double)length {
	double len2 = x*x + y*y + z*z;
	double oldLength = sqrt(len2);
    if (oldLength < 0.00000001)
        oldLength = 0.00000001;
	x *= length / oldLength;
	y *= length / oldLength;
	z *= length / oldLength;
    return self;
}

- (Tuple*)cross:(Tuple*)t {
	double tmpX = y*t->z - z*t->y;
	double tmpY = z*t->x - x*t->z;
	double tmpZ = x*t->y - y*t->x;
    Tuple* ret = [[Tuple alloc] initWithX:tmpX Y:tmpY Z:tmpZ];
    return ret;
}
- (Tuple*)clone {
    Tuple* ret = [[Tuple alloc] initWithX:x Y:y Z:z];
    return ret;
}
- (Tuple*)mul:(double)v {
	x *= v;
	y *= v;
	z *= v;
    return self;
}
- (Tuple*)add:(Tuple*)t {
	x = x + t->x;
	y = y + t->y;
	z = z + t->z;
    return self;
}
- (Tuple*)sub:(Tuple *)t {
	x = x - t->x;
	y = y - t->y;
	z = z - t->z;
    return self;
}
- (Tuple*)sp2xy {
	double r = x;
	double th = y;
	double ph = z;
	x = r*cos(th)*sin(ph);
	y = r*sin(th)*sin(ph);
	z = r*cos(ph);
    return self;
}

- (Tuple*)xy2sp {
	double r = sqrt(x*x + y*y + z*z);
    if (r < 0.000001) {
        r = 0.000001;
    }
	double th = atan2(y,x);
    double ph;
    @try {
        ph = acos(z/r);
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
	x = r;
	y = th;
	z = ph;
    return self;
}

- (NSString*)str {
    if (type == xyz) {
        return [[NSString alloc] initWithFormat:@"xyz[%f,%f,%f]", x, y, z];
    }
    if (type == sphere) {
        return [[NSString alloc] initWithFormat:@"sp[%f,%f,%f]", x, y, z];
    }
}

@end

@implementation TupleInt : NSObject

- (id)init
{
self = [super init];
[self setX:0 Y:0 Z:0];
return self;
}

- (id)initWithX:(int)in_x Y:(int)in_y Z:(int)in_z
{
    self = [super init];
    [self setX:in_x Y:in_y Z:in_z];
    return self;
}

- (id)initWithR:(int)in_r Th:(int)in_th Ph:(int)in_ph
{
    self = [super init];
    [self setR:in_r Th:in_th Ph:in_ph];
    return self;
}
- (void)setX:(int)in_x Y:(int)in_y Z:(int)in_z
{
	x = (int)in_x;
	y = (int)in_y;
	z = (int)in_z;
    type = xyz;
}

- (id)copyValue:(TupleInt *)t
{
    x = t->x;
    y = t->y;
    z = t->z;
    return self;
}

- (void)setR:(int)in_r Th:(int)in_th Ph:(int)in_ph
{
	x = (int)in_r;
	y = (int)in_th;
	z = (int)in_ph;
    type = sphere;
}

- (id)initWithTuple:(Tuple*)t
{
    self = [super init];
	x = t->x;
	y = t->y;
	z = t->z;
    type = t->type;
    return self;
}

- (id)initWithTupleInt:(TupleInt*)t
{
    self = [super init];
	x = t->x;
	y = t->y;
	z = t->z;
    type = t->type;
    return self;
}

- (int)dot:(TupleInt*)t {
	return x*t->x + y*t->y + z*t->z;
}

- (TupleInt*)setLength:(int)length {
	int len2 = x*x + y*y + z*z;
	int oldLength = sqrt(len2);
    if (oldLength == 0)
        oldLength = 1;
	x *= length / oldLength;
	y *= length / oldLength;
	z *= length / oldLength;
    return self;
}

- (TupleInt*)cross:(TupleInt*)t {
	int tmpX = y*t->z - z*t->y;
	int tmpY = z*t->x - x*t->z;
	int tmpZ = x*t->y - y*t->x;
    TupleInt* ret = [[TupleInt alloc] initWithX:tmpX Y:tmpY Z:tmpZ];
    return ret;
}
- (TupleInt*)clone {
    TupleInt* ret = [[TupleInt alloc] initWithX:x Y:y Z:z];
    return ret;
}
- (TupleInt*)mul:(int)v {
	x *= v;
	y *= v;
	z *= v;
    return self;
}
- (TupleInt*)add:(TupleInt*)t {
	x = x + t->x;
	y = y + t->y;
	z = z + t->z;
    return self;
}
- (TupleInt*)sub:(TupleInt *)t {
	x = x - t->x;
	y = y - t->y;
	z = z - t->z;
    return self;
}
- (TupleInt*)sp2xy {
	int r = x;
	int th = y;
	int ph = z;
	x = r*cos(th/(double)UINT16_MAX)*sin(ph/(double)UINT16_MAX);
	y = r*sin(th/(double)UINT16_MAX)*sin(ph/(double)UINT16_MAX);
	z = r*cos(ph/(double)UINT16_MAX);
    return self;
}

- (TupleInt*)xy2sp {
	double r = sqrt(x*x + y*y + z*z);
    if (r == 0) {
        r = 1;
    }
	int th = atan2(y,x)*UINT16_MAX;
    int ph;
    @try {
        ph = acos(z/r)*UINT16_MAX;
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
	x = r;
	y = th;
	z = ph;
    return self;
}

- (NSString*)str {
    if (type == xyz) {
        return [[NSString alloc] initWithFormat:@"xyz[%f,%f,%f]", x, y, z];
    }
    if (type == sphere) {
        return [[NSString alloc] initWithFormat:@"sp[%f,%f,%f]", x, y, z];
    }
}

@end

