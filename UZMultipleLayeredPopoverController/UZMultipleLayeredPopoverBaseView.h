//
//  UZMultipleLayeredPopoverBaseView.h
//  UZMultipleLayeredPopoverController
//
//  Created by sonson on 2014/01/02.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _UZMultipleLayeredPopoverDirection {
	UZMultipleLayeredPopoverTopDirection	= 1,
	UZMultipleLayeredPopoverBottomDirection = 1 << 1,
	UZMultipleLayeredPopoverLeftDirection	= 1 << 2,
	UZMultipleLayeredPopoverRightDirection	= 1 << 3,
	UZMultipleLayeredPopoverAnyDirection	= (1 << 0) & (1 << 1) & (1 << 2) & (1 << 3)
}UZMultipleLayeredPopoverDirection;

#define UZMultipleLayeredPopoverAnyDirection (UZMultipleLayeredPopoverTopDirection&UZMultipleLayeredPopoverBottomDirection&UZMultipleLayeredPopoverLeftDirection&UZMultipleLayeredPopoverRightDirection)

@interface UZMultipleLayeredPopoverBaseView : UIView

@property (nonatomic, assign) UIEdgeInsets contentEdgeInsets;
@property (nonatomic, assign) CGPoint popoverFromPoint;

@end
