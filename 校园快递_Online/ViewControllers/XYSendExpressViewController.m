//
//  XYSendExpressViewController.m
//  校园快递_Online
//
//  Created by 白彬涵 on 16/4/26.
//  Copyright © 2016年 Philips. All rights reserved.
//

#import "XYSendExpressViewController.h"

@interface XYSendExpressViewController ()<UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *mainTableView;

@property (weak, nonatomic) IBOutlet UITextField *startPointTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *destinationTextFeild;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIStepper *tipStapper;
@property (weak, nonatomic) IBOutlet UITextField *expressCompanyTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *expressCompanyPhoneTextFeild;
@property (weak, nonatomic) IBOutlet UITextView *otherInfoTextView;
@property (weak, nonatomic) IBOutlet UITextField *typeTextfeild;

@end

@implementation XYSendExpressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mainTableView.tableFooterView = [UIView new];
    // Do any additional setup after loading the view.
}

- (IBAction)changeTipValue:(id)sender {
    UIStepper *stepper = sender;
    [_tipLabel setText:[NSString stringWithFormat:@"%.1f 元",stepper.value]];
}

//发送我的订单
- (IBAction)sendAction:(id)sender {
    [SVProgressHUD showWithStatus:@"加载中"];
    
    AVObject *SendExpressList = [AVObject objectWithClassName:@"LatestExpressList"];
    if (_startPointTextFeild.text&&_destinationTextFeild.text) {
        
        [SendExpressList setObject:_startPointTextFeild.text forKey:@"startPoint"];
        [SendExpressList setObject:_destinationTextFeild.text forKey:@"destination"];
        [SendExpressList setObject:_expressCompanyTextFeild.text forKey:@"expressCompany"];
        [SendExpressList setObject:[NSNumber numberWithDouble: _tipStapper.value] forKey:@"tip"];
        [SendExpressList setObject:[AVUser currentUser] forKey:@"sendUser"];
        [SendExpressList setObject:[AVUser currentUser][@"headImage"] forKey:@"sendUserHeadImage"];
        [SendExpressList setObject:[AVUser currentUser].username forKey:@"sendUserName"];
        [SendExpressList setObject:_expressCompanyPhoneTextFeild.text forKey:@"expressPhone"];
        [SendExpressList setObject:_typeTextfeild.text forKey:@"expressType"];
        [SendExpressList setObject:_otherInfoTextView.text forKey:@"otherInfo"];
        
        [SendExpressList saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [SVProgressHUD showSuccessWithStatus:@"发送成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else{
                [SVProgressHUD showErrorWithStatus:@"发送失败"];
            }
        }];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = _mainTableView.backgroundColor;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 30;
}



@end
