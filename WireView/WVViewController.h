//
//  WVViewController.h
//  WireView
//
//  Created by 1 torui on 12/04/10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WVDrawView.h"
#import "WVPoleView.h"

@interface WVViewController : UIViewController
@property (nonatomic, assign) IBOutlet WVDrawView* drawview;
@property (nonatomic, assign) IBOutlet WVPoleView* poleview;

@end
