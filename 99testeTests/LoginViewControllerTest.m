//
//  LoginViewControllerTest.m
//  99teste
//
//  Created by Samuel Catalano on 8/31/16.
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LoginViewController.h"
#import "User.h"
#import "Utility.h"

@interface LoginViewControllerTest : XCTestCase

@property (nonatomic) LoginViewController *loginViewController;

@end

@implementation LoginViewControllerTest

- (void)setUp {
    [super setUp];
    self.loginViewController = [[LoginViewController alloc]init];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testLoginValid {
    User *user = [Utility loadCustomObjectWithKey:@"samuelcatalano"]; //usuário definido no primeiro login
    XCTAssertNotEqualObjects(user, nil);
}

- (void)testLoginInvalid {
    User *user = [Utility loadCustomObjectWithKey:@"invalidUsername"];
    XCTAssertEqualObjects(user, nil);
}

- (void)testPerformanceExample {
    [self measureBlock:^{
    }];
}

@end