//
//  HomeViewController.h
//  99teste
//
//  Created by Samuel Catalano on 8/29/16.
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "RegisterViewController.h"

@interface HomeViewController : UIViewController

@property(nonatomic, weak) IBOutlet UILabel     *mainTitle;
@property(nonatomic, weak) IBOutlet UIButton    *btnRegister;
@property(nonatomic, weak) IBOutlet UIButton    *btnLogin;

@end