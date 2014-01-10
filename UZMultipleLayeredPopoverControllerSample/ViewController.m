//
//  ViewController.m
//  UZMultipleLayeredPopoverControllerSample
//
//  Created by sonson on 2014/01/02.
//  Copyright (c) 2014年 sonson. All rights reserved.
//

#import "ViewController.h"

#import "UZMultipleLayeredPopoverController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)button:(id)sender {
	UIButton *button = sender;
	id viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavigationController"];
	
	UZMultipleLayeredPopoverDirection direction = UZMultipleLayeredPopoverAnyDirection;
	UZMultipleLayeredPopoverController *controller = [[UZMultipleLayeredPopoverController alloc] initWithRootViewController:viewController contentSize:CGSizeMake(320, 480)];
	
	[controller presentFromRect:button.frame inViewController:self direction:direction];
}

@end
