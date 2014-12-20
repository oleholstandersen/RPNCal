//
//  KeypadView.h
//  RPNCal
//
//  Created by Ole Holst Andersen on 20/12/14.
//  Copyright (c) 2014 Ole Holst Andersen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, KeypadKey) {
    kNone = 0,
    k0,
    k1,
    k2,
    k3,
    k4,
    k5,
    k6,
    k7,
    k8,
    k9,
    kDecPoint,
    kEnter,
    kNeg,
    kDel,
    kAdd,
    kSub,
    kMul,
    kDiv,
    kInv,
    kFirstMoreKey = kInv,
    kLastKey = kInv
};

@class KeypadView;

@protocol KeyPressedDelegate
- (void)keypadView:(KeypadView *)keypadView keyWasPressed:(KeypadKey)keyId;
@end

@interface KeypadView : UIView {
    NSUInteger rows;
    NSUInteger cols;
    float marginFactor;
    BOOL moreKeysShown;
    NSMutableDictionary *keyButtons;
    UIButton *moreButton;
}

@property (strong) NSLocale *currentLocale;
@property (assign) id <KeyPressedDelegate> delegate;

@end
