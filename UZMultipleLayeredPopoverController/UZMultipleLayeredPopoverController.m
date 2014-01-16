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

#define CGRectGetCenter(p)	CGPointMake(CGRectGetMidX(p), CGRectGetMidY(p))
#define CGSizeGetArea(p) p.width * p.height
#define CGRectFloor(p) CGRectMake(floorf(p.origin.x), floorf(p.origin.y), floorf(p.size.width), floorf(p.size.height))
#define CGSizeFloor(p) CGSizeMake(floorf(p.width), floorf(p.height))

@interface UZMultipleLayeredPopoverController() {
	UIViewController *_inViewController;
	NSMutableArray *_layeredControllers;
}
- (id)initWithRootViewController:(UIViewController*)rootViewController contentSize:(CGSize)contentSize;
- (void)presentFromRect:(CGRect)fromRect inViewController:(UIViewController*)inViewController direction:(UZMultipleLayeredPopoverDirection)direction;
- (void)presentViewController:(UIViewController *)viewControllerToPresent fromRect:(CGRect)fromRect inView:(UIView*)inView contentSize:(CGSize)contentSize direction:(UZMultipleLayeredPopoverDirection)direction;
- (void)dismiss;
- (void)dismissTopViewController;
@end

@implementation UIViewController (UZMultipleLayeredPopoverController)

- (UIViewController*)rootViewController {
	UIViewController *current = self;
	while (1) {
		if (current.parentViewController == nil)
			return current;
		current = current.parentViewController;
	}
	return nil;
}

- (UIViewController*)targetViewController {
	UIViewController *rootViewController = [self rootViewController];
	for (id vc in [rootViewController childViewControllers]) {
		if ([vc isKindOfClass:[UZMultipleLayeredPopoverController class]])
			return (UZMultipleLayeredPopoverController*)vc;
	}
	return rootViewController;
}

- (void)dismissCurrentPopoverController {
	UIViewController *con = [self targetViewController];
	if ([con isKindOfClass:[UZMultipleLayeredPopoverController class]])
		[(UZMultipleLayeredPopoverController*)con dismissTopViewController];
}

- (void)dismissMultipleLayeredPopoverController {
	UIViewController *con = [self targetViewController];
	if ([con isKindOfClass:[UZMultipleLayeredPopoverController class]])
		[(UZMultipleLayeredPopoverController*)con dismiss];
}

- (void)presentMultipleLayeredPopoverWithViewController:(UIViewController*)viewController contentSize:(CGSize)contentSize fromRect:(CGRect)fromRect inView:(UIView*)inView direction:(UZMultipleLayeredPopoverDirection)direction {
	
	UIViewController *con = [self targetViewController];
	CGRect frame = [con.view convertRect:fromRect fromView:inView];
	if ([con isKindOfClass:[UZMultipleLayeredPopoverController class]]) {
		[(UZMultipleLayeredPopoverController*)con presentViewController:viewController fromRect:frame inView:con.view contentSize:contentSize direction:direction];
	}
	else {
		UZMultipleLayeredPopoverController *popoverController = [[UZMultipleLayeredPopoverController alloc] initWithRootViewController:viewController contentSize:contentSize];
		[popoverController presentFromRect:frame inViewController:con direction:direction];
	}
}

@end

@implementation UZMultipleLayeredPopoverController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	DNSLogMethod
	UITouch *touch = [touches anyObject];
	CGPoint touchPoint = [touch locationInView:self.view];
	
	UZMultipleLayeredContentViewController *cvc = nil;
	for (UZMultipleLayeredContentViewController *vc in [_layeredControllers reverseObjectEnumerator]) {
		if (CGRectContainsPoint(vc.contentFrame, touchPoint)) {
			cvc = vc;
			break;
		}
	}
	if (cvc)
		[self removeChildViewControllersToPopoverContentViewController:cvc];
	else
		[self dismiss];
}

- (void)dismiss {
	[self.view removeFromSuperview];
	for (UIViewController *vc in _layeredControllers) {
		[vc removeFromParentViewController];
		[vc.view removeFromSuperview];
	}
	[_layeredControllers removeAllObjects];
	[self removeFromParentViewController];
}

- (void)dismissTopViewController {
	if ([_layeredControllers count] == 1) {
		[self dismiss];
	}
	else {
		UIViewController *vc = [_layeredControllers lastObject];
		[vc removeFromParentViewController];
		[vc.view removeFromSuperview];
		[_layeredControllers removeObject:vc];
		UZMultipleLayeredContentViewController *contentViewController = [_layeredControllers lastObject];
		[contentViewController setActive:YES];
	}
}

