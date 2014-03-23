//
//  UZMultipleLayeredContentBackView.m
//  UZMultipleLayeredPopoverController
//
//  Created by sonson on 2014/03/24.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import "UZMultipleLayeredContentBackView.h"

@implementation UZMultipleLayeredContentBackView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
	if (![self.passthroughViews count]) {
		return [super hitTest:point withEvent:event];
	}
	else {
		for (UIView *passthroughView in self.passthroughViews) {
			CGRect r = [self convertRect:passthroughView.bounds fromView:passthroughView];
			if (CGRectContainsPoint(r, point))
				return [super hitTest:point withEvent:event];
		}
		return nil;
	}
}

#ifdef _DEBUG

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor clearColor];
	}
	return self;
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	for (UIView *passthroughView in self.passthroughViews) {
		CGRect r = [self convertRect:passthroughView.bounds fromView:passthroughView];
		[[[UIColor redColor] colorWithAlphaComponent:0.2] setFill];
		CGContextFillRect(context, r);
	}
}
#endif

@end
