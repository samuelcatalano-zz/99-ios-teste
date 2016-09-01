//
//  RegisterViewController.m
//  99teste
//
//  Created by Samuel Catalano on 8/29/16.
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import "RegisterViewController.h"
#import "User.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import "Constants.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)btnExitClicked:(id)sender
{
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnRegisterClicked:(id)sender
{
    NSDictionary *parameters = @{@"name": _txtFirstName.text};
    
    [self registerNewUser:parameters createUsuarioURL:urlCreateNewUsuario];
}

- (NSString *)registerNewUser:(NSDictionary *)parameters createUsuarioURL:(NSString *)createUsuarioURL
{
    __block NSString *status;
    if ([self checkFieldsFilled]) {

        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
        [manager POST:createUsuarioURL parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
            NSString *location = httpResponse.allHeaderFields[@"Location"];
            NSLog(@"%@",location);
            
            [manager GET:location parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject)
            {
                NSLog(@"%@",responseObject);
                id idUsuario = responseObject[@"id"];
                [self createNewUser:idUsuario];
                status = @"success";
                [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil]; //dismiss viewcontroller
            }
            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
            {
                NSLog(@"Fail");
                NSLog(@"%@",error);
                status = @"fail";
            }];
        }
        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
        {
            NSLog(@"Fail");
            status = @"fail";
        }];
     }
    
    return status;
}

- (void)createNewUser:(id) idUsuario
{
    User *newUser = [[User alloc]init];
    newUser.idUsuario   = idUsuario;
    newUser.firstName   = _txtFirstName.text;
    newUser.lastName    = _txtLastName.text;
    newUser.username    = _txtUsername.text;
    newUser.password    = _txtPassword.text;
    
    [self saveNewUserAtUserDefaults:newUser key:newUser.username];
}

- (void)saveNewUserAtUserDefaults:(User *)object key:(NSString *)key
{
    NSUserDefaults *defaults    = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject       = [NSKeyedArchiver archivedDataWithRootObject:object];
    [defaults setObject:encodedObject forKey:key];
    [defaults synchronize];
}


-(BOOL)checkFieldsFilled {
    if (_txtFirstName.text && _txtFirstName.text.length > 0  &&
        _txtLastName.text &&  _txtLastName.text.length >  0  &&
        _txtUsername.text &&  _txtUsername.text.length >  0  &&
        _txtPassword.text && _txtUsername.text.length  >  0) {
        return YES;
    }
    else {
        NSString *msgTitle = @"Info";
        NSString *msg = @"Please fill in all fields";
        [self showUIMessage:msg msgTitle:msgTitle];
        return NO;
    }
}

-(void)showUIMessage:(NSString *)msg msgTitle:(NSString *)msgTitle
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:msgTitle message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)hideKeyBoard
{
    [_txtFirstName resignFirstResponder];
    [_txtLastName  resignFirstResponder];
    [_txtUsername  resignFirstResponder];
    [_txtPassword  resignFirstResponder];
}

@end