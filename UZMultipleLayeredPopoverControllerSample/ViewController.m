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

static int counter = 1;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	DNSLogMethod
	
	UITouch *touch = [touches anyObject];
	CGPoint touchPoint = [touch locationInView:self.view];
	
	
//	id viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Test"];
//	id viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ContentViewController"];
	id viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavigationController"];
	
	UZMultipleLayeredPopoverDirection direction;
	
	if (counter == 1)
		direction = UZMultipleLayeredPopoverTopDirection;
	if (counter == 2)
		direction = UZMultipleLayeredPopoverBottomDirection;
	if (counter == 3)
		direction = UZMultipleLayeredPopoverRightDirection;
	if (counter == 4)
		direction = UZMultipleLayeredPopoverLeftDirection;
	if (counter == 5)
		direction = UZMultipleLayeredPopoverAnyDirection;
	counter++;
	if (counter == 6)
		counter = 1;
	
	
	direction = UZMultipleLayeredPopoverAnyDirection;
	
	UZMultipleLayeredPopoverController *controller = [[UZMultipleLayeredPopoverController alloc] initWithRootViewController:viewController contentSize:CGSizeMake(320, 480)];
	
	[controller presentFromRect:CGRectMake(touchPoint.x, touchPoint.y, 0, 0) inViewController:self direction:direction];
	
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
