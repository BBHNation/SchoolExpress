//
//  XYLogInViewController.m
//  校园快递_Online
//
//  Created by 白彬涵 on 16/5/3.
//  Copyright © 2016年 Philips. All rights reserved.
//

#import "XYLogInViewController.h"

@interface XYLogInViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFeild;

@end

@implementation XYLogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (IBAction)logInAction:(id)sender {
    [AVUser logInWithUsernameInBackground:_userNameTextFeild.text password:_passwordTextFeild.text block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [SVProgressHUD showErrorWithStatus:@"用户名或密码错误"];
        }
    }];
}


@end
