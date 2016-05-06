//
//  XYToBeCourierTableViewController.m
//  校园快递_Online
//
//  Created by 白彬涵 on 16/5/3.
//  Copyright © 2016年 Philips. All rights reserved.
//

#import "XYToBeCourierTableViewController.h"

@interface XYToBeCourierTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *schoolId;
@property (weak, nonatomic) IBOutlet UITextField *realName;
@property (weak, nonatomic) IBOutlet UITextField *IDCardid;

@end

@implementation XYToBeCourierTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)toBeCourier:(id)sender {
    if ([AVUser currentUser].mobilePhoneVerified) {
        [SVProgressHUD showWithStatus:@"验证中"];
        [[AVUser currentUser]setObject:[NSNumber numberWithBool:YES] forKey:@"isCourier"];
        [[AVUser currentUser]setObject:_schoolId.text forKey:@"schoolId"];
        [[AVUser currentUser]setObject:_IDCardid.text forKey:@"IDCardId"];
        [[AVUser currentUser]setObject:_realName.text forKey:@"realName"];
        [[AVUser currentUser]saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [SVProgressHUD showSuccessWithStatus:@"验证成功"];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else{
                [SVProgressHUD showErrorWithStatus:@"验证失败"];
                NSLog(@"%@",error);
            }
        }];
    }
    else{
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"验证手机号" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self performSegueWithIdentifier:@"checkPhoneNum" sender:self];
        }];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误" message:@"请先验证手机号" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0&&indexPath.row==0) {
        if ([AVUser currentUser].mobilePhoneVerified) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            }];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"手机号已经被验证" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:action];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else {
           [self performSegueWithIdentifier:@"checkPhoneNum" sender:self];
        }
    }
    else{
        [self.view endEditing:YES];
    }
}

@end
