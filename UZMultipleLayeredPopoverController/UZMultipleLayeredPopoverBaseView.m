//
//  UZMultipleLayeredPopoverBaseView.m
//  UZMultipleLayeredPopoverController
//
//  Created by sonson on 2014/01/02.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import "UZMultipleLayeredPopoverBaseView.h"

@interface UZMultipleLayeredPopoverBaseView () {
	UIEdgeInsets	_contentEdgeInsets;
	CGPoint			_popoverFromPoint;
}
@end

@implementation UZMultipleLayeredPopoverBaseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
}

@end
