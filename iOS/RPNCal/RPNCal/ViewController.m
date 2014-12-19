//
//  ViewController.m
//  RPNCal
//
//  Created by Ole Holst Andersen on 06/12/14.
//  Copyright (c) 2014 Ole Holst Andersen. All rights reserved.
//

#import "ViewController.h"

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
    [self updateView];
}

- (void)updateView {
    inputLabel.text = [enteredValue stringByAppendingString:@"<"];
    NSString* t = @"";
    for (int i = [stack height]-1; i >= 0; i--) {
        NSNumber* n = [stack getAtIndex:i];
        t = [t stringByAppendingString:[n stringValue]];
        if (i > 0) {
            t = [t stringByAppendingString:@"\n"];
        }
    }
    stackLabel.text = t;
    [stackLabel sizeToFit];
}

- (void)addCharToInput:(unichar)input {
    NSString* charString = [NSString stringWithCharacters:&input length:1];
    NSString* validChars = @"0123456789.";
    if ([validChars containsString:charString]) {
        enteredValue = [enteredValue stringByAppendingString:charString];
    }
    [self updateView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (enteredValue==nil) {
        enteredValue = @"";
    }
    if (stack==nil) {
        stack = [[RPNStack alloc] init];
    }
    [self updateView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)enterTouchDown:(id)sender {
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
    [self updateView];
}
- (IBAction)delTouchDown:(id)sender {
    int len = [enteredValue length];
    if (len>0) {
        enteredValue = [enteredValue substringToIndex:(len-1)];
    }
    else if ([stack height]>0) {
        [stack pop];
    }
    [self updateView];
}
- (IBAction)decPointTouchDown:(id)sender {
    if (![enteredValue containsString:@"."]) {
        [self addCharToInput:'.'];
    }
}
- (IBAction)negTouchDown:(id)sender {
    if ([enteredValue hasPrefix:@"-"]) {
        enteredValue = [enteredValue substringFromIndex:1];
    }
    else {
        enteredValue = [@"-" stringByAppendingString:enteredValue];
    }
    [self updateView];
}
- (IBAction)b0TouchDown:(id)sender {
    [self addCharToInput:'0'];
}
- (IBAction)b1TouchDown:(id)sender {
    [self addCharToInput:'1'];
}
- (IBAction)b2TouchDown:(id)sender {
    [self addCharToInput:'2'];
}
- (IBAction)b3TouchDown:(id)sender {
    [self addCharToInput:'3'];
}
- (IBAction)b4TouchDown:(id)sender {
    [self addCharToInput:'4'];
}
- (IBAction)b5TouchDown:(id)sender {
    [self addCharToInput:'5'];
}
- (IBAction)b6TouchDown:(id)sender {
    [self addCharToInput:'6'];
}
- (IBAction)b7TouchDown:(id)sender {
    [self addCharToInput:'7'];
}
- (IBAction)b8TouchDown:(id)sender {
    [self addCharToInput:'8'];
}
- (IBAction)b9TouchDown:(id)sender {
    [self addCharToInput:'9'];
}
- (IBAction)addTouchDown:(id)sender {
    BinaryOperation addOpr = ^float(float opr1, float opr2) {
        return opr1+opr2;
    };
    [self performBinaryOperation:addOpr];
}
- (IBAction)subTouchDown:(id)sender {
}
- (IBAction)mulTouchDown:(id)sender {
}
- (IBAction)divTouchDown:(id)sender {
}

@end
