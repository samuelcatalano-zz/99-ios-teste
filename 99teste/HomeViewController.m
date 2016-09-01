//
//  HomeViewController.m
//  99teste
//
//  Created by Samuel Catalano on 8/29/16.
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import "HomeViewController.h"
#import "RegisterViewController.h"
#import "LoginViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fontsCustomized];
}

- (IBAction)btnLoginClicked:(id)sender
{
    LoginViewController *controller = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)btnRegisterClicked:(id)sender
{
    RegisterViewController *controller = [[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)fontsCustomized
{
    _mainTitle.font                 = [UIFont fontWithName:@"Exo2-Bold"     size:21];
    _btnRegister.titleLabel.font    = [UIFont fontWithName:@"Exo2-SemiBold" size:14];
    _btnLogin.titleLabel.font       = [UIFont fontWithName:@"Exo2-SemiBold" size:14];
}

@end