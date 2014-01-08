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

CGSize popoverSizeFromContentSize(CGSize contentSize) {
	CGSize popoverSize = contentSize;
	popoverSize.width += ([UZMultipleLayeredContentViewController contentEdgeInsets].left + [UZMultipleLayeredContentViewController contentEdgeInsets].right);
	popoverSize.height += ([UZMultipleLayeredContentViewController contentEdgeInsets].top + [UZMultipleLayeredContentViewController contentEdgeInsets].bottom);
	return popoverSize;
}

- (CGRect)popoverRectForContentViewController:(UZMultipleLayeredContentViewController*)contentViewController centerOfFromRectInPopover:(CGPoint)centerOfFromRectInPopover direction:(UZMultipleLayeredPopoverDirection)direction {
	
	float popoverOffset = 0;
	CGRect popoverRect = CGRectZero;
	popoverRect.size = contentViewController.popoverSize;
	CGSize popoverSize = contentViewController.popoverSize;
	CGSize contentSize = contentViewController.contentSize;
	
	// On the assumption that popover covers inViewController's view.
	if (direction == UZMultipleLayeredPopoverTopDirection) {
		popoverRect.origin.x = centerOfFromRectInPopover.x - popoverSize.width/2;
		popoverRect.origin.y = centerOfFromRectInPopover.y - UZMultipleLayeredPopoverArrowSize;
	}
	else if (direction == UZMultipleLayeredPopoverBottomDirection) {
		popoverRect.origin.x = centerOfFromRectInPopover.x - popoverSize.width/2;
		popoverRect.origin.y = centerOfFromRectInPopover.y - popoverSize.height + UZMultipleLayeredPopoverArrowSize;
	}
	else if (direction == UZMultipleLayeredPopoverRightDirection) {
		popoverRect.origin.x = centerOfFromRectInPopover.x - UZMultipleLayeredPopoverArrowSize;
		popoverRect.origin.y = centerOfFromRectInPopover.y - popoverSize.height/2;
	}
	else if (direction == UZMultipleLayeredPopoverLeftDirection) {
		popoverRect.origin.x = centerOfFromRectInPopover.x - popoverSize.width + UZMultipleLayeredPopoverArrowSize;
		popoverRect.origin.y = centerOfFromRectInPopover.y - popoverSize.height/2;
	}
	
	// Adjust the position of baloon's arrow
	if (direction == UZMultipleLayeredPopoverTopDirection || direction == UZMultipleLayeredPopoverBottomDirection) {
		if (popoverRect.origin.x < 0) {
			popoverOffset = - (centerOfFromRectInPopover.x - popoverSize.width/2);
			popoverRect.origin.x = 0;

			// Adjust width when right edge goes over the parent view.
			if (popoverRect.origin.x + popoverRect.size.width > self.view.frame.size.width) {
				contentSize.width -= fabsf(popoverRect.origin.x + popoverRect.size.width - self.view.frame.size.width);
				popoverSize = popoverSizeFromContentSize(contentSize);
				popoverOffset = - (centerOfFromRectInPopover.x - popoverSize.width/2);
				popoverRect.size = popoverSize;
			}
		}
		else if (popoverRect.origin.x + popoverRect.size.width > self.view.frame.size.width) {
			popoverOffset = (self.view.frame.size.width - (centerOfFromRectInPopover.x + popoverSize.width/2));
			popoverRect.origin.x = (self.view.frame.size.width - popoverRect.size.width);

			// Adjust width when right edge goes over the parent view.
			if (popoverRect.origin.x < 0) {
				contentSize.width -= fabsf(popoverRect.origin.x);
				popoverSize = popoverSizeFromContentSize(contentSize);
				popoverOffset = - (centerOfFromRectInPopover.x - popoverSize.width/2);
				popoverRect.origin.x = 0;
				popoverRect.size = popoverSize;
			}
		}
	}
	else if (direction == UZMultipleLayeredPopoverRightDirection || direction == UZMultipleLayeredPopoverLeftDirection) {
		if (popoverRect.origin.y < 0) {
			popoverOffset = - (centerOfFromRectInPopover.y - popoverSize.height/2);
			popoverRect.origin.y = 0;
			
			// Adjust width when top edge goes over the parent view.
			if (popoverRect.origin.y + popoverRect.size.height > self.view.frame.size.height) {
				contentSize.height -= fabsf(popoverRect.origin.y + popoverRect.size.height - self.view.frame.size.height);
				popoverSize = popoverSizeFromContentSize(contentSize);
				popoverOffset = - (centerOfFromRectInPopover.y - popoverSize.height/2);
				popoverRect.size = popoverSize;
			}
		}
		else if (popoverRect.origin.y + popoverRect.size.height > self.view.frame.size.height) {
			popoverOffset = (self.view.frame.size.height - (centerOfFromRectInPopover.y + popoverSize.height/2));
			popoverRect.origin.y = (self.view.frame.size.height - popoverRect.size.height);
			
			// Adjust width when right edge goes over the parent view.
			if (popoverRect.origin.y < 0) {
				contentSize.height -= fabsf(popoverRect.origin.y);
				popoverSize = popoverSizeFromContentSize(contentSize);
				popoverOffset = - (centerOfFromRectInPopover.y - popoverSize.height/2);
				popoverRect.origin.y = 0;
				popoverRect.size = popoverSize;
			}
		}
	}
		
	if (direction == UZMultipleLayeredPopoverTopDirection) {
		// Adjust height when bottom edge goes over the parent view.
		if (popoverRect.origin.y + popoverRect.size.height > self.view.frame.size.height) {
			contentSize.height -= fabsf(popoverRect.origin.y + popoverRect.size.height - self.view.frame.size.height);
			popoverSize = popoverSizeFromContentSize(contentSize);
			popoverRect.size = popoverSize;
		}
	}
	else if (direction == UZMultipleLayeredPopoverBottomDirection) {
		// Adjust height when bottom edge goes over the parent view.
		if (popoverRect.origin.y < 0) {
			contentSize.height -= fabsf(popoverRect.origin.y);
			popoverSize = popoverSizeFromContentSize(contentSize);
			popoverRect.origin.y = 0;
			popoverRect.size = popoverSize;
		}
	}
	else if (direction == UZMultipleLayeredPopoverRightDirection) {
		// Adjust height when bottom edge goes over the parent view.
		if (popoverRect.origin.x + popoverRect.size.width > self.view.frame.size.width) {
			contentSize.width -= fabsf(popoverRect.origin.x + popoverRect.size.width - self.view.frame.size.width);
			popoverSize = popoverSizeFromContentSize(contentSize);
			popoverRect.size = popoverSize;
		}
	}
	else if (direction == UZMultipleLayeredPopoverLeftDirection) {
		// Adjust height when bottom edge goes over the parent view.
		if (popoverRect.origin.x < 0) {
			contentSize.width -= fabsf(popoverRect.origin.x);
			popoverSize = popoverSizeFromContentSize(contentSize);
			popoverRect.origin.x = 0;
			popoverRect.size = popoverSize;
		}
	}
	
	contentViewController.contentSize = contentSize;
	contentViewController.baseView.popoverOffset = popoverOffset;
	
	return popoverRect;
}

