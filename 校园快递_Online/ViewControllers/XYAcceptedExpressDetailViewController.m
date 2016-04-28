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

@end

@implementation XYAcceptedExpressDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCellItem];
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
@end
