//
//  LoginViewController.h
//  99teste
//
//  Created by Samuel Catalano on 8/29/16.
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "PrincipalViewController.h"

@interface LoginViewController : UIViewController

@property(nonatomic, weak) IBOutlet UIButton   *btnLogin;
@property(nonatomic, weak) IBOutlet UIButton   *btnExit;

@property(nonatomic, weak) IBOutlet UITextField   *txtUsername;
@property(nonatomic, weak) IBOutlet UITextField   *txtPassword;

@end