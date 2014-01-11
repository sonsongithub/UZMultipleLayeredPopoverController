//
//  UZMultipleLayeredPopoverBaseView.h
//  UZMultipleLayeredPopoverController
//
//  Created by sonson on 2014/01/02.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UZMultipleLayeredPopoverBaseView.h"
#import "UZMultipleLayeredPopoverController.h"

#define UZMultipleLayeredPopoverCornerRadious	10
#define UZMultipleLayeredPopoverContentMargin	20
#define UZMultipleLayeredPopoverArrowSize		10

@interface UZMultipleLayeredPopoverBaseView : UIView

@property (nonatomic, assign) UIEdgeInsets contentEdgeInsets;
@property (nonatomic, assign) CGPoint popoverFromPoint;
@property (nonatomic, assign) UZMultipleLayeredPopoverDirection direction;
@property (nonatomic, assign) float popoverArrowOffset;

@end
