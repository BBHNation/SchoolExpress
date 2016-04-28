//
//  MySendedExpressViewController.m
//  校园快递_Online
//
//  Created by 白彬涵 on 16/4/27.
//  Copyright © 2016年 Philips. All rights reserved.
//

#import "XYMySendedExpressViewController.h"
#import "XYMainTableViewCell.h"
#import "XYAcceptedExpressDetailViewController.h"

@interface XYMySendedExpressViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *tableViewDataArray;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end

@implementation XYMySendedExpressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getDataFromServer];
    }];
    
    
    _mainTableView.rowHeight = 100;
    _mainTableView.tableFooterView = [UIView new];
    [_mainTableView.mj_header beginRefreshing];
}

- (void)getDataFromServer{
    AVQuery *query = [AVQuery queryWithClassName:@"LatestExpressList"];
    [query whereKey:@"sendUser" equalTo:[AVUser currentUser]];
    __weak typeof(self) weakSelf = self;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            weakSelf.tableViewDataArray = [NSMutableArray arrayWithArray:objects];
            [weakSelf.mainTableView.mj_header endRefreshing];
            [weakSelf.mainTableView reloadData];
        }
        else{
            NSLog(@"error %@",error);
        }
    }];
}


#pragma mark UITableViewDelegate & UITableViewDataSource
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableViewDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"XYSendedTableViewCell";
    XYMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell&&_tableViewDataArray.count!=0) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"XYMainTableViewCell" owner:nil options:nil] firstObject];
        AVObject *item = _tableViewDataArray[indexPath.row];
        [cell setCellItem:item];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.hidesBottomBarWhenPushed = YES;
    [self performSegueWithIdentifier:@"isAccepted" sender:_tableViewDataArray[indexPath.row]];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"isAccepted"]) {
        XYAcceptedExpressDetailViewController *destinationVC = segue.destinationViewController;
        destinationVC.cellItem = (AVObject *)sender;
    }
}



@end