- (void)presentLastChildViewControllerFromRect:(CGRect)fromRect inView:(UIView*)inView direction:(UZMultipleLayeredPopoverDirection)direction {
	UZMultipleLayeredContentViewController *contentViewController = [_layeredControllers lastObject];
	
	CGRect fromRectInPopover = [self.view convertRect:fromRect fromView:inView];
	CGPoint centerInPopover = CGPointMake(CGRectGetMidX(fromRectInPopover), CGRectGetMidY(fromRectInPopover));
	
	CGRect popoverRect = CGRectZero;
	
	if (direction != UZMultipleLayeredPopoverAnyDirection) {
		contentViewController.direction = direction;
		popoverRect = [self popoverRectForContentViewController:contentViewController centerOfFromRectInPopover:centerInPopover direction:contentViewController.direction];
	}
	else {
		// still, buggy
//		CGRect popoverRects[4];
//		popoverRects[0] = [self popoverRectForContentViewController:contentViewController centerOfFromRectInPopover:centerInPopover direction:UZMultipleLayeredPopoverTopDirection];
//		popoverRects[1] = [self popoverRectForContentViewController:contentViewController centerOfFromRectInPopover:centerInPopover direction:UZMultipleLayeredPopoverBottomDirection];
//		popoverRects[2] = [self popoverRectForContentViewController:contentViewController centerOfFromRectInPopover:centerInPopover direction:UZMultipleLayeredPopoverRightDirection];
//		popoverRects[3] = [self popoverRectForContentViewController:contentViewController centerOfFromRectInPopover:centerInPopover direction:UZMultipleLayeredPopoverLeftDirection];
//		int saved = 0;
//		popoverRect = popoverRects[0];
//		float square = popoverRects[0].size.width * popoverRects[0].size.height;
//		for (int i = 1; i < 4; i++) {
//			if (square < popoverRects[i].size.width * popoverRects[i].size.height) {
//				square = popoverRects[i].size.width * popoverRects[i].size.height;
//				popoverRect = popoverRects[i];
//				saved = i;
//			}
//		}
//		if (saved == 0)
//			contentViewController.direction = UZMultipleLayeredPopoverTopDirection;
//		if (saved == 1)
//			contentViewController.direction = UZMultipleLayeredPopoverBottomDirection;
//		if (saved == 2)
//			contentViewController.direction = UZMultipleLayeredPopoverRightDirection;
//		if (saved == 3)
//			contentViewController.direction = UZMultipleLayeredPopoverLeftDirection;
//		popoverRect = [self popoverRectForContentViewController:contentViewController centerOfFromRectInPopover:centerInPopover direction:contentViewController.direction];
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
