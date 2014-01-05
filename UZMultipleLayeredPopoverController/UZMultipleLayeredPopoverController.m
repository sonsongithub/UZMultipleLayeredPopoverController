//
//  UZMultipleLayeredPopoverController.m
//  UZMultipleLayeredPopoverController
//
//  Created by sonson on 2014/01/02.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import "UZMultipleLayeredPopoverController.h"

#import "UZMultipleLayeredContentViewController.h"

#import <QuartzCore/QuartzCore.h>

@implementation UIViewController (UZMultipleLayeredPopoverController)

- (UZMultipleLayeredPopoverController*)parentMultipleLayeredPopoverController {
	UIViewController *current = self.parentViewController;
	while (1) {
		current = current.parentViewController;
		if ([current isKindOfClass:[UZMultipleLayeredPopoverController class]])
			return (UZMultipleLayeredPopoverController*)current;
		if (current == nil)
			return nil;
	}
	return nil;
}

@end

@implementation UZMultipleLayeredPopoverController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	DNSLogMethod
}

- (id)initWithRootViewController:(UIViewController*)rootViewController contentSize:(CGSize)contentSize {
	self = [super init];
	if (self) {
		_layeredControllers = [NSMutableArray array];
		UZMultipleLayeredContentViewController *object = [[UZMultipleLayeredContentViewController alloc] initWithContentViewController:rootViewController contentSize:contentSize];
		
		[_layeredControllers addObject:object];
		
		self.view.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.3];
	}
	return self;
}

- (void)presentLastChildViewControllerFromRect:(CGRect)fromRect inView:(UIView*)inView {
	
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent fromRect:(CGRect)fromRect inView:(UIView*)inView contentSize:(CGSize)contentSize {
	UZMultipleLayeredContentViewController *object = [[UZMultipleLayeredContentViewController alloc] initWithContentViewController:viewControllerToPresent contentSize:contentSize];
	[_layeredControllers addObject:object];
	
	fromRect = [self.view convertRect:fromRect fromView:inView];
	CGPoint center = CGPointMake(CGRectGetMidX(fromRect), CGRectGetMidY(fromRect));
	CGRect frame;
	frame.origin.x = center.x - object.popoverSize.width/2;
	frame.origin.y = center.y - object.popoverSize.height;
	frame.size = object.popoverSize;
	
	[self addChildViewController:object];
	[self.view addSubview:object.view];
	object.view.frame = frame;
}

- (void)presentFromRect:(CGRect)fromRect inViewController:(UIViewController*)inViewController {
	_inViewController = inViewController;
	[_inViewController addChildViewController:self];
	[_inViewController.view addSubview:self.view];
	self.view.bounds = _inViewController.view.bounds;
	
	UZMultipleLayeredContentViewController *object = [_layeredControllers lastObject];
	fromRect = [self.view convertRect:fromRect fromView:inViewController.view];
	CGPoint center = CGPointMake(CGRectGetMidX(fromRect), CGRectGetMidY(fromRect));
	CGRect frame;
	frame.origin.x = center.x - object.popoverSize.width/2;
	frame.origin.y = center.y - object.popoverSize.height;
	frame.size = object.popoverSize;
	
	[self addChildViewController:object];
	[self.view addSubview:object.view];
	object.view.frame = frame;
}

@end
