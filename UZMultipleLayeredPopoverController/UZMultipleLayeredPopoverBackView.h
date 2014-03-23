//
//  UZMultipleLayeredPopoverBackView.h
//  UZMultipleLayeredPopoverController
//
//  Created by sonson on 2014/03/23.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UZMultipleLayeredPopoverBackView : UIView
@property (nonatomic, copy) NSArray *passthroughViews;
@property (nonatomic, assign) BOOL isActive;
@property (nonatomic, assign) BOOL forPopover;
@end