- (void)removeChildViewControllersToPopoverContentViewController:(UZMultipleLayeredContentViewController*)contentViewController {
	DNSLogMethod
	for (UIViewController *vc in [_layeredControllers reverseObjectEnumerator]) {
		if (vc == contentViewController)
			break;
		[vc removeFromParentViewController];
		[vc.view removeFromSuperview];
		[_layeredControllers removeObject:vc];
	}
	{
		UZMultipleLayeredContentViewController *contentViewController = [_layeredControllers lastObject];
		[contentViewController setActive:YES];
	}
}

- (id)initWithRootViewController:(UIViewController*)rootViewController contentSize:(CGSize)contentSize {
	if ([rootViewController isKindOfClass:[UZMultipleLayeredPopoverController class]]) {
		NSLog(@"You can not set a UZMultipleLayeredPopoverController object as the view controller on UZMultipleLayeredPopoverController objects.");
		return nil;
	}
	if ([rootViewController isKindOfClass:[UZMultipleLayeredContentViewController class]]) {
		NSLog(@"You can not set a UZMultipleLayeredContentViewController object as the view controller on UZMultipleLayeredPopoverController objects.");
		return nil;
	}
	if (!rootViewController) {
		NSLog(@"You have to set any object as the view controller on UZMultipleLayeredPopoverController objects.");
		return nil;
	}
	self = [super init];
	if (self) {
		_layeredControllers = [NSMutableArray array];
		UZMultipleLayeredContentViewController *object = [[UZMultipleLayeredContentViewController alloc] initWithContentViewController:rootViewController contentSize:contentSize];
		
		[_layeredControllers addObject:object];
		
		self.view.backgroundColor = [UIColor clearColor];
	}
	return self;
}

