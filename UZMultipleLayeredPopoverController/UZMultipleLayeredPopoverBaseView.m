//
//  UZMultipleLayeredPopoverBaseView.m
//  UZMultipleLayeredPopoverController
//
//  Created by sonson on 2014/01/02.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import "UZMultipleLayeredPopoverBaseView.h"

@interface UZMultipleLayeredPopoverBaseView () {
	UIEdgeInsets						_contentEdgeInsets;
	UZMultipleLayeredPopoverDirection	_direction;
	float								_popoverArrowOffset;
}
@end

@implementation UZMultipleLayeredPopoverBaseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		self.backgroundColor = [UIColor clearColor];
		_direction = UZMultipleLayeredPopoverBottomDirection;
    }
    return self;
}

- (void)drawRoundCornerRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	float step = UZMultipleLayeredPopoverArrowSize;
	float radius = UZMultipleLayeredPopoverCornerRadious;
	
	// get points
	CGFloat minx = CGRectGetMinX(rect), midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
	CGFloat miny = CGRectGetMinY(rect), midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);
	
	CGContextSaveGState(context);
	
	CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 4.0, [[UIColor blackColor] CGColor]);
	
	CGContextMoveToPoint(context, minx, miny + radius);
	CGContextAddArcToPoint(context, minx, miny, minx + radius, miny, radius);
	
	if (_direction == UZMultipleLayeredPopoverTopDirection) {
		midx -= _popoverArrowOffset;
		if (midx < minx + UZMultipleLayeredPopoverCornerRadious + UZMultipleLayeredPopoverArrowSize)
			midx = minx + UZMultipleLayeredPopoverCornerRadious + UZMultipleLayeredPopoverArrowSize;
		else if (midx > maxx - UZMultipleLayeredPopoverCornerRadious - UZMultipleLayeredPopoverArrowSize)
			midx = maxx - UZMultipleLayeredPopoverCornerRadious - UZMultipleLayeredPopoverArrowSize;
		CGContextAddLineToPoint(context, midx - step, miny);
		CGContextAddLineToPoint(context, midx, miny - step);
		CGContextAddLineToPoint(context, midx + step, miny);
	}
	CGContextAddArcToPoint(context, maxx, miny, maxx, miny + radius, radius);
	
	if (_direction == UZMultipleLayeredPopoverLeftDirection) {
		midy -= _popoverArrowOffset;
		if (midy < miny + UZMultipleLayeredPopoverCornerRadious + UZMultipleLayeredPopoverArrowSize)
			midy = miny + UZMultipleLayeredPopoverCornerRadious + UZMultipleLayeredPopoverArrowSize;
		else if (midy > maxy - UZMultipleLayeredPopoverCornerRadious - UZMultipleLayeredPopoverArrowSize)
			midy = maxy - UZMultipleLayeredPopoverCornerRadious - UZMultipleLayeredPopoverArrowSize;
		CGContextAddLineToPoint(context, maxx, midy - step);
		CGContextAddLineToPoint(context, maxx + step, midy);
		CGContextAddLineToPoint(context, maxx, midy + step);
	}
	CGContextAddArcToPoint(context, maxx, maxy, maxx - radius, maxy, radius);
	
	if (_direction == UZMultipleLayeredPopoverBottomDirection) {
		midx -= _popoverArrowOffset;
		if (midx < minx + UZMultipleLayeredPopoverCornerRadious + UZMultipleLayeredPopoverArrowSize)
			midx = minx + UZMultipleLayeredPopoverCornerRadious + UZMultipleLayeredPopoverArrowSize;
		else if (midx > maxx - UZMultipleLayeredPopoverCornerRadious - UZMultipleLayeredPopoverArrowSize)
			midx = maxx - UZMultipleLayeredPopoverCornerRadious - UZMultipleLayeredPopoverArrowSize;
		CGContextAddLineToPoint(context, midx + step, maxy);
		CGContextAddLineToPoint(context, midx, maxy + step);
		CGContextAddLineToPoint(context, midx - step, maxy);
	}
	CGContextAddArcToPoint(context, minx, maxy, minx, maxy - radius, radius);
	
	if (_direction == UZMultipleLayeredPopoverRightDirection) {
		midy -= _popoverArrowOffset;
		if (midy < miny + UZMultipleLayeredPopoverCornerRadious + UZMultipleLayeredPopoverArrowSize)
			midy = miny + UZMultipleLayeredPopoverCornerRadious + UZMultipleLayeredPopoverArrowSize;
		else if (midy > maxy - UZMultipleLayeredPopoverCornerRadious - UZMultipleLayeredPopoverArrowSize)
			midy = maxy - UZMultipleLayeredPopoverCornerRadious - UZMultipleLayeredPopoverArrowSize;
		CGContextAddLineToPoint(context, minx, midy + step);
		CGContextAddLineToPoint(context, minx - step, midy);
		CGContextAddLineToPoint(context, minx, midy - step);
	}
	CGContextClosePath(context);
	
	[[UIColor whiteColor] setFill];
	
	CGContextDrawPath(context, kCGPathFill);
	
	CGContextRestoreGState(context);
}

- (void)drawRect:(CGRect)rect {
	CGRect r = rect;
	r.origin.x = _contentEdgeInsets.left;
	r.origin.y = _contentEdgeInsets.top;
	r.size.width = r.size.width - (_contentEdgeInsets.left + _contentEdgeInsets.right);
	r.size.height = r.size.height - (_contentEdgeInsets.top + _contentEdgeInsets.bottom);
	[self drawRoundCornerRect:r];
}

@end
