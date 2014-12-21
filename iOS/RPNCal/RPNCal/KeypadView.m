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

- (void)setFontSize:(CGFloat)size {
    fontSize = size;
    moreButton.titleLabel.font = [moreButton.titleLabel.font fontWithSize:size];
    for (NSUInteger i = kFirstKey; i <= kLastKey; i++) {
        UIButton *b = [self getButton:i];
        if (b != nil) {
            b.titleLabel.font = [b.titleLabel.font fontWithSize:fontSize];
        }
    }
    [self setButtonTitles];
}

- (void)setButtonTitles {
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
    UIFont *fnt = [moreButton.titleLabel.font fontWithSize:fontSize];
    NSMutableAttributedString *attrStr;
    NSDictionary * attributes;
    attrStr = [[NSMutableAttributedString alloc] initWithString:@"1/x" attributes: @{NSFontAttributeName : fnt}];
    attributes = @{NSFontAttributeName : [fnt fontWithSize:0.9*fontSize],
                   NSBaselineOffsetAttributeName : [NSNumber numberWithFloat:0.3*fontSize] };
    [attrStr setAttributes:attributes range:NSMakeRange(0, 1)];
    attributes = @{NSBaselineOffsetAttributeName : [NSNumber numberWithFloat:0.1*fontSize] };
    [attrStr setAttributes:attributes range:NSMakeRange(1, 1)];
    attributes = @{NSFontAttributeName : [fnt fontWithSize:0.9*fontSize]};
    [attrStr setAttributes:attributes range:NSMakeRange(2, 1)];
    [[self getButton:kInv] setAttributedTitle:attrStr forState:UIControlStateNormal];
    attrStr = [[NSMutableAttributedString alloc] initWithString:@"xy"];
    attributes = @{NSFontAttributeName:[fnt fontWithSize:0.75*fontSize],
                   NSBaselineOffsetAttributeName:[NSNumber numberWithFloat:0.4*fontSize]};
    [attrStr setAttributes:attributes range:NSMakeRange(1,1)];
    [[self getButton:kPow] setAttributedTitle:attrStr forState:UIControlStateNormal];
    [[self getButton:kSqrt] setTitle:@"√x" forState:UIControlStateNormal];
    attrStr = [[NSMutableAttributedString alloc] initWithString:@"10x"];
    [attrStr setAttributes:attributes range:NSMakeRange(2,1)];
    [[self getButton:kExp10] setAttributedTitle:attrStr forState:UIControlStateNormal];
    [[self getButton:kPi] setTitle:@"π" forState:UIControlStateNormal];
    attrStr = [[NSMutableAttributedString alloc] initWithString:@"x√y"];
    [attrStr setAttributes:attributes range:NSMakeRange(0,1)];
    [attrStr addAttribute:NSBaselineOffsetAttributeName value:[NSNumber numberWithFloat:0.15*fontSize] range:NSMakeRange(1, 2)];
    [[self getButton:kXRoot] setAttributedTitle:attrStr forState:UIControlStateNormal];
    attrStr = [[NSMutableAttributedString alloc] initWithString:@"x2"];
    [attrStr setAttributes:attributes range:NSMakeRange(1,1)];
    [[self getButton:kSqr] setAttributedTitle:attrStr forState:UIControlStateNormal];
    [[self getButton:kLog10] setTitle:@"LOG" forState:UIControlStateNormal];
    [[self getButton:kSin] setTitle:@"SIN" forState:UIControlStateNormal];
    [[self getButton:kCos] setTitle:@"COS" forState:UIControlStateNormal];
    [[self getButton:kTan] setTitle:@"TAN" forState:UIControlStateNormal];
    attrStr = [[NSMutableAttributedString alloc] initWithString:@"ex"];
    [attrStr setAttributes:attributes range:NSMakeRange(1,1)];
    [[self getButton:kExp] setAttributedTitle:attrStr forState:UIControlStateNormal];
    [[self getButton:kASin] setTitle:@"ASIN" forState:UIControlStateNormal];
    [[self getButton:kACos] setTitle:@"ACOS" forState:UIControlStateNormal];
    [[self getButton:kATan] setTitle:@"ATAN" forState:UIControlStateNormal];
    [[self getButton:kLog] setTitle:@"LN" forState:UIControlStateNormal];
    [moreButton setTitle:@"⬆︎" forState:UIControlStateNormal];
    [moreButton setTitle:@"⬇︎" forState:UIControlStateSelected];

}

