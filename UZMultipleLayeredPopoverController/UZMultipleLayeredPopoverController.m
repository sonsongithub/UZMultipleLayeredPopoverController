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
	UZMultipleLayeredContentViewController *viewController = [_layeredControllers lastObject];
	
	CGRect fromRectInPopover = [self.view convertRect:fromRect fromView:inView];
	
	CGPoint center = CGPointMake(CGRectGetMidX(fromRectInPopover), CGRectGetMidY(fromRectInPopover));
	
	CGPoint centerInBaseView = [_inViewController.view convertPoint:center fromView:self.view];
	
	CGRect frameOfViewControllerInBaseView = [_inViewController.view convertRect:_inViewController.view.frame fromView:self.view];
	
	CGRect frame;
	frame.size = viewController.popoverSize;
	
	frame.origin.x = center.x - viewController.popoverSize.width/2;
	frame.origin.y = center.y - viewController.popoverSize.height + UZMultipleLayeredPopoverArrowSize;
	viewController.baseView.direction = UZMultipleLayeredPopoverBottomDirection;
	if (centerInBaseView.y - frame.size.height < 0) {
		CGSize s = viewController.contentSize;
		s.height -= fabsf(centerInBaseView.y - frame.size.height);
		viewController.contentSize = s;
		frame.origin.y += fabsf(centerInBaseView.y - frame.size.height);
		frame.size.height -= fabsf(centerInBaseView.y - frame.size.height);
	}
	if (frame.origin.x < 0) {
		viewController.baseView.popoverOffset = -frame.origin.x;
		frame.origin.x = 0;
	}
	else if (frame.origin.x + frame.size.width > frameOfViewControllerInBaseView.size.width) {
		viewController.baseView.popoverOffset = frameOfViewControllerInBaseView.size.width - (frame.origin.x + frame.size.width);
		frame.origin.x = (frameOfViewControllerInBaseView.size.width - frame.size.width);
	}
	
	[self addChildViewController:viewController];
	[self.view addSubview:viewController.view];
	viewController.view.frame = frame;
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent fromRect:(CGRect)fromRect inView:(UIView*)inView contentSize:(CGSize)contentSize {
	UZMultipleLayeredContentViewController *viewController = [[UZMultipleLayeredContentViewController alloc] initWithContentViewController:viewControllerToPresent contentSize:contentSize];
	[_layeredControllers addObject:viewController];
	
	[self presentLastChildViewControllerFromRect:fromRect inView:inView];
}

- (void)presentFromRect:(CGRect)fromRect inViewController:(UIViewController*)inViewController {
	_inViewController = inViewController;
	[_inViewController addChildViewController:self];
	[_inViewController.view addSubview:self.view];
	self.view.bounds = _inViewController.view.bounds;
	
	[self presentLastChildViewControllerFromRect:fromRect inView:inViewController.view];
}

@end
