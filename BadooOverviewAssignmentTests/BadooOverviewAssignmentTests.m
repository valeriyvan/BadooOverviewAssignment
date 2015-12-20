//
//  BadooOverviewAssignmentTests.m
//  BadooOverviewAssignmentTests
//
//  Created by Valeriy Van on 19.12.15.
//  Copyright (c) 2015 Badoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "BADConvertionRates.h"

@interface BadooOverviewAssignmentTests : XCTestCase

@end

@implementation BadooOverviewAssignmentTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testOneStep {
    NSArray *array = @[ @{ @"from": @"USD", @"to": @"GBP", @"rate": @"2.0" } ];
    BADConvertionRates *rates = [[BADConvertionRates alloc] initWithRates:array];
    XCTAssert([rates rateFrom:@"USD" to:@"GBP"] == 2.0, @"Pass one step test");
}

- (void)testTwoStep {
    NSArray *array = @[ @{ @"from": @"CAD", @"to": @"USD", @"rate": @"2.0" }, @{ @"from": @"USD", @"to": @"GBP", @"rate": @"2.0" } ];
    BADConvertionRates *rates = [[BADConvertionRates alloc] initWithRates:array];
    XCTAssert([rates rateFrom:@"CAD" to:@"GBP"] == 4.0, @"Pass double step test");
}

- (void)testThreeStep {
    NSArray *array = @[ @{ @"from": @"AUD", @"to": @"CAD", @"rate": @"2.0" }, @{ @"from": @"CAD", @"to": @"USD", @"rate": @"2.0" }, @{ @"from": @"USD", @"to": @"GBP", @"rate": @"2.0" } ];
    BADConvertionRates *rates = [[BADConvertionRates alloc] initWithRates:array];
    XCTAssert([rates rateFrom:@"AUD" to:@"GBP"] == 8.0, @"Pass tripple step test");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
