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

- (id) init {
    if (self = [super init]) {
        stack = [[RPNStack alloc] init];
        enteredValue = @"";
        return self;
    }
    return nil;
}

- (void)addCharToInput:(unichar)input {
    NSString* charString = [NSString stringWithCharacters:&input length:1];
    NSString* validChars = @"0123456789.";
    if ([validChars containsString:charString]) {
        enteredValue = [enteredValue stringByAppendingString:charString];
    }
    inputLabel.text = enteredValue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (enteredValue==nil) {
        enteredValue = @"";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    inputLabel.text = enteredValue;
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

@end
