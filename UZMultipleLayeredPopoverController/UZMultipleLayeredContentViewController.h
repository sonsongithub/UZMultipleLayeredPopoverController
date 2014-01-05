//
//  UZMultipleLayeredContentViewController.h
//  UZMultipleLayeredPopoverController
//
//  Created by sonson on 2014/01/02.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UZMultipleLayeredPopoverController;
@class UZMultipleLayeredPopoverBaseView;

@interface UZMultipleLayeredContentViewController : UIViewController {
	UZMultipleLayeredPopoverController	*_parentPopoverController;
	UZMultipleLayeredPopoverBaseView	*_baseView;
	UIViewController					*_contentViewController;
	CGSize								_contentSize;
	CGSize								_popoverSize;
	UIEdgeInsets						_contentEdgeInsets;
}

- (id)initWithContentViewController:(UIViewController*)contentViewController contentSize:(CGSize)contentSize;

@property (nonatomic, readonly) CGSize contentSize;
@property (nonatomic, readonly) CGSize popoverSize;
@property (nonatomic, readonly) UZMultipleLayeredPopoverBaseView *baseView;

@end
