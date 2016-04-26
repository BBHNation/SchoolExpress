//
//  XYMainViewController.m
//  校园快递_Online
//
//  Created by 白彬涵 on 16/4/25.
//  Copyright © 2016年 Philips. All rights reserved.
//

#import "XYMainViewController.h"
#import "XYMainTableViewCell.h"
#import "XYMainTableViewModel.h"


@interface XYMainViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *mainTableView;
@property (nonatomic, strong) XYMainTableViewModel *tableViewModel;
@property (nonatomic, strong) NSMutableArray *tableViewDataArray;

@end

@implementation XYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"HOME"];
    _mainTableView.backgroundColor = [UIColor colorWithRed:28.0/255.0 green:51.0/255.0 blue:84.0/255.0 alpha:0.3];
    _tableViewModel = [XYMainTableViewModel new];
    _tableViewDataArray = [NSMutableArray new];
    
    _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_tableViewModel getLatestExpressInfoFromServer];
    }];
    __weak typeof(self) weakSelf = self;
    [self.KVOController observe:_tableViewModel keyPath:@"isRefreshed" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        [weakSelf.mainTableView.mj_header endRefreshing];
        weakSelf.tableViewDataArray = [NSMutableArray arrayWithArray:weakSelf.tableViewModel.tableViewDataArray];
        [weakSelf.mainTableView reloadData];
    }];
    
    [_tableViewModel getLatestExpressInfoFromServer];
}



- (IBAction)SendMyEcpressAction:(id)sender {
    if (![AVUser currentUser]) {
        
        [self presentViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginAndRegister"] animated:YES completion:nil];
    }
    else{
        NSLog(@"已经登陆");
        self.hidesBottomBarWhenPushed = YES;
        [self performSegueWithIdentifier:@"SendExpress" sender:self];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
            self.hidesBottomBarWhenPushed = NO;
        });
    }
}


- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableViewDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"XYMainTableViewCell";
    XYMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell&&_tableViewDataArray.count!=0) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"XYMainTableViewCell" owner:nil options:nil] firstObject];
        AVObject *item = _tableViewDataArray[indexPath.row];
        [cell setCellItem:item];
    }
    return cell;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.hidesBottomBarWhenPushed = YES;
    [self performSegueWithIdentifier:@"AcceptExpressBefor" sender:_tableViewDataArray[indexPath.row]];
    self.hidesBottomBarWhenPushed = NO;
}

@end