- (void)baseInit {
    rows = 5;
    cols = 4;
    marginFactor = 0.1;
    moreKeysShown = FALSE;
    keyButtons = [[NSMutableDictionary alloc] initWithCapacity:kLastKey+1];
    for (NSUInteger i = kFirstKey; i <= kLastKey; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button addTarget:self action:@selector(keyClickAction:) forControlEvents:UIControlEventTouchDown];
        [keyButtons setObject:button forKey:[NSNumber numberWithUnsignedInteger:i]];
    }
    moreButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [moreButton addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchDown];
    [self setFontSize:17.0];
    [self updateSubviews];
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
    [[self getButton:kEnter] setFrame:[self getButtonFrame:0:0:1:2]];
    [[self getButton:kDel] setFrame:[self getButtonBounds:0:2]];
    [[self getButton:k7] setFrame:[self getButtonBounds:1:0]];
    [[self getButton:k8] setFrame:[self getButtonBounds:1:1]];
    [[self getButton:k9] setFrame:[self getButtonBounds:1:2]];
    [[self getButton:kDiv] setFrame:[self getButtonBounds:1:3]];
    [[self getButton:k4] setFrame:[self getButtonBounds:2:0]];
    [[self getButton:k5] setFrame:[self getButtonBounds:2:1]];
    [[self getButton:k6] setFrame:[self getButtonBounds:2:2]];
    [[self getButton:kMul] setFrame:[self getButtonBounds:2:3]];
    [[self getButton:k1] setFrame:[self getButtonBounds:3:0]];
    [[self getButton:k2] setFrame:[self getButtonBounds:3:1]];
    [[self getButton:k3] setFrame:[self getButtonBounds:3:2]];
    [[self getButton:kSub] setFrame:[self getButtonBounds:3:3]];
    [[self getButton:k0] setFrame:[self getButtonBounds:4:0]];
    [[self getButton:kDecPoint] setFrame:[self getButtonBounds:4:1]];
    [[self getButton:kNeg] setFrame:[self getButtonBounds:4:2]];
    [[self getButton:kAdd] setFrame:[self getButtonBounds:4:3]];
    [[self getButton:kInv] setFrame:[self getButtonBounds:1:0]];
    [[self getButton:kPow] setFrame:[self getButtonBounds:1:1]];
    [[self getButton:kSqrt] setFrame:[self getButtonBounds:1:2]];
    [[self getButton:kExp10] setFrame:[self getButtonBounds:1:3]];
    [[self getButton:kPi] setFrame:[self getButtonBounds:2:0]];
    [[self getButton:kXRoot] setFrame:[self getButtonBounds:2:1]];
    [[self getButton:kSqr] setFrame:[self getButtonBounds:2:2]];
    [[self getButton:kLog10] setFrame:[self getButtonBounds:2:3]];
    [[self getButton:kSin] setFrame:[self getButtonBounds:3:0]];
    [[self getButton:kCos] setFrame:[self getButtonBounds:3:1]];
    [[self getButton:kTan] setFrame:[self getButtonBounds:3:2]];
    [[self getButton:kExp] setFrame:[self getButtonBounds:3:3]];
    [[self getButton:kASin] setFrame:[self getButtonBounds:4:0]];
    [[self getButton:kACos] setFrame:[self getButtonBounds:4:1]];
    [[self getButton:kATan] setFrame:[self getButtonBounds:4:2]];
    [[self getButton:kLog] setFrame:[self getButtonBounds:4:3]];
    [moreButton setFrame:[self getButtonBounds:0:3]];
}

- (void)updateSubviews {
    for (UIView *v in [self subviews]) {
        [v removeFromSuperview];
    }
    if (moreKeysShown) {
        for (int i = kFirstMoreKey; i <= kLastKey; i++) {
            UIButton *b = [self getButton:i];
            if (b != nil) {
                [self addSubview:b];
            }
        }
    }
    else {
        for (int i = kFirstKey; i < kFirstMoreKey; i++) {
            UIButton *b = [self getButton:i];
            if (b != nil) {
                [self addSubview:b];
            }
        }
    }
    [self addSubview:moreButton];
    [self setNeedsLayout];
    [self refresh];
}

- (void)moreAction {
    moreKeysShown = !moreKeysShown;
    [self updateSubviews];
    [self refresh];
}

- (void)keyClickAction:(UIButton *)sender {
    moreKeysShown = false;
    [self updateSubviews];
    [self refresh];
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
    UIButton *result = [keyButtons objectForKey:[NSNumber numberWithUnsignedInteger:key]];
    return result;
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
    return [self getButtonFrame:row :col :1 :1];
}

- (CGRect)getButtonFrame:(NSUInteger)row :(NSUInteger)col :(NSUInteger)rowSpan :(NSUInteger)colSpan {
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
