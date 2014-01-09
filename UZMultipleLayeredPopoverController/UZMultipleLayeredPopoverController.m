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
	[self.view removeFromSuperview];
	for (UIViewController *vc in _layeredControllers) {
		[vc removeFromParentViewController];
		[vc.view removeFromSuperview];
	}
	[_layeredControllers removeAllObjects];
	[self removeFromParentViewController];
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

- (void)popoverRectWithsSecifiedContentSize:(CGSize)specifiedContentSize
				  centerOfFromRectInPopover:(CGPoint)centerOfFromRectInPopover
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
		popoverRect.origin.x = centerOfFromRectInPopover.x - popoverRect.size.width/2;
		popoverRect.origin.y = centerOfFromRectInPopover.y - UZMultipleLayeredPopoverArrowSize;
	}
	else if (direction == UZMultipleLayeredPopoverBottomDirection) {
		popoverRect.origin.x = centerOfFromRectInPopover.x - popoverRect.size.width/2;
		popoverRect.origin.y = centerOfFromRectInPopover.y - popoverRect.size.height + UZMultipleLayeredPopoverArrowSize;
	}
	else if (direction == UZMultipleLayeredPopoverRightDirection) {
		popoverRect.origin.x = centerOfFromRectInPopover.x - UZMultipleLayeredPopoverArrowSize;
		popoverRect.origin.y = centerOfFromRectInPopover.y - popoverRect.size.height/2;
	}
	else if (direction == UZMultipleLayeredPopoverLeftDirection) {
		popoverRect.origin.x = centerOfFromRectInPopover.x - popoverRect.size.width + UZMultipleLayeredPopoverArrowSize;
		popoverRect.origin.y = centerOfFromRectInPopover.y - popoverRect.size.height/2;
	}
	
	// Adjust the position of baloon's arrow
	if (direction == UZMultipleLayeredPopoverTopDirection || direction == UZMultipleLayeredPopoverBottomDirection) {
		if (popoverRect.origin.x < 0) {
			popoverOffset = - (centerOfFromRectInPopover.x - popoverRect.size.width/2);
			popoverRect.origin.x = 0;

			// Adjust width when right edge goes over the parent view.
			if (popoverRect.origin.x + popoverRect.size.width > self.view.frame.size.width) {
				contentSize.width -= fabsf(popoverRect.origin.x + popoverRect.size.width - self.view.frame.size.width);
				popoverRect.size = UZMultipleLayeredPopoverSizeFromContentSize(contentSize);
				popoverOffset = - (centerOfFromRectInPopover.x - popoverRect.size.width/2);
			}
		}
		else if (popoverRect.origin.x + popoverRect.size.width > self.view.frame.size.width) {
			popoverOffset = (self.view.frame.size.width - (centerOfFromRectInPopover.x + popoverRect.size.width/2));
			popoverRect.origin.x = (self.view.frame.size.width - popoverRect.size.width);

			// Adjust width when right edge goes over the parent view.
			if (popoverRect.origin.x < 0) {
				contentSize.width -= fabsf(popoverRect.origin.x);
				popoverRect.size = UZMultipleLayeredPopoverSizeFromContentSize(contentSize);
				popoverOffset = - (centerOfFromRectInPopover.x - popoverRect.size.width/2);
				popoverRect.origin.x = 0;
			}
		}
	}
	else if (direction == UZMultipleLayeredPopoverRightDirection || direction == UZMultipleLayeredPopoverLeftDirection) {
		if (popoverRect.origin.y < 0) {
			popoverOffset = - (centerOfFromRectInPopover.y - popoverRect.size.height/2);
			popoverRect.origin.y = 0;
			
			// Adjust width when top edge goes over the parent view.
			if (popoverRect.origin.y + popoverRect.size.height > self.view.frame.size.height) {
				contentSize.height -= fabsf(popoverRect.origin.y + popoverRect.size.height - self.view.frame.size.height);
				popoverRect.size = UZMultipleLayeredPopoverSizeFromContentSize(contentSize);
				popoverOffset = - (centerOfFromRectInPopover.y - popoverRect.size.height/2);
			}
		}
		else if (popoverRect.origin.y + popoverRect.size.height > self.view.frame.size.height) {
			popoverOffset = (self.view.frame.size.height - (centerOfFromRectInPopover.y + popoverRect.size.height/2));
			popoverRect.origin.y = (self.view.frame.size.height - popoverRect.size.height);
			
			// Adjust width when right edge goes over the parent view.
			if (popoverRect.origin.y < 0) {
				contentSize.height -= fabsf(popoverRect.origin.y);
				popoverRect.size = UZMultipleLayeredPopoverSizeFromContentSize(contentSize);
				popoverOffset = - (centerOfFromRectInPopover.y - popoverRect.size.height/2);
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
	
	*p1 = popoverRect;
	*p2 = contentSize;
	*p3 = popoverOffset;
}

- (void)presentLastChildViewControllerFromRect:(CGRect)fromRect inView:(UIView*)inView direction:(UZMultipleLayeredPopoverDirection)direction {
	UZMultipleLayeredContentViewController *contentViewController = [_layeredControllers lastObject];
	CGPoint centerOfFromRectInPopover = CGRectGetCenter([self.view convertRect:fromRect fromView:inView]);
	CGSize contentSize = CGSizeZero;
	CGRect popoverRect = CGRectZero;
	float popoverArrowOffset = 0;
	if (direction != UZMultipleLayeredPopoverAnyDirection) {
		[self popoverRectWithsSecifiedContentSize:contentViewController.contentSize
						centerOfFromRectInPopover:centerOfFromRectInPopover
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
			UZMultipleLayeredPopoverTopDirection,
			UZMultipleLayeredPopoverBottomDirection,
			UZMultipleLayeredPopoverRightDirection,
			UZMultipleLayeredPopoverLeftDirection
		};
		for (int i = 1; i < 4; i++) {
			[self popoverRectWithsSecifiedContentSize:contentViewController.contentSize
							centerOfFromRectInPopover:centerOfFromRectInPopover
											direction:directions[i]
										  popoverRect:&popoverRects[i]
										  contentSize:&contentSizes[i]
											   offset:&popoverArrowOffsets[i]];
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
	[self addChildViewController:contentViewController];
	[self.view addSubview:contentViewController.view];
	contentViewController.view.frame = popoverRect;
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent fromRect:(CGRect)fromRect inView:(UIView*)inView contentSize:(CGSize)contentSize direction:(UZMultipleLayeredPopoverDirection)direction {
	UZMultipleLayeredContentViewController *viewController = [[UZMultipleLayeredContentViewController alloc] initWithContentViewController:viewControllerToPresent contentSize:contentSize];
	[_layeredControllers addObject:viewController];
	[self presentLastChildViewControllerFromRect:fromRect inView:inView direction:direction];
}

- (void)presentFromRect:(CGRect)fromRect inViewController:(UIViewController*)inViewController direction:(UZMultipleLayeredPopoverDirection)direction {
	_inViewController = inViewController;
	[_inViewController addChildViewController:self];
	[_inViewController.view addSubview:self.view];
	self.view.frame = _inViewController.view.bounds;
	
	[self presentLastChildViewControllerFromRect:fromRect inView:inViewController.view direction:direction];
}

@end
