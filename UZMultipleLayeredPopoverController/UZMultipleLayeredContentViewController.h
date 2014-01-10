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

CGSize UZMultipleLayeredPopoverSizeFromContentSize(CGSize contentSize);

@interface UZMultipleLayeredContentViewController : UIViewController {
	UZMultipleLayeredPopoverController	*_parentPopoverController;
	UZMultipleLayeredPopoverBaseView	*_baseView;
	UIViewController					*_contentViewController;
	CGSize								_contentSize;
	CGSize								_popoverSize;
	UZMultipleLayeredPopoverDirection	_direction;
}

@property (nonatomic, assign) CGSize contentSize;
@property (nonatomic, readonly) CGSize popoverSize;
@property (nonatomic, readonly) UZMultipleLayeredPopoverBaseView *baseView;
@property (nonatomic, assign) UZMultipleLayeredPopoverDirection direction;

+ (UIEdgeInsets)contentEdgeInsets;
- (id)initWithContentViewController:(UIViewController*)contentViewController contentSize:(CGSize)contentSize;
- (void)setActive:(BOOL)isActive;
- (void)updateSubviews;
- (CGRect)contentFrame;

@end
