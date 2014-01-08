//
//  TapViewController.m
//  UZMultipleLayeredPopoverController
//
//  Created by sonson on 2014/01/02.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import "TapViewController.h"
#import "UZMultipleLayeredPopoverController.h"

@interface TapViewController ()
@end

@implementation TapViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	DNSLogMethod
	DNSLog(@"%@", self.parentViewController.parentViewController);
	
	UITouch *touch = [touches anyObject];
	CGPoint touchPoint = [touch locationInView:self.view];
	
	UZMultipleLayeredPopoverController *pop = [self parentMultipleLayeredPopoverController];
	
	UIApplication *application = [UIApplication sharedApplication];
	UIViewController *vc = [application.keyWindow.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"TapViewController"];
	[pop presentViewController:vc fromRect:CGRectMake(touchPoint.x, touchPoint.y, 0, 0) inView:self.view contentSize:CGSizeMake(320, 480) direction:UZMultipleLayeredPopoverAnyDirection];
}

@end
