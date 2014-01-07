//
//  UZMultipleLayeredContentViewController.m
//  UZMultipleLayeredPopoverController
//
//  Created by sonson on 2014/01/02.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import "UZMultipleLayeredContentViewController.h"

#import "UZMultipleLayeredPopoverBaseView.h"

@interface UZMultipleLayeredContentViewController ()
@end

@implementation UZMultipleLayeredContentViewController

- (void)dealloc {
    DNSLogMethod
}

- (id)initWithContentViewController:(UIViewController*)contentViewController contentSize:(CGSize)contentSize {
	DNSLogMethod
	self = [super init];
	if (self) {
		_baseView = [[UZMultipleLayeredPopoverBaseView alloc] initWithFrame:CGRectMake(0, 0, _popoverSize.width, _popoverSize.height)];
		[self.view addSubview:_baseView];
		[self.view sendSubviewToBack:_baseView];
		
		_contentEdgeInsets = UIEdgeInsetsMake(UZMultipleLayeredPopoverContentMargin, UZMultipleLayeredPopoverContentMargin, UZMultipleLayeredPopoverContentMargin, UZMultipleLayeredPopoverContentMargin);
		_contentViewController = contentViewController;
		_contentSize = contentSize;
		_popoverSize = contentSize;
		_popoverSize.width += (_contentEdgeInsets.left + _contentEdgeInsets.right);
		_popoverSize.height += (_contentEdgeInsets.top + _contentEdgeInsets.bottom);
		
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
	[self updateSubviews];
}

- (void)updateSubviews {
	_popoverSize = _contentSize;
	_popoverSize.width += (_contentEdgeInsets.left + _contentEdgeInsets.right);
	_popoverSize.height += (_contentEdgeInsets.top + _contentEdgeInsets.bottom);
	CGRect childViewControllerFrame = CGRectMake(_contentEdgeInsets.left, _contentEdgeInsets.top, _contentSize.width, _contentSize.height);
	_contentViewController.view.frame = childViewControllerFrame;
	_baseView.frame = CGRectMake(0, 0, _popoverSize.width, _popoverSize.height);
	_baseView.contentEdgeInsets = _contentEdgeInsets;
}

@end
