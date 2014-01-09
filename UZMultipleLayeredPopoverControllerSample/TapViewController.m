//
//  TapViewController.m
//  UZMultipleLayeredPopoverController
//
//  Created by sonson on 2014/01/02.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import "TapViewController.h"
#import "UZMultipleLayeredPopoverController.h"

@interface TapViewController ()
@end

@implementation TapViewController

- (IBAction)up:(id)sender {
	UIButton *button = sender;
	[self showAtButtonFrame:button.frame direction:UZMultipleLayeredPopoverBottomDirection];
}

- (IBAction)down:(id)sender {
	UIButton *button = sender;
	[self showAtButtonFrame:button.frame direction:UZMultipleLayeredPopoverTopDirection];
}

- (IBAction)left:(id)sender {
	UIButton *button = sender;
	[self showAtButtonFrame:button.frame direction:UZMultipleLayeredPopoverLeftDirection];
}

- (IBAction)right:(id)sender {
	UIButton *button = sender;
	[self showAtButtonFrame:button.frame direction:UZMultipleLayeredPopoverRightDirection];
}

- (IBAction)any:(id)sender {
	UIButton *button = sender;
	[self showAtButtonFrame:button.frame direction:UZMultipleLayeredPopoverAnyDirection];
}

- (IBAction)closeThis:(id)sender {
	UZMultipleLayeredPopoverController *pop = [self parentMultipleLayeredPopoverController];
	[pop dismissTopViewController];
}

- (IBAction)closeAll:(id)sender {
	UZMultipleLayeredPopoverController *pop = [self parentMultipleLayeredPopoverController];
	[pop dismiss];
}

- (void)showAtButtonFrame:(CGRect)buttonFrame direction:(UZMultipleLayeredPopoverDirection)direction {
	UZMultipleLayeredPopoverController *pop = [self parentMultipleLayeredPopoverController];
	UIApplication *application = [UIApplication sharedApplication];
	UIViewController *vc = [application.keyWindow.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"TapViewController"];
	[pop presentViewController:vc fromRect:buttonFrame inView:self.view contentSize:CGSizeMake(320, 480) direction:direction];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
}

@end
