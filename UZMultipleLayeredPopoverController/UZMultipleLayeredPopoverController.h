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

@interface UIViewController (UZMultipleLayeredPopoverController)
- (void)dismissCurrentPopoverController;
- (void)dismissMultipleLayeredPopoverController;
- (void)presentMultipleLayeredPopoverWithViewController:(UIViewController*)viewController contentSize:(CGSize)contentSize fromRect:(CGRect)fromRect inView:(UIView*)inView direction:(UZMultipleLayeredPopoverDirection)direction;
@end

@interface UZMultipleLayeredPopoverController : UIViewController
@end
