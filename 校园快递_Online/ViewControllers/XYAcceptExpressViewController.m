//
//  XYAcceptExpressViewController.m
//  校园快递_Online
//
//  Created by 白彬涵 on 16/4/26.
//  Copyright © 2016年 Philips. All rights reserved.
//

#import "XYAcceptExpressViewController.h"

@interface XYAcceptExpressViewController ()<UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *mainTableView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userHeadImage;
@property (weak, nonatomic) IBOutlet UITableViewCell *startPoint;
@property (weak, nonatomic) IBOutlet UITableViewCell *destination;
@property (weak, nonatomic) IBOutlet UITableViewCell *expressCompany;
@property (weak, nonatomic) IBOutlet UITableViewCell *thingType;
@property (weak, nonatomic) IBOutlet UITableViewCell *tip;
@property (weak, nonatomic) IBOutlet UILabel *otherInfo;
@property (weak, nonatomic) IBOutlet UITableViewCell *expressPhone;

@end

@implementation XYAcceptExpressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [_startPoint.detailTextLabel setText:_cellItem[@"startPoint"]];
    [_destination.detailTextLabel setText:_cellItem[@"destination"]];
    [_expressCompany.detailTextLabel setText:_cellItem[@"expressCompany"]];
    [_tip.detailTextLabel setText:[NSString stringWithFormat:@"%@",_cellItem[@"tip"]]];
    [_expressPhone.detailTextLabel setText:_cellItem[@"expressPhone"]];
    [_thingType.detailTextLabel setText:_cellItem[@"expressType"]];
    [_otherInfo setText:_cellItem[@"otherInfo"]];
    
    _mainTableView.tableFooterView = [UIView new];
    AVQuery *query = [AVQuery queryWithClassName:@"_User"];
    AVUser *user = _cellItem[@"sendUser"];
    __weak typeof(self) weakSelf = self;
    [query getObjectInBackgroundWithId:user.objectId block:^(AVObject *object, NSError *error) {
        AVUser *user = (AVUser *)object;
        [weakSelf.userNameLabel setText:user.username];
        [weakSelf.userHeadImage sd_setImageWithURL:[NSURL URLWithString:user[@"headImage"]] placeholderImage:nil];
    }];
    // Do any additional setup after loading the view.
}
- (IBAction)acceptAction:(id)sender {
    if (![AVUser currentUser]) {
        [self presentViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginAndRegister"] animated:YES completion:nil];
    }
    else if (![[AVUser currentUser][@"isCourier"] boolValue]) {
        [self presentViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ToBeCourier"] animated:YES completion:nil];
    }
    else{
        [SVProgressHUD showWithStatus:@"加载中"];
        [_cellItem setObject:[AVUser currentUser] forKey:@"undertakeUser"];
        [_cellItem setObject:[AVUser currentUser].username forKey:@"undertakeUserName"];
        [_cellItem setObject:[AVUser currentUser][@"headImage"] forKey:@"undertakeUserHeadImage"];
        
        BOOL boolnum = YES;
        [_cellItem setObject:[NSNumber numberWithBool:boolnum] forKey:@"isAccepted"];
        [_cellItem saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"succeeded");
                [SVProgressHUD showSuccessWithStatus:@"接单成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else {
                [SVProgressHUD showErrorWithStatus:@"接单失败"];
                NSLog(@"error %@",error);
            }
        }];
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
