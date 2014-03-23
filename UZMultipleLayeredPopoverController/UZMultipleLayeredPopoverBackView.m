//
//  UZMultipleLayeredPopoverBackView.m
//  UZMultipleLayeredPopoverController
//
//  Created by sonson on 2014/03/23.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import "UZMultipleLayeredPopoverBackView.h"

@implementation UZMultipleLayeredPopoverBackView

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor clearColor];
	}
	return self;
}

- (void)setIsActive:(BOOL)isActive {
	_isActive = isActive;
	[self setNeedsDisplay];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
	if (self.isActive) {
		for (UIView *passthroughView in self.passthroughViews) {
			CGRect r = [self convertRect:passthroughView.bounds fromView:passthroughView];
			if (CGRectContainsPoint(r, point))
				return nil;
		}
	}
	return [super hitTest:point withEvent:event];
}

- (void)drawRect:(CGRect)rect {
	if (self.isActive) {
		CGContextRef context = UIGraphicsGetCurrentContext();
		for (UIView *passthroughView in self.passthroughViews) {
			CGRect r = [self convertRect:passthroughView.bounds fromView:passthroughView];
			[[[UIColor redColor] colorWithAlphaComponent:0.2] setFill];
			CGContextFillRect(context, r);
		}
	}
}

@end
