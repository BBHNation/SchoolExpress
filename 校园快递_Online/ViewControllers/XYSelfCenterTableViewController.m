//
//  XYSelfCenterTableViewController.m
//  校园快递_Online
//
//  Created by 白彬涵 on 16/5/4.
//  Copyright © 2016年 Philips. All rights reserved.
//

#import "XYSelfCenterTableViewController.h"

@interface XYSelfCenterTableViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *userHeadImage;
@property (weak, nonatomic) IBOutlet UITableViewCell *userName;

@end

@implementation XYSelfCenterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_userHeadImage sd_setImageWithURL:[NSURL URLWithString:[AVUser currentUser][@"headImage"]]];
    _userHeadImage.layer.borderColor = [UIColor whiteColor].CGColor;
    [_userName.detailTextLabel setText:[AVUser currentUser].username];
}

- (IBAction)logOut:(id)sender {
    [AVUser logOut];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
