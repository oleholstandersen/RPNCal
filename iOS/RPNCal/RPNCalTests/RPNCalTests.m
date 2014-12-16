//
//  RPNCalTests.m
//  RPNCalTests
//
//  Created by Ole Holst Andersen on 06/12/14.
//  Copyright (c) 2014 Ole Holst Andersen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "../RPNCal/RPNStack.h"

@interface RPNCalTests : XCTestCase

@end

@implementation RPNCalTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPush {
    RPNStack* stack = [[RPNStack alloc] init];
    [stack push:@0];
    // This is an example of a functional test case.
    XCTAssert([stack height]==1, @"Pass");
}

- (void)testPop {
    RPNStack* stack = [[RPNStack alloc] init];
    [stack push:@1];
    // This is an example of a functional test case.
    XCTAssert([[stack pop] isEqualToNumber:@1], @"Pass");
    
}

@end
