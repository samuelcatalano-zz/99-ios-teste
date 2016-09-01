//
//  RegisterViewControllerUITest.m
//  99teste
//
//  Created by Samuel Catalano on 9/1/16.
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface RegisterViewControllerUITest : XCTestCase

@end

@implementation RegisterViewControllerUITest

- (void)setUp
{
    [super setUp];
    self.continueAfterFailure = NO;
    [[[XCUIApplication alloc] init] launch];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testBtnRegisterClicked
{
    [[[XCUIApplication alloc] init].buttons[@"REGISTER"] tap];
}

- (void)testRegisterFailed
{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *registerButton = app.buttons[@"REGISTER"];
    [registerButton tap];
    [registerButton tap];
    [app.alerts[@"Info"].collectionViews.buttons[@"OK"] tap];
}

- (void)testRegisterSuccess
{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *registerButton = app.buttons[@"REGISTER"];
    [registerButton tap];
    
    XCUIElement *firstNameTextField = app.textFields[@"First Name"];
    [firstNameTextField tap];
    [firstNameTextField tap];
    app.textFields[@"First Name"];
    
    XCUIElement *lastNameTextField = app.textFields[@"Last Name"];
    [lastNameTextField tap];
    [lastNameTextField tap];
    app.textFields[@"Last Name"];
    
    XCUIElement *usernameTextField = app.textFields[@"Username"];
    [usernameTextField tap];
    [usernameTextField tap];
    app.textFields[@"Username"];
    
    XCUIElement *passwordSecureTextField = app.secureTextFields[@"Password"];
    [passwordSecureTextField tap];
    [passwordSecureTextField tap];
    app.secureTextFields[@"Password"];
    [registerButton tap];
}

@end