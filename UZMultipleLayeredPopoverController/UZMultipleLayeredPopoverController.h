//
//  UZMultipleLayeredPopoverController.h
//  UZMultipleLayeredPopoverController
//
//  Created by Yuichi Yoshida on 2018/01/02.
//  Copyright © 2018年 sonson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//! Project version number for UZMultipleLayeredPopoverController.
FOUNDATION_EXPORT double UZMultipleLayeredPopoverControllerVersionNumber;

//! Project version string for UZMultipleLayeredPopoverController.
FOUNDATION_EXPORT const unsigned char UZMultipleLayeredPopoverControllerVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <UZMultipleLayeredPopoverController/PublicHeader.h>

extern NSString *const UZMultipleLayeredPopoverDidDismissNotification;							/**< Posted shortly after UZMultipleLayeredPopoverController is dismissed. The object of the notification is the UZMultipleLayeredPopoverController object. There is no userInfo dictionary. */

/**
 * Constants for specifying the direction of the popover arrow.
 **/
typedef NS_ENUM(NSUInteger, UZMultipleLayeredPopoverDirection) {
	/** An arrow that points upward. */
	UZMultipleLayeredPopoverTopDirection		= 1,
	/** An arrow that points downward. */
	UZMultipleLayeredPopoverBottomDirection		= 1 << 1,
	/** An arrow that points toward the left. */
	UZMultipleLayeredPopoverLeftDirection		= 1 << 2,
	/** An arrow that points toward the right. */
	UZMultipleLayeredPopoverRightDirection		= 1 << 3,
	/** An arrow that points in any direction. */
	UZMultipleLayeredPopoverAnyDirection		= (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3),
	/** An arrow that points in upward or downward direction. */
	UZMultipleLayeredPopoverVerticalDirection	= (1 << 0) | (1 << 1),
	/** An arrow that points in left or right direction. */
	UZMultipleLayeredPopoverHorizontalDirection	= (1 << 2) | (1 << 3)
};

/**
 * This library adds methods to UIViewController to support the multi-layered popover controllers.
 **/
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
 * @param viewController The view controller for managing the popover’s content.
 * @param contentSize The new size to apply to the content view.
 * @param fromRect The rectangle in view at which to anchor the popover.
 * @param inView The view containing the anchor rectangle for the popover.
 * @param direction The arrow directions the popover is permitted to use. You can use this value to force the popover to be positioned on a specific side of the rectangle. See UZMultipleLayeredPopoverDirection constants.
 **/
- (void)presentMultipleLayeredPopoverWithViewController:(UIViewController*)viewController contentSize:(CGSize)contentSize fromRect:(CGRect)fromRect inView:(UIView*)inView direction:(UZMultipleLayeredPopoverDirection)direction;

/**
 * Present the specified view controller as popover.
 * The popover is always displayed on the unique UZMultipleLayeredPopoverController in the application.
 *
 * @param viewController The view controller for managing the popover’s content.
 * @param contentSize The new size to apply to the content view.
 * @param fromRect The rectangle in view at which to anchor the popover.
 * @param inView The view containing the anchor rectangle for the popover.
 * @param direction The arrow directions the popover is permitted to use. You can use this value to force the popover to be positioned on a specific side of the rectangle. See UZMultipleLayeredPopoverDirection constants.
 * @param passThroughViews An array of views in "inView" argument that the user can interact with while the popover is visible.
 **/
- (void)presentMultipleLayeredPopoverWithViewController:(UIViewController*)viewController contentSize:(CGSize)contentSize fromRect:(CGRect)fromRect inView:(UIView*)inView direction:(UZMultipleLayeredPopoverDirection)direction passThroughViews:(NSArray*)passThroughViews;

@end
