//
//  UZMultipleLayeredPopoverController.h
//  UZMultipleLayeredPopoverController
//
//  Created by sonson on 2014/01/02.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class UZMultipleLayeredPopoverController;

@interface UIViewController (UZMultipleLayeredPopoverController)
- (UZMultipleLayeredPopoverController*)parentMultipleLayeredPopoverController;
@end

@interface UZMultipleLayeredPopoverController : UIViewController {
	UIViewController *_inViewController;
	NSMutableArray *_layeredControllers;
}
- (id)initWithRootViewController:(UIViewController*)rootViewController contentSize:(CGSize)contentSize;
- (void)presentFromRect:(CGRect)fromRect inViewController:(UIViewController*)inViewController;
- (void)presentViewController:(UIViewController *)viewControllerToPresent fromRect:(CGRect)fromRect inView:(UIView*)inView contentSize:(CGSize)contentSize;
@end
