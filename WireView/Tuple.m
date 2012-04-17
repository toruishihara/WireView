//
//  WVt1.m
//  WireView
//
//  Created by 1 torui on 12/04/10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Tuple.h"

@implementation Tuple : NSObject

- (id)initWithX:(double)in_x Y:(double)in_y Z:(double)in_z
{
    self = [super init];
	x = (double)in_x;
	y = (double)in_y;
	z = (double)in_z;
    type = xyz;
    return self;
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

- (double)dot:(Tuple*)t {
	return x*t->x + y*t->y + z*t->z;
}

- (Tuple*)unify {
	double len2 = x*x + y*y + z*z;
	double len = sqrt(len2);
    if (len < 0.00000001)
        return self;
	x = x / len;
	y = y / len;
	z = z / len;
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
    if (r < 0.000001)
        return self;
	double th = atan2(y,x);
	double ph = acos(z/r);
	x = r;
	y = th;
	z = ph;
    return self;
}
- (NSString*)str {
    if (type == 0) {
        return [[NSString alloc] initWithFormat:@"xyz[%f,%f,%f]", x, y, z];
    }
}
- (NSString*)strsp {
    if (type == 1) {
        return [[NSString alloc] initWithFormat:@"sp[%f,%f,%f]", x, y, z];
    }
}

@end