- (void)popoverRectWithsSecifiedContentSize:(CGSize)specifiedContentSize
						  fromRectInPopover:(CGRect)fromRectInPopover
								  direction:(UZMultipleLayeredPopoverDirection)direction
								popoverRect:(CGRect*)p1
								contentSize:(CGSize*)p2
									 offset:(float*)p3 {
	float popoverOffset = 0;
	CGRect popoverRect = CGRectZero;
	popoverRect.size = UZMultipleLayeredPopoverSizeFromContentSize(specifiedContentSize);
	CGSize contentSize = specifiedContentSize;
	
	// On the assumption that popover covers inViewController's view.
	if (direction == UZMultipleLayeredPopoverTopDirection) {
		popoverRect.origin.x = CGRectGetMidX(fromRectInPopover) - popoverRect.size.width/2;
		popoverRect.origin.y = fromRectInPopover.origin.y + fromRectInPopover.size.height - UZMultipleLayeredPopoverArrowSize;
	}
	else if (direction == UZMultipleLayeredPopoverBottomDirection) {
		popoverRect.origin.x = CGRectGetMidX(fromRectInPopover) - popoverRect.size.width/2;
		popoverRect.origin.y = fromRectInPopover.origin.y - popoverRect.size.height + UZMultipleLayeredPopoverArrowSize;
	}
	else if (direction == UZMultipleLayeredPopoverRightDirection) {
		popoverRect.origin.x = fromRectInPopover.origin.x + fromRectInPopover.size.width  - UZMultipleLayeredPopoverArrowSize;
		popoverRect.origin.y = CGRectGetMidY(fromRectInPopover) - popoverRect.size.height/2;
	}
	else if (direction == UZMultipleLayeredPopoverLeftDirection) {
		popoverRect.origin.x = fromRectInPopover.origin.x - popoverRect.size.width + UZMultipleLayeredPopoverArrowSize;
		popoverRect.origin.y = CGRectGetMidY(fromRectInPopover) - popoverRect.size.height/2;
	}
	
	// Adjust the position of baloon's arrow
	if (direction == UZMultipleLayeredPopoverTopDirection || direction == UZMultipleLayeredPopoverBottomDirection) {
		if (popoverRect.origin.x < 0) {
			popoverOffset = - (CGRectGetMidX(fromRectInPopover) - popoverRect.size.width/2);
			popoverRect.origin.x = 0;
			
			// Adjust width when right edge goes over the parent view.
			if (popoverRect.origin.x + popoverRect.size.width > self.view.frame.size.width) {
				contentSize.width -= fabsf(popoverRect.origin.x + popoverRect.size.width - self.view.frame.size.width);
				popoverRect.size = UZMultipleLayeredPopoverSizeFromContentSize(contentSize);
				popoverOffset = - (CGRectGetMidX(fromRectInPopover) - popoverRect.size.width/2);
			}
		}
		else if (popoverRect.origin.x + popoverRect.size.width > self.view.frame.size.width) {
			popoverOffset = (self.view.frame.size.width - (CGRectGetMidX(fromRectInPopover) + popoverRect.size.width/2));
			popoverRect.origin.x = (self.view.frame.size.width - popoverRect.size.width);
			
			// Adjust width when right edge goes over the parent view.
			if (popoverRect.origin.x < 0) {
				contentSize.width -= fabsf(popoverRect.origin.x);
				popoverRect.size = UZMultipleLayeredPopoverSizeFromContentSize(contentSize);
				popoverOffset = - (CGRectGetMidX(fromRectInPopover) - popoverRect.size.width/2);
				popoverRect.origin.x = 0;
			}
		}
	}
	else if (direction == UZMultipleLayeredPopoverRightDirection || direction == UZMultipleLayeredPopoverLeftDirection) {
		if (popoverRect.origin.y < 0) {
			popoverOffset = - (CGRectGetMidY(fromRectInPopover) - popoverRect.size.height/2);
			popoverRect.origin.y = 0;
			
			// Adjust width when top edge goes over the parent view.
			if (popoverRect.origin.y + popoverRect.size.height > self.view.frame.size.height) {
				contentSize.height -= fabsf(popoverRect.origin.y + popoverRect.size.height - self.view.frame.size.height);
				popoverRect.size = UZMultipleLayeredPopoverSizeFromContentSize(contentSize);
				popoverOffset = - (CGRectGetMidY(fromRectInPopover) - popoverRect.size.height/2);
			}
		}
		else if (popoverRect.origin.y + popoverRect.size.height > self.view.frame.size.height) {
			popoverOffset = (self.view.frame.size.height - (CGRectGetMidY(fromRectInPopover) + popoverRect.size.height/2));
			popoverRect.origin.y = (self.view.frame.size.height - popoverRect.size.height);
			
			// Adjust width when right edge goes over the parent view.
			if (popoverRect.origin.y < 0) {
				contentSize.height -= fabsf(popoverRect.origin.y);
				popoverRect.size = UZMultipleLayeredPopoverSizeFromContentSize(contentSize);
				popoverOffset = - (CGRectGetMidY(fromRectInPopover) - popoverRect.size.height/2);
				popoverRect.origin.y = 0;
			}
		}
	}
	
	if (direction == UZMultipleLayeredPopoverTopDirection) {
		// Adjust height when bottom edge goes over the parent view.
		if (popoverRect.origin.y + popoverRect.size.height > self.view.frame.size.height) {
			contentSize.height -= fabsf(popoverRect.origin.y + popoverRect.size.height - self.view.frame.size.height);
			popoverRect.size = UZMultipleLayeredPopoverSizeFromContentSize(contentSize);
		}
	}
	else if (direction == UZMultipleLayeredPopoverBottomDirection) {
		// Adjust height when bottom edge goes over the parent view.
		if (popoverRect.origin.y < 0) {
			contentSize.height -= fabsf(popoverRect.origin.y);
			popoverRect.size = UZMultipleLayeredPopoverSizeFromContentSize(contentSize);
			popoverRect.origin.y = 0;
		}
	}
	else if (direction == UZMultipleLayeredPopoverRightDirection) {
		// Adjust height when bottom edge goes over the parent view.
		if (popoverRect.origin.x + popoverRect.size.width > self.view.frame.size.width) {
			contentSize.width -= fabsf(popoverRect.origin.x + popoverRect.size.width - self.view.frame.size.width);
			popoverRect.size = UZMultipleLayeredPopoverSizeFromContentSize(contentSize);
		}
	}
	else if (direction == UZMultipleLayeredPopoverLeftDirection) {
		// Adjust height when bottom edge goes over the parent view.
		if (popoverRect.origin.x < 0) {
			contentSize.width -= fabsf(popoverRect.origin.x);
			popoverRect.size = UZMultipleLayeredPopoverSizeFromContentSize(contentSize);
			popoverRect.origin.x = 0;
		}
	}
	*p1 = CGRectFloor(popoverRect);
	*p2 = CGSizeFloor(contentSize);
	*p3 = floorf(popoverOffset);
}

