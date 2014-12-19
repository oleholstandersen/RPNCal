//
//  ViewController.h
//  RPNCal
//
//  Created by Ole Holst Andersen on 06/12/14.
//  Copyright (c) 2014 Ole Holst Andersen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPNStack.h"

typedef  float(^NullaryOperation)();
typedef  float(^UnaryOperation)(float opr1);
typedef  float(^BinaryOperation)(float opr1, float opr2);

@interface ViewController : UIViewController {
    RPNStack* stack;
    NSString* enteredValue;
    __weak IBOutlet UILabel *inputLabel;
    __weak IBOutlet UILabel *stackLabel;
}

@end

