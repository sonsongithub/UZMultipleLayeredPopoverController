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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	DNSLogMethod
	
	UITouch *touch = [touches anyObject];
	CGPoint touchPoint = [touch locationInView:self.view];
	
	
//	id viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Test"];
//	id viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ContentViewController"];
	id viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavigationController"];
	

	UZMultipleLayeredPopoverController *controller = [[UZMultipleLayeredPopoverController alloc] initWithRootViewController:viewController contentSize:CGSizeMake(320, 480)];
	
	[controller presentFromRect:CGRectMake(touchPoint.x, touchPoint.y, 0, 0) inViewController:self];
	
	[self resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
