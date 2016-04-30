//
//  XYCheckPhoneNumTableViewController.m
//  校园快递_Online
//
//  Created by 白彬涵 on 16/4/29.
//  Copyright © 2016年 Philips. All rights reserved.
//

#import "XYCheckPhoneNumTableViewController.h"

@interface XYCheckPhoneNumTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextfield;
@property (weak, nonatomic) IBOutlet UITextField *ceodTextField;

@end

@implementation XYCheckPhoneNumTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mainTableView.tableFooterView = [UIView new];
    
}

- (IBAction)getCodeAction:(id)sender {
    [AVOSCloud requestSmsCodeWithPhoneNumber:_phoneNumTextfield.text callback:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"succeeded");
        }
        else{
            NSLog(@"e%@",error);
        }
        // 发送失败可以查看 error 里面提供的信息
    }];
}
- (IBAction)sendCodeAction:(id)sender {
    [AVUser signUpOrLoginWithMobilePhoneNumberInBackground:_phoneNumTextfield.text smsCode:_ceodTextField.text block:^(AVUser *user, NSError *error) {
        NSLog(@"error %@",error);
    }];

}
- (IBAction)action:(id)sender {
    [self.view endEditing:YES];
}


- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
}

@end
