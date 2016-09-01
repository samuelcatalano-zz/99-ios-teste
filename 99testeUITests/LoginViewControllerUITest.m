//
//  LoginViewControllerUITest.m
//  99teste
//
//  Created by Samuel Catalano on 9/1/16.
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface LoginViewControllerUITest : XCTestCase

@end

@implementation LoginViewControllerUITest

- (void)setUp {
    [super setUp];
    self.continueAfterFailure = NO;
    [[[XCUIApplication alloc] init] launch];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testBtnLoginClicked
{
    [[[XCUIApplication alloc] init].buttons[@"LOGIN"] tap];
}

- (void)testLoginFailed
{
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *loginButton = app.buttons[@"LOGIN"];
    [loginButton tap];
    [loginButton tap];
    [app.alerts[@"Login failed"].collectionViews.buttons[@"OK"] tap];
}

- (void)testLoginSuccess
{
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *loginButton = app.buttons[@"LOGIN"];
    [loginButton tap];
    [app.textFields[@"Username"] tap];
    app.textFields[@"Username"];
    
    XCUIElement *passwordSecureTextField = app.secureTextFields[@"Password"];
    [passwordSecureTextField tap];
    [passwordSecureTextField tap];
    app.secureTextFields[@"Password"];
    [loginButton pressForDuration:0.5];
}

@end