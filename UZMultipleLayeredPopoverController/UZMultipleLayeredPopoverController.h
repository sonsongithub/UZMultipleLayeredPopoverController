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
	UZMultipleLayeredPopoverTopDirection	= 1,
	UZMultipleLayeredPopoverBottomDirection = 1 << 1,
	UZMultipleLayeredPopoverLeftDirection	= 1 << 2,
	UZMultipleLayeredPopoverRightDirection	= 1 << 3,
	UZMultipleLayeredPopoverAnyDirection	= (1 << 0) & (1 << 1) & (1 << 2) & (1 << 3)
}UZMultipleLayeredPopoverDirection;

@class UZMultipleLayeredPopoverController;

@interface UIViewController (UZMultipleLayeredPopoverController)
- (UZMultipleLayeredPopoverController*)parentMultipleLayeredPopoverController;
@end

@interface UZMultipleLayeredPopoverController : UIViewController {
	UIViewController *_inViewController;
	NSMutableArray *_layeredControllers;
}
- (id)initWithRootViewController:(UIViewController*)rootViewController contentSize:(CGSize)contentSize;
- (void)presentFromRect:(CGRect)fromRect inViewController:(UIViewController*)inViewController direction:(UZMultipleLayeredPopoverDirection)direction;
- (void)presentViewController:(UIViewController *)viewControllerToPresent fromRect:(CGRect)fromRect inView:(UIView*)inView contentSize:(CGSize)contentSize direction:(UZMultipleLayeredPopoverDirection)direction;
@end
