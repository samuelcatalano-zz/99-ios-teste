//
//  RegisterViewController.h
//  99teste
//
//  Created by Samuel Catalano on 8/29/16.
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Constants.h"

@interface RegisterViewController : UIViewController

-(NSString *)registerNewUser:(NSDictionary *)parameters createUsuarioURL:(NSString *)createUsuarioURL;

@property(nonatomic,weak) IBOutlet UIButton      *btnRegister;
@property(nonatomic,weak) IBOutlet UIButton      *btnExit;
@property(nonatomic,weak) IBOutlet UITextField   *txtFirstName;
@property(nonatomic,weak) IBOutlet UITextField   *txtLastName;
@property(nonatomic,weak) IBOutlet UITextField   *txtUsername;
@property(nonatomic,weak) IBOutlet UITextField   *txtPassword;

@end