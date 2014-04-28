UZMultipleLayeredPopoverController
==================================
Custom popover controller for iOS7

###What's UZMultipleLayeredPopoverController?
- UZMultipleLayeredPopoverController class implements the popover controller like UIPopoverController.
- The class supports the display of UIViewController instance on the popover like using UIPopoverController objects.
- You can overlay popover controllers on them unlimitedly.
- You can use this controller on iPhone/iPod.

[![image](https://raw.github.com/sonsongithub/UZMultipleLayeredPopoverController/master/screenshot/UZMultipleLayeredPopoverController.gif)](https://www.youtube.com/watch?v=ePbiWwZu3w4)

###How to use

It's easy and simple. You can show UZMultipleLayeredPopoverController like a modal view controller.

    [self presentMultipleLayeredPopoverWithViewController:viewController
                                              contentSize:CGSizeMake(320, 480)
                                                fromRect:button.frame
                                                  inView:self.view
                                               direction:UZMultipleLayeredPopoverAnyDirection
                                        passThroughViews:@[button]];

###How to build
- Use build.sh. Automatically lib and header file generated at ./build/.
- UZMultipleLayeredPopoverController supports [CocoaPods](http://cocoapods.org).

###Document
- See html/index.html

###License
- UZMultipleLayeredPopoverController is available under BSD-License. See LICENSE file in this repository.