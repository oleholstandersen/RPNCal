//
//  KeypadView.m
//  RPNCal
//
//  Created by Ole Holst Andersen on 20/12/14.
//  Copyright (c) 2014 Ole Holst Andersen. All rights reserved.
//

#import "KeypadView.h"

@implementation KeypadView

NSString * getDecimalSeparator() {
    return [[NSLocale currentLocale] objectForKey:NSLocaleDecimalSeparator];
}

- (void)baseInit {
    rows = 5;
    cols = 4;
    marginFactor = 0.1;
    moreKeysShown = FALSE;
    keyButtons = [[NSMutableDictionary alloc] initWithCapacity:kLastKey+1];
    for (NSUInteger i = 0; i <= kLastKey; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button addTarget:self action:@selector(keyClickAction:) forControlEvents:UIControlEventTouchDown];
        [keyButtons setObject:button forKey:[NSNumber numberWithUnsignedInteger:i]];
    }
    [[self getButton:k0] setTitle:@"0" forState:UIControlStateNormal];
    [[self getButton:k1] setTitle:@"1" forState:UIControlStateNormal];
    [[self getButton:k2] setTitle:@"2" forState:UIControlStateNormal];
    [[self getButton:k3] setTitle:@"3" forState:UIControlStateNormal];
    [[self getButton:k4] setTitle:@"4" forState:UIControlStateNormal];
    [[self getButton:k5] setTitle:@"5" forState:UIControlStateNormal];
    [[self getButton:k6] setTitle:@"6" forState:UIControlStateNormal];
    [[self getButton:k7] setTitle:@"7" forState:UIControlStateNormal];
    [[self getButton:k8] setTitle:@"8" forState:UIControlStateNormal];
    [[self getButton:k9] setTitle:@"9" forState:UIControlStateNormal];
    [[self getButton:kDecPoint] setTitle:getDecimalSeparator() forState:UIControlStateNormal];
    [[self getButton:kEnter] setTitle:@"ENTER" forState:UIControlStateNormal];
    [[self getButton:kNeg] setTitle:@"±" forState:UIControlStateNormal];
    [[self getButton:kDel] setTitle:@"DEL" forState:UIControlStateNormal];
    [[self getButton:kAdd] setTitle:@"+" forState:UIControlStateNormal];
    [[self getButton:kSub] setTitle:@"−" forState:UIControlStateNormal];
    [[self getButton:kMul] setTitle:@"×" forState:UIControlStateNormal];
    [[self getButton:kDiv] setTitle:@"÷" forState:UIControlStateNormal];
    moreButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [moreButton setTitle:@"MORE" forState:UIControlStateNormal];
    [moreButton setTitle:@"LESS" forState:UIControlStateSelected];
    [moreButton addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchDown];
    _delegate = nil;
}

- (id)init {
    self = [super init];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (void)refresh {
    [[self getButton:kDecPoint] setTitle:getDecimalSeparator() forState:UIControlStateNormal];
    [moreButton setSelected:moreKeysShown];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [[self getButton:kEnter] setBounds:[self getButtonBounds:0:0:1:2]];
    [[self getButton:kDel] setBounds:[self getButtonBounds:0:2]];
    [[self getButton:k7] setBounds:[self getButtonBounds:1:0]];
    [[self getButton:k8] setBounds:[self getButtonBounds:1:1]];
    [[self getButton:k9] setBounds:[self getButtonBounds:1:2]];
    [[self getButton:kDiv] setBounds:[self getButtonBounds:1:3]];
    [[self getButton:k4] setBounds:[self getButtonBounds:2:0]];
    [[self getButton:k5] setBounds:[self getButtonBounds:2:1]];
    [[self getButton:k6] setBounds:[self getButtonBounds:2:2]];
    [[self getButton:kMul] setBounds:[self getButtonBounds:2:3]];
    [[self getButton:k1] setBounds:[self getButtonBounds:3:0]];
    [[self getButton:k2] setBounds:[self getButtonBounds:3:1]];
    [[self getButton:k3] setBounds:[self getButtonBounds:3:2]];
    [[self getButton:kSub] setBounds:[self getButtonBounds:3:3]];
    [[self getButton:k0] setBounds:[self getButtonBounds:4:0]];
    [[self getButton:kDecPoint] setBounds:[self getButtonBounds:4:0]];
    [[self getButton:kNeg] setBounds:[self getButtonBounds:4:0]];
    [[self getButton:kAdd] setBounds:[self getButtonBounds:4:0]];
    [[self getButton:kInv] setBounds:[self getButtonBounds:1:0]];
}

- (void)updateSubviews {
    for (UIView *v in [self subviews]) {
        [v removeFromSuperview];
    }
    if (moreKeysShown) {
        for (int i = 0; i < kFirstMoreKey; i++) {
            UIButton *b = [self getButton:i];
            if (b != nil) {
                [self addSubview:b];
            }
        }
    }
    else {
        for (int i = kFirstMoreKey; i <= kLastKey; i++) {
            UIButton *b = [self getButton:i];
            if (b != nil) {
                [self addSubview:b];
            }
        }
    }
}

- (void)moreAction {
    moreKeysShown = !moreKeysShown;
    [self updateSubviews];
    [self refresh];
}

- (void)keyClickAction:(UIButton *)sender {
    [self.delegate keypadView:self keyWasPressed:[self getKeyFromButton:sender]];
}

- (KeypadKey)getKeyFromButton:(UIButton *)button {
    for (NSNumber* n in [keyButtons allKeys]) {
        if (keyButtons[n] == button) {
            return (KeypadKey)[n unsignedIntegerValue];
        }
    }
    return kNone;
}

- (UIButton*)getButton:(KeypadKey)key {
    return [keyButtons objectForKey:[NSNumber numberWithUnsignedInteger:key]];
}

- (CGFloat)getButtonHeight {
    return (CGFloat)([self bounds].size.height / ((rows+1)*marginFactor + rows));
}

- (CGFloat)getVerticalButtonMargin {
    return (CGFloat)([self bounds].size.height/((rows+1)+rows/marginFactor));
}

- (CGFloat)getButtonWidth {
    return (CGFloat)([self bounds].size.width / ((cols+1)*marginFactor + cols));
}

- (CGFloat)getHorizontalButtonMargin {
    return (CGFloat)([self bounds].size.width/((cols+1)+cols/marginFactor));
}

- (CGRect)getButtonBounds:(NSUInteger)row :(NSUInteger)col {
    return [self getButtonBounds:row :col :1 :1];
}

- (CGRect)getButtonBounds:(NSUInteger)row :(NSUInteger)col :(NSUInteger)rowSpan :(NSUInteger)colSpan {
    CGFloat vm = [self getVerticalButtonMargin];
    CGFloat hm = [self getHorizontalButtonMargin];
    CGFloat bh = [self getButtonHeight];
    CGFloat bw = [self getButtonWidth];
    return CGRectMake(
                      (col+1) * hm + col * bw,
                      (row+1) * vm + row * bh,
                      colSpan * bw + (colSpan-1) * hm,
                      rowSpan * bh + (rowSpan-1) * vm);
}

@end
