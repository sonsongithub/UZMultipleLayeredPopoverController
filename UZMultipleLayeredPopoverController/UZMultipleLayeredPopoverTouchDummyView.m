//
//  UZMultipleLayeredPopoverTouchDummyView.m
//  UZMultipleLayeredPopoverController
//
//  Created by sonson on 2014/01/09.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import "UZMultipleLayeredPopoverTouchDummyView.h"

@implementation UZMultipleLayeredPopoverTouchDummyView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self.delegate dummyViewDidTouch:self];
}

@end