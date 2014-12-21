//
//  ViewController.m
//  RPNCal
//
//  Created by Ole Holst Andersen on 06/12/14.
//  Copyright (c) 2014 Ole Holst Andersen. All rights reserved.
//

#import "ViewController.h"
#import <math.h>

@interface ViewController ()

@end

@implementation ViewController
- (NSNumber*) enteredNumber {
    if ([enteredValue length]==0 || [enteredValue isEqualToString:@"-"]) {
        return nil;
    }
    NSNumberFormatter* fmtr = [[NSNumberFormatter alloc] init];
    return [fmtr numberFromString:enteredValue];
}

-(void)performNullaryOperation:(NullaryOperation)operation {
    NSNumber* n = [self enteredNumber];
    if (n != nil) {
        [stack push:n];
        enteredValue = @"";
    }
    [stack push:[NSNumber numberWithFloat:operation()]];
}

-(void)performUnaryOperation:(UnaryOperation)operation {
    NSNumber* n = [self enteredNumber];
    if (n != nil) {
        [stack push:n];
        enteredValue = @"";
    }
    if ([stack height]>0) {
        NSNumber* opr1 = [stack pop];
        NSNumber* result = [NSNumber numberWithFloat:operation([opr1 floatValue])];
        [stack push:result];
    }
}

-(void)performBinaryOperation:(BinaryOperation)operation {
    NSNumber* n = [self enteredNumber];
    if (n != nil) {
        [stack push:n];
        enteredValue = @"";
    }
    if ([stack height]>1) {
        NSNumber* opr2 = [stack pop];
        NSNumber* opr1 = [stack pop];
        NSNumber* result = [NSNumber numberWithFloat:operation([opr1 floatValue], [opr2 floatValue])];
        [stack push:result];
    }
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    CGFloat h = mainView.bounds.size.height;
    CGFloat w = mainView.bounds.size.width;
    if (h>w) {
        //portrait
        displayBottomToBottom.constant = h/2;
        displayRightToRight.constant = 0.0;
        keypadTopToTop.constant = h/2;
        keypadLeftToLeft.constant = 0.0;
    }
    else {
        //landscape
        displayBottomToBottom.constant = 0.0;
        displayRightToRight.constant = w/2;
        keypadTopToTop.constant = 0.0;
        keypadLeftToLeft.constant = w/2;
    }
}

- (void)updateView {
    enteredValueLabel.text = [enteredValue stringByAppendingString:@"<"];
    NSString* t = @"";
    for (NSInteger i = [stack height]-1; i >= 0; i--) {
        NSNumber* n = [stack getAtIndex:i];
        t = [t stringByAppendingString:[n stringValue]];
        if (i > 0) {
            t = [t stringByAppendingString:@"\n"];
        }
    }
    stackLabel.text = t;
    CGRect slFrame = stackLabel.frame;
    slFrame.size.height = [stackLabel sizeThatFits:slFrame.size].height;
    stackLabel.frame = slFrame;
}

