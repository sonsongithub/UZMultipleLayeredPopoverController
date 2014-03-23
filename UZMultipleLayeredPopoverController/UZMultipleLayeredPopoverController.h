//
//  UZMultipleLayeredPopoverController.h
//  UZMultipleLayeredPopoverController
//
//  Created by sonson on 2014/01/02.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum _UZMultipleLayeredPopoverDirection {
	UZMultipleLayeredPopoverTopDirection		= 1,
	UZMultipleLayeredPopoverBottomDirection		= 1 << 1,
	UZMultipleLayeredPopoverLeftDirection		= 1 << 2,
	UZMultipleLayeredPopoverRightDirection		= 1 << 3,
	UZMultipleLayeredPopoverAnyDirection		= (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3),
	UZMultipleLayeredPopoverVerticalDirection	= (1 << 0) | (1 << 1),
	UZMultipleLayeredPopoverHorizontalDirection	= (1 << 2) | (1 << 3)
}UZMultipleLayeredPopoverDirection;

@interface UIViewController (UZMultipleLayeredPopoverController)
/**
 * Dismiss view controller on the top of popover controllers on UZMultipleLayeredPopoverController object.
 **/
- (void)dismissCurrentPopoverController;

/**
 * Dismiss all popover controllers on UZMultipleLayeredPopoverController object.
 **/
- (void)dismissMultipleLayeredPopoverController;

/**
 * Present the specified view controller as popover.
 * The popover is always displayed on the unique UZMultipleLayeredPopoverController in the application.
 *
 * \param viewController The view controller for managing the popover’s content.
 * \param contentSize The new size to apply to the content view.
 * \param fromRect The rectangle in view at which to anchor the popover.
 * \param inView The view containing the anchor rectangle for the popover.
 * \param direction The arrow directions the popover is permitted to use. You can use this value to force the popover to be positioned on a specific side of the rectangle.
 **/
- (void)presentMultipleLayeredPopoverWithViewController:(UIViewController*)viewController contentSize:(CGSize)contentSize fromRect:(CGRect)fromRect inView:(UIView*)inView direction:(UZMultipleLayeredPopoverDirection)direction;

/**
 * Present the specified view controller as popover.
 * The popover is always displayed on the unique UZMultipleLayeredPopoverController in the application.
 *
 * \param viewController The view controller for managing the popover’s content.
 * \param contentSize The new size to apply to the content view.
 * \param fromRect The rectangle in view at which to anchor the popover.
 * \param inView The view containing the anchor rectangle for the popover.
 * \param direction The arrow directions the popover is permitted to use. You can use this value to force the popover to be positioned on a specific side of the rectangle.
 * \param passthroughViews An array of views in "inView" argument that the user can interact with while the popover is visible.
 **/
- (void)presentMultipleLayeredPopoverWithViewController:(UIViewController*)viewController contentSize:(CGSize)contentSize fromRect:(CGRect)fromRect inView:(UIView*)inView direction:(UZMultipleLayeredPopoverDirection)direction passthroughViews:(NSArray*)passthroughViews;
@end

@interface UZMultipleLayeredPopoverController : UIViewController
@end
