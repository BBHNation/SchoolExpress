//
//  XYMainViewController.m
//  校园快递_Online
//
//  Created by 白彬涵 on 16/4/25.
//  Copyright © 2016年 Philips. All rights reserved.
//

#import "XYMainViewController.h"
#import "XYMainTableViewCell.h"


@interface XYMainViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView *mainTableView;

@end

@implementation XYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"HOME"];
    self.view.backgroundColor = [UIColor redColor];
    
    if (![[[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"] boolValue]) {
        
        [self presentViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginAndRegister"] animated:YES completion:nil];
    }
    else{
        NSLog(@"已经登陆");
    }
    
    // Do any additional setup after loading the view.
}


- (IBAction)SendMyEcpressAction:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
        self.hidesBottomBarWhenPushed = NO;
    });
}


- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"XYMainTableViewCell";
    XYMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"XYMainTableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


@end
