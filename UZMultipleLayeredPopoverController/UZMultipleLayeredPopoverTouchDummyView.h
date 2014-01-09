//
//  UZMultipleLayeredPopoverTouchDummyView.h
//  UZMultipleLayeredPopoverController
//
//  Created by sonson on 2014/01/09.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UZMultipleLayeredPopoverTouchDummyView;

@protocol UZMultipleLayeredPopoverTouchDummyViewDelegate <NSObject>
- (void)dummyViewDidTouch:(UZMultipleLayeredPopoverTouchDummyView*)view;
@end

@interface UZMultipleLayeredPopoverTouchDummyView : UIView
@property (nonatomic, assign) id <UZMultipleLayeredPopoverTouchDummyViewDelegate> delegate;
@end
