//
//  XYLogInViewController.m
//  校园快递_Online
//
//  Created by 白彬涵 on 16/5/3.
//  Copyright © 2016年 Philips. All rights reserved.
//

#import "XYLogInViewController.h"

@interface XYLogInViewController ()

@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFeild;

@end

@implementation XYLogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"registBackImage"]];
    [_mainTableView setBackgroundView:imageview];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (IBAction)endEidting:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)logInAction:(id)sender {
    [SVProgressHUD showWithStatus:@"登录中"];
    [_mainTableView setUserInteractionEnabled:NO];
    [AVUser logInWithUsernameInBackground:_userNameTextFeild.text password:_passwordTextFeild.text block:^(AVUser *user, NSError *error) {
        [_mainTableView setUserInteractionEnabled:YES];
        if (user != nil) {
            [self dismissViewControllerAnimated:YES completion:nil];
            [SVProgressHUD dismiss];
        } else {
            [SVProgressHUD showErrorWithStatus:@"用户名或密码错误"];
        }
    }];
}


@end
