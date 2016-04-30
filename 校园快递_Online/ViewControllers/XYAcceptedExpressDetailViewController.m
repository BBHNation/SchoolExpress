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
@property (weak, nonatomic) IBOutlet UIImageView *userHeadImage;
@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UIImageView *acceptedUserHeadImage;

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
        [weakSelf.userHeadImage sd_setImageWithURL:[NSURL URLWithString:user[@"headImage"]] placeholderImage:nil];
    }];
}
- (IBAction)determineToReceive:(id)sender {
    BOOL completed = YES;
    [_cellItem setObject:[NSNumber numberWithBool:completed] forKey:@"completed"];
    [_cellItem saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"完成");
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            NSLog(@"E%@",error);
        }
    }];
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
