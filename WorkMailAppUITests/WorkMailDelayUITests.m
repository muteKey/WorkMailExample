//
//  WorkMailDelayUITests.m
//  WorkMailApp
//
//  Created by Kirill Ushkov on 2/24/16.
//  Copyright © 2016 Kirill Ushkov. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface WorkMailDelayUITests : XCTestCase

@end

@implementation WorkMailDelayUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDatePickerShow {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tables.staticTexts[@"Warns your colleagues if you are not working at specified date"] tap];
    
    [app.buttons[@"EnterDateAction"] tap];

    // check date picker is visible
    XCTAssertTrue(app.otherElements[@"DatePickerView"].isHittable);
}

- (void)testKeyboardShowAndHide {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tables.staticTexts[@"Warns your colleagues if you are not working at specified date"] tap];
    [app.textFields[@"AdditionalNoteField"] tap];
    XCTAssertEqual(app.keyboards.count, 1);
    [app.keyboards.buttons[@"Done"] tap];
    XCTAssertEqual(app.keyboards.count, 0);
}

- (void)testAlertControllerShow {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tables.staticTexts[@"Warns your colleagues if you are not working at specified date"] tap];
    [app.navigationBars[@"Day off"].buttons[@"Done"] tap];
    XCTAssertTrue(app.alerts[@"Error"]);
    [app.alerts[@"Error"].collectionViews.buttons[@"OK"] tap];
    XCTAssertFalse(app.alerts[@"Error"].exists);
}

@end
