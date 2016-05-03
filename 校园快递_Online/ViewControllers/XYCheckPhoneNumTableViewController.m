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
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@end

@implementation XYCheckPhoneNumTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mainTableView.tableFooterView = [UIView new];
    
}

- (IBAction)getCodeAction:(id)sender {
    [AVUser currentUser].mobilePhoneNumber = _phoneNumTextfield.text;
    [[AVUser currentUser]saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [AVUser requestMobilePhoneVerify:_phoneNumTextfield.text withBlock:^(BOOL succeeded, NSError *error) {
                if(succeeded){
                    //发送成功
                    NSLog(@"succeeded");
                }
                else{
                    NSLog(@"%@",error);
                }
            }];
        }
    }];
    
}
- (IBAction)sendCodeAction:(id)sender {
    
//    [AVUser signUpOrLoginWithMobilePhoneNumberInBackground:_phoneNumTextfield.text smsCode:_ceodTextField.text block:^(AVUser *user, NSError *error) {
//        [AVUser currentUser].mobilePhoneNumber = user.mobilePhoneNumber;
//        [AVUser currentUser][@"mobilePhoneVerified"] = [NSNumber numberWithBool:[bool true]];
//        
//        NSLog(@"error %@",error);
//    }];
    [AVUser verifyMobilePhone:_codeTextField.text withBlock:^(BOOL succeeded, NSError *error) {
        //验证结果
        if (succeeded) {
            NSLog(@"succeeded");
        }
        else{
            NSLog(@"%@",error);
        }
    }];

}
- (IBAction)action:(id)sender {
    [self.view endEditing:YES];
}
- (IBAction)cancelAction:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
}

@end
