//
//  XYAcceptedExpressDetailViewController.m
//  校园快递_Online
//
//  Created by 白彬涵 on 16/4/27.
//  Copyright © 2016年 Philips. All rights reserved.
//

#import "XYAcceptedExpressDetailViewController.h"

@interface XYAcceptedExpressDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UIImageView *acceptedUserHeadImage;
@property (weak, nonatomic) IBOutlet UITableViewCell *acceptedUserPhoneNum;
@property (weak, nonatomic) IBOutlet UITableViewCell *realName;
@property (weak, nonatomic) IBOutlet UITableViewCell *schoolId;
@property (weak, nonatomic) IBOutlet UITableViewCell *startPoint;
@property (weak, nonatomic) IBOutlet UITableViewCell *destination;
@property (weak, nonatomic) IBOutlet UITableViewCell *expressCompany;

@end

@implementation XYAcceptedExpressDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCellItem];
    _acceptedUserHeadImage.layer.borderColor = [UIColor whiteColor].CGColor;
    _mainTableView.tableFooterView = [UIView new];
    
    // Do any additional setup after loading the view.
}

- (void)setCellItem {
    AVUser *user = _cellItem[@"undertakeUser"];
    AVQuery *query = [AVQuery queryWithClassName:@"_User"];
    __weak typeof(self) weakSelf = self;
    [query getObjectInBackgroundWithId:user.objectId block:^(AVObject *object, NSError *error) {
        AVUser *user = (AVUser *)object;
        [weakSelf.userNameLabel setText:user.username];
        [weakSelf.acceptedUserHeadImage sd_setImageWithURL:[NSURL URLWithString:user[@"headImage"]] placeholderImage:nil];
        [weakSelf.acceptedUserPhoneNum.detailTextLabel setText:user.mobilePhoneNumber];
        [weakSelf.realName.detailTextLabel setText:user[@"realName"]];
        [weakSelf.schoolId.detailTextLabel setText:user[@"schoolId"]];
    }];
    
    [_startPoint.detailTextLabel setText:_cellItem[@"startPoint"]];
    [_destination.detailTextLabel setText:_cellItem[@"destination"]];
    [_expressCompany.detailTextLabel setText:_cellItem[@"expressCompany"]];
}


- (IBAction)determineToReceive:(id)sender {
    [SVProgressHUD showWithStatus:@"加载中..."];
    BOOL completed = YES;
    [_cellItem setObject:[NSNumber numberWithBool:completed] forKey:@"completed"];
    [_cellItem saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"完成");
            [SVProgressHUD showSuccessWithStatus:@"收货成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            NSLog(@"E%@",error);
            [SVProgressHUD showErrorWithStatus:@"收货失败"];
        }
    }];
}

- (IBAction)call:(id)sender {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",_acceptedUserPhoneNum.detailTextLabel.text]];
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (IBAction)sendMessage:(id)sender {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",_acceptedUserPhoneNum.detailTextLabel.text]];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}


- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = _mainTableView.backgroundColor;
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
@end
