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

- (id)initWithContentViewController:(UIViewController*)contentViewController contentSize:(CGSize)contentSize {
	self = [super init];
	if (self) {
		_contentEdgeInsets = UIEdgeInsetsMake(UZMultipleLayeredPopoverContentMargin, UZMultipleLayeredPopoverContentMargin, UZMultipleLayeredPopoverContentMargin, UZMultipleLayeredPopoverContentMargin);
		_contentViewController = contentViewController;
		_contentSize = contentSize;
		_popoverSize = contentSize;
		_popoverSize.width += (_contentEdgeInsets.left + _contentEdgeInsets.right);
		_popoverSize.height += (_contentEdgeInsets.top + _contentEdgeInsets.bottom);
		
		DNSLog(@"%@", contentViewController.view.superview);
		DNSLog(@"%@", contentViewController.view);
		
		contentViewController.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
		
		[self addChildViewController:contentViewController];
		CGRect childViewControllerFrame = CGRectMake(_contentEdgeInsets.left, _contentEdgeInsets.top, _contentSize.width, _contentSize.height);
		[self.view addSubview:contentViewController.view];
		contentViewController.view.frame = childViewControllerFrame;
		
		for (NSLayoutConstraint *constraint in contentViewController.view.constraints) {
			DNSLog(@"%@", constraint);
		}
		
		[contentViewController.view.layer setCornerRadius:UZMultipleLayeredPopoverCornerRadious];
		[contentViewController.view.layer setMasksToBounds:YES];
		
		_baseView = [[UZMultipleLayeredPopoverBaseView alloc] initWithFrame:CGRectMake(0, 0, _popoverSize.width, _popoverSize.height)];
		[self.view addSubview:_baseView];
		[self.view sendSubviewToBack:_baseView];
		
		_baseView.contentEdgeInsets = _contentEdgeInsets;
//		_baseView.
	}
	return self;
}

@end
