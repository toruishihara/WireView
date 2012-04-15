//
//  WVt1.m
//  WireView
//
//  Created by 1 torui on 12/04/10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WVTuple.h"

@implementation WVTuple : NSObject

-(id)initWithX:(double)in_x Y:(double)in_y Z:(double)in_z
{
    self = [super init];
	x = in_x;
	y = in_y;
	z = in_z;
    type = 0;
    return self;
}

-(double)dot:(WVTuple*)t1 {
	return x*t1->x + y*t1->y + z*t1->z;
}

-(void)unify {
	double len2 = x*x + y*y + z*z;
	double len = sqrt(len2);
	x = x / len;
	y = y / len;
	z = z / len;
}

-(id)cross:(WVTuple*)t1 {
	double x0 = y*t1->z - z*t1->y;
	double y0 = z*t1->x - x*t1->z;
	double z0 = x*t1->y - y*t1->x;
    WVTuple* ret = [[WVTuple alloc] initWithX:x0 Y:y0 Z:z0];
    return ret;
}
-(WVTuple*)mul:(double)v {
	x *= v;
	y *= v;
	z *= v;
    return self;
}
-(WVTuple*)add:(WVTuple*)t1 {
	x = x + t1->x;
	y = y + t1->y;
	z = z + t1->z;
    return self;
}
-(WVTuple*)sub:(WVTuple *)t1 {
	x = x - t1->x;
	y = y - t1->y;
	z = z - t1->z;
    return self;
}
-(WVTuple*)sp2xy {
	double r = x;
	double th = y;
	double ph = z;
	x = r*cos(th)*sin(ph);
	y = r*sin(th)*sin(ph);
	z = r*cos(ph);
    return self;
}
-(WVTuple*)xy2sp {
	double r = sqrt(x*x + y*y + z*z);
	double th = atan(y/x);
	double ph = acos(z/r);
	x = r;
	y = th;
	z = ph;
    return self;
}
-(NSString*)str {
    if (type == 0) {
        return [[NSString alloc] initWithFormat:@"xyz[%f,%f,%f]", x, y, z];
    }
}
-(NSString*)strsp {
    if (type == 1) {
        return [[NSString alloc] initWithFormat:@"sp[%f,%f,%f]", x, y, z];
    }
}

@end