- (void)presentLastChildViewControllerFromRect:(CGRect)fromRect inView:(UIView*)inView direction:(UZMultipleLayeredPopoverDirection)direction {
	UZMultipleLayeredContentViewController *contentViewController = [_layeredControllers lastObject];
	CGRect fromRectInPopover = [self.view convertRect:fromRect fromView:inView];
	CGSize contentSize = CGSizeZero;
	CGRect popoverRect = CGRectZero;
	float popoverArrowOffset = 0;
	
	if (!(direction & UZMultipleLayeredPopoverAnyDirection))
		direction = UZMultipleLayeredPopoverAnyDirection;
	
	if (direction != UZMultipleLayeredPopoverAnyDirection && direction != UZMultipleLayeredPopoverVerticalDirection && direction != UZMultipleLayeredPopoverHorizontalDirection) {
		[self popoverRectWithsSecifiedContentSize:contentViewController.contentSize
								fromRectInPopover:fromRectInPopover
										direction:direction
									  popoverRect:&popoverRect
									  contentSize:&contentSize
										   offset:&popoverArrowOffset];
		contentViewController.direction = direction;
		contentViewController.contentSize = contentSize;
		contentViewController.baseView.popoverArrowOffset = popoverArrowOffset;
	}
	else {
		// calculate the frames for all directions
		// select the direction whose frame is the largest square in them.
		CGRect popoverRects[4];
		CGSize contentSizes[4];
		float popoverArrowOffsets[4];
		UZMultipleLayeredPopoverDirection directions[] = {
			UZMultipleLayeredPopoverBottomDirection,
			UZMultipleLayeredPopoverTopDirection,
			UZMultipleLayeredPopoverRightDirection,
			UZMultipleLayeredPopoverLeftDirection
		};
		for (int i = 0; i < 4; i++) {
			if (directions[i] & direction) {
				[self popoverRectWithsSecifiedContentSize:contentViewController.contentSize
										fromRectInPopover:fromRectInPopover
												direction:directions[i]
											  popoverRect:&popoverRects[i]
											  contentSize:&contentSizes[i]
												   offset:&popoverArrowOffsets[i]];
			}
			else {
				popoverArrowOffsets[i] = 0;
				popoverRects[i] = CGRectZero;
				contentSizes[i] = CGSizeZero;
			}
		}
		int saved = 0;
		float maxArea = CGSizeGetArea(contentSizes[0]);
		for (int i = 1; i < 4; i++) {
			float area = CGSizeGetArea(contentSizes[i]);
			if (maxArea < area) {
				maxArea = area;
				saved = i;
			}
		}
		contentViewController.direction = directions[saved];
		contentViewController.contentSize = contentSizes[saved];
		contentViewController.baseView.popoverArrowOffset = popoverArrowOffsets[saved];
		popoverRect = popoverRects[saved];
	}
	
	// deactivate view controllers without the top level view controller.
	for (UZMultipleLayeredContentViewController *vc in _layeredControllers) {
		if (vc != contentViewController)
			[vc setActive:NO];
	}
	
	// add the new top level view controller
	[self addChildViewController:contentViewController];
	[self.view addSubview:contentViewController.view];
	contentViewController.view.frame = popoverRect;
	[contentViewController setActive:YES];
	[contentViewController updateSubviews];
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent fromRect:(CGRect)fromRect inView:(UIView*)inView contentSize:(CGSize)contentSize direction:(UZMultipleLayeredPopoverDirection)direction {
	UZMultipleLayeredContentViewController *viewController = [[UZMultipleLayeredContentViewController alloc] initWithContentViewController:viewControllerToPresent contentSize:contentSize];
	[_layeredControllers addObject:viewController];
	[self presentLastChildViewControllerFromRect:fromRect inView:inView direction:direction];
}

- (void)presentFromRect:(CGRect)fromRect inViewController:(UIViewController*)inViewController direction:(UZMultipleLayeredPopoverDirection)direction {
	_inViewController = inViewController;
	[_inViewController addChildViewController:self];
	self.view.frame = _inViewController.view.bounds;
	[_inViewController.view addSubview:self.view];
	
	[self presentLastChildViewControllerFromRect:fromRect inView:inViewController.view direction:direction];
}

@end
