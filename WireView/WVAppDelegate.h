//
//  WVAppDelegate.h
//  WireView
//
//  Created by 1 torui on 12/04/10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tuple.h"

@class WVViewController;

@interface WVAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) WVViewController *viewController;

@property (strong, nonatomic) NSArray   *triangles;
@property (strong, nonatomic) Tuple     *poleUnitZ;
@property (strong, nonatomic) Tuple     *poleUnitX;
@property (strong, nonatomic) Tuple     *poleUnitY;

@end
