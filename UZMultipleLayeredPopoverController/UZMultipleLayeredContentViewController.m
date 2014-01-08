//
//  UZMultipleLayeredContentViewController.m
//  UZMultipleLayeredPopoverController
//
//  Created by sonson on 2014/01/02.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import "UZMultipleLayeredContentViewController.h"

#import "UZMultipleLayeredPopoverBaseView.h"

CGSize UZMultipleLayeredPopoverSizeFromContentSize(CGSize contentSize) {
	CGSize popoverSize = contentSize;
	popoverSize.width += ([UZMultipleLayeredContentViewController contentEdgeInsets].left + [UZMultipleLayeredContentViewController contentEdgeInsets].right);
	popoverSize.height += ([UZMultipleLayeredContentViewController contentEdgeInsets].top + [UZMultipleLayeredContentViewController contentEdgeInsets].bottom);
	return popoverSize;
}

@interface UZMultipleLayeredContentViewController ()
@end

@implementation UZMultipleLayeredContentViewController

- (void)dealloc {
    DNSLogMethod
}

+ (UIEdgeInsets)contentEdgeInsets {
	return UIEdgeInsetsMake(UZMultipleLayeredPopoverContentMargin, UZMultipleLayeredPopoverContentMargin, UZMultipleLayeredPopoverContentMargin, UZMultipleLayeredPopoverContentMargin);
}

- (id)initWithContentViewController:(UIViewController*)contentViewController contentSize:(CGSize)contentSize {
	DNSLogMethod
	self = [super init];
	if (self) {
		_baseView = [[UZMultipleLayeredPopoverBaseView alloc] initWithFrame:CGRectMake(0, 0, _popoverSize.width, _popoverSize.height)];
		[self.view addSubview:_baseView];
		[self.view sendSubviewToBack:_baseView];
		
		_contentViewController = contentViewController;
		_contentSize = contentSize;
		_popoverSize = UZMultipleLayeredPopoverSizeFromContentSize(_contentSize);
		
		contentViewController.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
		[contentViewController.view.layer setCornerRadius:UZMultipleLayeredPopoverCornerRadious];
		[contentViewController.view.layer setMasksToBounds:YES];
		
		[self addChildViewController:contentViewController];
		[self.view addSubview:contentViewController.view];
		
		[self updateSubviews];
	}
	return self;
}

- (void)setContentSize:(CGSize)contentSize {
	_contentSize = contentSize;
	_popoverSize = UZMultipleLayeredPopoverSizeFromContentSize(_contentSize);
	[self updateSubviews];
	[_baseView setNeedsDisplay];
}

- (void)setDirection:(UZMultipleLayeredPopoverDirection)direction {
	_direction = direction;
	_baseView.direction = direction;
	[_baseView setNeedsDisplay];
}

- (void)updateSubviews {
	_popoverSize = UZMultipleLayeredPopoverSizeFromContentSize(_contentSize);
	CGRect childViewControllerFrame = CGRectMake([UZMultipleLayeredContentViewController contentEdgeInsets].left, [UZMultipleLayeredContentViewController contentEdgeInsets].top, _contentSize.width, _contentSize.height);
	_contentViewController.view.frame = childViewControllerFrame;
	_baseView.frame = CGRectMake(0, 0, _popoverSize.width, _popoverSize.height);
	_baseView.contentEdgeInsets = [UZMultipleLayeredContentViewController contentEdgeInsets];
}

@end
