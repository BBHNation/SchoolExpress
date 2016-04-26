//
//  XYRegisterViewController.m
//  校园快递_Online
//
//  Created by 白彬涵 on 16/4/26.
//  Copyright © 2016年 Philips. All rights reserved.
//

#import "XYRegisterViewController.h"

@interface XYRegisterViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *userHeadImageView;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *passwordAgainFeild;

@end

@implementation XYRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)pickUserHeadImageAction:(id)sender {
    
    NSLog(@"imagePicke");
}

- (IBAction)registerButtonAction:(id)sender {
    if (_passwordTextFeild.text&&_userNameTextFeild.text&&_passwordAgainFeild.text) {
        AVUser *user = [AVUser user];
        user.username = _userNameTextFeild.text;
        user.password = _passwordTextFeild.text;
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"注册成功");
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else{
                NSLog(@"注册失败");
            }
        }];
    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


@end