- (void)addCharToInput:(unichar)input {
    NSString* charString = [NSString stringWithCharacters:&input length:1];
    NSString* validChars = @"0123456789.";
    if ([validChars containsString:charString]) {
        enteredValue = [enteredValue stringByAppendingString:charString];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (enteredValue==nil) {
        enteredValue = @"";
    }
    if (stack==nil) {
        stack = [[RPNStack alloc] init];
    }
    keypadView.delegate = self;
    CGFloat h = mainView.bounds.size.height;
    CGFloat w = mainView.bounds.size.width;
    CGFloat fontSize = 20.0*w/320;
    if (h<w) {
        fontSize = fontSize/2;
    }
    [keypadView setFontSize:fontSize];
    enteredValueLabel.font = [enteredValueLabel.font fontWithSize:fontSize];
    stackLabel.font = [stackLabel.font fontWithSize:fontSize];
    [self updateView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keypadView:(KeypadView *)keypadView keyWasPressed:(KeypadKey)keyId {
    switch (keyId) {
        case k0:
            [self addCharToInput:'0'];
            break;
        case k1:
            [self addCharToInput:'1'];
            break;
        case k2:
            [self addCharToInput:'2'];
            break;
        case k3:
            [self addCharToInput:'3'];
            break;
        case k4:
            [self addCharToInput:'4'];
            break;
        case k5:
            [self addCharToInput:'5'];
            break;
        case k6:
            [self addCharToInput:'6'];
            break;
        case k7:
            [self addCharToInput:'7'];
            break;
        case k8:
            [self addCharToInput:'8'];
            break;
        case k9:
            [self addCharToInput:'9'];
            break;
        case kDecPoint:
            if (![enteredValue containsString:@"."]) {
                [self addCharToInput:'.'];
            }
            break;
        case kEnter:
        {
            NSNumber* n = [self enteredNumber];
            if (n != nil) {
                [stack push:n];
            }
            else if ([stack height]>0) {
                [stack push:[[stack getAtIndex:0] copy]];
            }
            else {
                
                [stack push:@0];
            }
            enteredValue = @"";
        }
            break;
        case kNeg:
            if ([enteredValue hasPrefix:@"-"]) {
                enteredValue = [enteredValue substringFromIndex:1];
            }
            else {
                enteredValue = [@"-" stringByAppendingString:enteredValue];
            }
            [self updateView];
            break;
        case kDel:
        {
            NSUInteger len = [enteredValue length];
            if (len>0) {
                enteredValue = [enteredValue substringToIndex:(len-1)];
            }
            else if ([stack height]>0) {
                [stack pop];
            }
        }
            break;
        case kAdd:
        {
            BinaryOperation opr = ^float(float opr1, float opr2) {
                return opr1+opr2;
            };
            [self performBinaryOperation:opr];
        }
            break;
        case kSub:
        {
            BinaryOperation opr = ^float(float opr1, float opr2) {
                return opr1-opr2;
            };
            [self performBinaryOperation:opr];
        }
            break;
        case kMul:
        {
            BinaryOperation opr = ^float(float opr1, float opr2) {
                return opr1*opr2;
            };
            [self performBinaryOperation:opr];
        }
            break;
        case kDiv:
        {
            BinaryOperation opr = ^float(float opr1, float opr2) {
                return opr1/opr2;
            };
            [self performBinaryOperation:opr];
        }
            break;
        case kInv:
        {
            UnaryOperation opr = ^float(float opr1) {
                return 1.0/opr1;
            };
            [self performUnaryOperation:opr];
        }
            break;
        case kPow:
        {
            BinaryOperation opr = ^float(float opr1, float opr2) {
                return powf(opr1,opr2);
            };
            [self performBinaryOperation:opr];
        }
            break;
        case kSqrt:
        {
            UnaryOperation opr = ^float(float opr1) {
                return sqrtf(opr1);
            };
            [self performUnaryOperation:opr];
        }
            break;
        case kExp10:
        {
            UnaryOperation opr = ^float(float opr1) {
                return powf(10, opr1);
            };
            [self performUnaryOperation:opr];
        }
            break;
        case kPi:
        {
            NullaryOperation opr = ^float(void) {
                return M_PI;
            };
            [self performNullaryOperation:opr];
        }
            break;
        case kXRoot:
        {
            BinaryOperation opr = ^float(float opr1, float opr2) {
                return powf(opr1,1.0/opr2);
            };
            [self performBinaryOperation:opr];
        }
            break;
        case kSqr:
        {
            UnaryOperation opr = ^float(float opr1) {
                return opr1*opr1;
            };
            [self performUnaryOperation:opr];
        }
            break;
        case kLog10:
        {
            UnaryOperation opr = ^float(float opr1) {
                return log10f(opr1);
            };
            [self performUnaryOperation:opr];
        }
            break;
        case kSin:
        {
            UnaryOperation opr = ^float(float opr1) {
                return sinf(opr1);
            };
            [self performUnaryOperation:opr];
        }
            break;
        case kCos:
        {
            UnaryOperation opr = ^float(float opr1) {
                return cosf(opr1);
            };
            [self performUnaryOperation:opr];
        }
            break;
        case kTan:
        {
            UnaryOperation opr = ^float(float opr1) {
                return tanf(opr1);
            };
            [self performUnaryOperation:opr];
        }
            break;
        case kExp:
        {
            UnaryOperation opr = ^float(float opr1) {
                return expf(opr1);
            };
            [self performUnaryOperation:opr];
        }
            break;
        case kASin:
        {
            UnaryOperation opr = ^float(float opr1) {
                return asinf(opr1);
            };
            [self performUnaryOperation:opr];
        }
            break;
        case kACos:
        {
            UnaryOperation opr = ^float(float opr1) {
                return acosf(opr1);
            };
            [self performUnaryOperation:opr];
        }
            break;
        case kATan:
        {
            UnaryOperation opr = ^float(float opr1) {
                return atanf(opr1);
            };
            [self performUnaryOperation:opr];
        }
            break;
        case kLog:
        {
            UnaryOperation opr = ^float(float opr1) {
                return logf(opr1);
            };
            [self performUnaryOperation:opr];
        }
            break;
        case kNone:
            //Do nothing
            break;
    }
    
    [self updateView];
}

@end
