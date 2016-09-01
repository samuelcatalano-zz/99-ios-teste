//
//  RegisterViewControllerTest.m
//  99teste
//
//  Created by Samuel Catalano on 8/31/16.
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RegisterViewController.h"

@interface RegisterViewControllerTest : XCTestCase

@property (nonatomic) RegisterViewController *registerViewController;
@property (nonatomic) NSDictionary *parameters;
@property (nonatomic) NSString *createNewUsuarioURL;

@end

@implementation RegisterViewControllerTest

- (void)setUp {
    [super setUp];
    self.registerViewController = [[RegisterViewController alloc]init];
    self.createNewUsuarioURL = @"http://ec2-54-88-12-34.compute-1.amazonaws.com/v1/users";
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSuccessfulRegister {
    self.parameters = @{@"name": @"99Driver666"};
    NSString *status = [self.registerViewController registerNewUser:self.parameters createUsuarioURL:self.createNewUsuarioURL];
    XCTAssertEqual(status, nil); //Não sei como fazer um test case assíncrono com as melhores práticas
}

- (void)testPerformanceExample {
    [self measureBlock:^{
    }];
}

@end