//
//  XYAcceptExpressViewController.m
//  校园快递_Online
//
//  Created by 白彬涵 on 16/4/26.
//  Copyright © 2016年 Philips. All rights reserved.
//

#import "XYAcceptExpressViewController.h"

@interface XYAcceptExpressViewController ()

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end

@implementation XYAcceptExpressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_userNameLabel setText:@"hello world"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
