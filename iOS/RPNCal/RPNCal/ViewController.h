//
//  ViewController.h
//  RPNCal
//
//  Created by Ole Holst Andersen on 06/12/14.
//  Copyright (c) 2014 Ole Holst Andersen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPNStack.h"
#import "KeypadView.h"

typedef  float(^NullaryOperation)();
typedef  float(^UnaryOperation)(float opr1);
typedef  float(^BinaryOperation)(float opr1, float opr2);

@interface ViewController : UIViewController  <KeyPressedDelegate> {
    RPNStack* stack;
    NSString* enteredValue;
    __weak IBOutlet UILabel *enteredValueLabel;
    __weak IBOutlet UILabel *stackLabel;
    __weak IBOutlet KeypadView *keypadView;
    __weak IBOutlet UIView *displayView;
    IBOutlet UIView *mainView;
    __weak IBOutlet NSLayoutConstraint *displayBottomToBottom;
    __weak IBOutlet NSLayoutConstraint *keypadTopToTop;
    __weak IBOutlet NSLayoutConstraint *displayRightToRight;
    __weak IBOutlet NSLayoutConstraint *keypadLeftToLeft;
}

@end

