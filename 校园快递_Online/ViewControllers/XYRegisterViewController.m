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
    // Do any additional setup after loading the view.
}
- (IBAction)pickUserHeadImageAction:(id)sender {
    NSLog(@"imagePicke");
}

- (IBAction)registerButtonAction:(id)sender {
    
}


@end
