//
//  XYSendExpressViewController.m
//  校园快递_Online
//
//  Created by 白彬涵 on 16/4/26.
//  Copyright © 2016年 Philips. All rights reserved.
//

#import "XYSendExpressViewController.h"

@interface XYSendExpressViewController ()

@property (weak, nonatomic) IBOutlet UITextField *startPointTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *destinationTextFeild;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIStepper *tipStapper;
@property (weak, nonatomic) IBOutlet UITextField *expressCompanyTextFeild;

@end

@implementation XYSendExpressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)changeTipValue:(id)sender {
    UIStepper *stepper = sender;
    [_tipLabel setText:[NSString stringWithFormat:@"tip is %.1f 元",stepper.value]];
}

//发送我的订单
- (IBAction)sendAction:(id)sender {
    AVObject *SendExpressList = [AVObject objectWithClassName:@"LatestExpressList"];
    if (_startPointTextFeild.text&&_destinationTextFeild.text) {
        
        [SendExpressList setObject:_startPointTextFeild.text forKey:@"startPoint"];
        [SendExpressList setObject:_destinationTextFeild.text forKey:@"destination"];
        [SendExpressList setObject:_expressCompanyTextFeild.text forKey:@"expressCompany"];
        [SendExpressList setObject:[NSNumber numberWithDouble: _tipStapper.value] forKey:@"tip"];
        [SendExpressList setObject:[AVUser currentUser] forKey:@"sendUser"];
        
        [SendExpressList saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"succeeded");
            }
            else{
                NSLog(@"faild");
            }
        }];
        
        /*
        AVQuery *query = [AVQuery queryWithClassName:@"_User"];
        [query getObjectInBackgroundWithId:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] block:^(AVObject *object, NSError *error) {
            AVUser *user = (AVUser *)object;
            
            
            [SendExpressList saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"succedede");
                }
                else{
                    NSLog(@"error %@",error);
                }
            }];
        }];
         */
    }
}

- (void)getUser{
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
