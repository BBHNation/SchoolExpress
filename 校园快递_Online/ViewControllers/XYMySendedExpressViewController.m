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
@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;
@property (nonatomic, assign) BOOL isAccepted;

@end

@implementation XYMySendedExpressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isAccepted = YES;
    [_noticeLabel setHidden:YES];
    _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getDataFromServer];
    }];
    
    
    _mainTableView.rowHeight = 100;
    _mainTableView.tableFooterView = [UIView new];
    [_mainTableView.mj_header beginRefreshing];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [_mainTableView.mj_header beginRefreshing];
}




- (IBAction)changeAccepted:(id)sender {
    _isAccepted = !_isAccepted;
    [_mainTableView.mj_header beginRefreshing];
}

- (void)getDataFromServer{
    AVQuery *query = [AVQuery queryWithClassName:@"LatestExpressList"];
    [query whereKey:@"sendUser" equalTo:[AVUser currentUser]];
    [query whereKey:@"isAccepted" equalTo:[NSNumber numberWithBool:_isAccepted]];
    [query whereKey:@"completed" equalTo:[NSNumber numberWithBool:NO]];
    __weak typeof(self) weakSelf = self;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            weakSelf.tableViewDataArray = [NSMutableArray arrayWithArray:objects];
            [weakSelf.mainTableView.mj_header endRefreshing];
            [weakSelf.mainTableView reloadData];
            if (weakSelf.tableViewDataArray.count==0) {
                [weakSelf.noticeLabel setHidden:NO];
            }else{
                [weakSelf.noticeLabel setHidden:YES];
            }
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
        [tableView registerNib:[UINib nibWithNibName:@"XYMainTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
    }
    AVObject *item = _tableViewDataArray[indexPath.row];
    [cell setCellItem:item];
    cell.selectedBackgroundView = [UIView new];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:1.0 green:88.0/255.0 blue:101.0/255.0 alpha:1.0];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AVObject *item = _tableViewDataArray[indexPath.row];
    if ([item[@"isAccepted"] boolValue]) {
        self.hidesBottomBarWhenPushed = YES;
        [self performSegueWithIdentifier:@"isAccepted" sender:_tableViewDataArray[indexPath.row]];
    }
    else{
        //没被接单进入订单详情
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"isAccepted"]) {
        XYAcceptedExpressDetailViewController *destinationVC = segue.destinationViewController;
        destinationVC.cellItem = (AVObject *)sender;
    }
}



@end
