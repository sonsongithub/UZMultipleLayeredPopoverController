//
//  UZMultipleLayeredContentViewController.h
//  UZMultipleLayeredPopoverController
//
//  Created by sonson on 2014/01/02.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UZMultipleLayeredPopoverBaseView.h"

@class UZMultipleLayeredPopoverController;
@class UZMultipleLayeredPopoverBaseView;

@interface UZMultipleLayeredContentViewController : UIViewController {
	UZMultipleLayeredPopoverController	*_parentPopoverController;
	UZMultipleLayeredPopoverBaseView	*_baseView;
	UIViewController					*_contentViewController;
	CGSize								_contentSize;
	CGSize								_popoverSize;
	UIEdgeInsets						_contentEdgeInsets;
	UZMultipleLayeredPopoverDirection	_direction;
}

- (id)initWithContentViewController:(UIViewController*)contentViewController contentSize:(CGSize)contentSize;

@property (nonatomic, assign) CGSize contentSize;
@property (nonatomic, readonly) CGSize popoverSize;
@property (nonatomic, readonly) UZMultipleLayeredPopoverBaseView *baseView;
@property (nonatomic, assign) UZMultipleLayeredPopoverDirection direction;

@end
