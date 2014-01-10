//
//  UZMultipleLayeredContentViewController.m
//  UZMultipleLayeredPopoverController
//
//  Created by sonson on 2014/01/02.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import "UZMultipleLayeredContentViewController.h"

#import "UZMultipleLayeredPopoverBaseView.h"
#import "UZMultipleLayeredPopoverTouchDummyView.h"

CGSize UZMultipleLayeredPopoverSizeFromContentSize(CGSize contentSize) {
	CGSize popoverSize = contentSize;
	popoverSize.width += ([UZMultipleLayeredContentViewController contentEdgeInsets].left + [UZMultipleLayeredContentViewController contentEdgeInsets].right);
	popoverSize.height += ([UZMultipleLayeredContentViewController contentEdgeInsets].top + [UZMultipleLayeredContentViewController contentEdgeInsets].bottom);
	return popoverSize;
}

@interface UZMultipleLayeredContentViewController() <UZMultipleLayeredPopoverTouchDummyViewDelegate> {
	UZMultipleLayeredPopoverTouchDummyView *_dummyView;
}
@end

@implementation UZMultipleLayeredContentViewController

- (void)dummyViewDidTouch:(UZMultipleLayeredPopoverTouchDummyView*)view {
	[(UZMultipleLayeredPopoverController*)self.parentViewController removeChildViewControllersToPopoverContentViewController:self];
	[self setActive:YES];
}

- (void)dealloc {
    DNSLogMethod
}

+ (UIEdgeInsets)contentEdgeInsets {
	return UIEdgeInsetsMake(UZMultipleLayeredPopoverContentMargin, UZMultipleLayeredPopoverContentMargin, UZMultipleLayeredPopoverContentMargin, UZMultipleLayeredPopoverContentMargin);
}

- (id)initWithContentViewController:(UIViewController*)contentViewController contentSize:(CGSize)contentSize {
	if ([contentViewController isKindOfClass:[UZMultipleLayeredPopoverController class]]) {
		[NSException raise:@"com.sonson.UZMultipleLayeredContentViewController" format:@"You can not set a UZMultipleLayeredPopoverController object as the view controller on UZMultipleLayeredContentViewController objects."];
		return nil;
	}
	if ([contentViewController isKindOfClass:[UZMultipleLayeredContentViewController class]]) {
		[NSException raise:@"com.sonson.UZMultipleLayeredContentViewController" format:@"You can not set a UZMultipleLayeredContentViewController object as the view controller on UZMultipleLayeredContentViewController objects."];
		return nil;
	}
	if (!contentViewController) {
		[NSException raise:@"com.sonson.UZMultipleLayeredContentViewController" format:@"You have to set any object as the view controller on UZMultipleLayeredContentViewController objects."];
		return nil;
	}
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
		[self.view bringSubviewToFront:_dummyView];
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

- (void)setActive:(BOOL)isActive {
	if (isActive) {
		[_dummyView removeFromSuperview];
		_dummyView = nil;
		self.view.alpha = 1;
	}
	else {
		[_dummyView removeFromSuperview];
		CGRect frame = CGRectMake(
								  [UZMultipleLayeredContentViewController contentEdgeInsets].left,
								  [UZMultipleLayeredContentViewController contentEdgeInsets].top,
								  _popoverSize.width - [UZMultipleLayeredContentViewController contentEdgeInsets].left - [UZMultipleLayeredContentViewController contentEdgeInsets].right,
								  _popoverSize.height - [UZMultipleLayeredContentViewController contentEdgeInsets].top - [UZMultipleLayeredContentViewController contentEdgeInsets].bottom
								  );
		_dummyView = [[UZMultipleLayeredPopoverTouchDummyView alloc] initWithFrame:frame];
		//_dummyView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.4];
		_dummyView.backgroundColor = [UIColor clearColor];
		_dummyView.delegate = self;
		self.view.alpha = 0.5;
	}
	[self.view addSubview:_dummyView];
}

- (void)updateSubviews {
	_popoverSize = UZMultipleLayeredPopoverSizeFromContentSize(_contentSize);
	CGRect childViewControllerFrame = CGRectMake([UZMultipleLayeredContentViewController contentEdgeInsets].left, [UZMultipleLayeredContentViewController contentEdgeInsets].top, _contentSize.width, _contentSize.height);
	_contentViewController.view.frame = childViewControllerFrame;
	_baseView.frame = CGRectMake(0, 0, _popoverSize.width, _popoverSize.height);
	_baseView.contentEdgeInsets = [UZMultipleLayeredContentViewController contentEdgeInsets];
	_dummyView.frame = _baseView.frame;
}

@end
