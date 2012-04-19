//
//  WVViewController.m
//  WireView
//
//  Created by 1 torui on 12/04/10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WVViewController.h"
#import "WVAppDelegate.h"

@interface WVViewController ()

@end

@implementation WVViewController
@synthesize drawview;
@synthesize poleview;
@synthesize zoomSlider;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [poleview setDrawview:drawview];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction) zoomChanged:(UISlider *)sender {
    WVAppDelegate *app = [UIApplication sharedApplication].delegate;
    //NSLog(@"ZoomSlider=%f exp(0)=%f exp(1)=%f", (double)[sender value], (double)exp(0), (double)exp(1));
    app.zoomValue = app.defaultZoomValue*exp(1.2*([sender value] - 1.0));
    [drawview setNeedsDisplay];
}

- (IBAction)controlPinch:(UIPinchGestureRecognizer *)recognizer {
    NSLog(@"zoom");
}

@end
