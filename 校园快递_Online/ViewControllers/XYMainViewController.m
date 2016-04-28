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
#import "XYAcceptExpressViewController.h"

@interface XYMainViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *userHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (nonatomic, weak) IBOutlet UITableView *mainTableView;
@property (nonatomic, strong) XYMainTableViewModel *tableViewModel;
@property (nonatomic, strong) NSMutableArray *tableViewDataArray;

@end

@implementation XYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"HOME"];
    _tableViewModel = [XYMainTableViewModel new];
    _tableViewDataArray = [NSMutableArray new];
    
    
    
    
    _mainTableView.rowHeight = 100;
    _mainTableView.tableFooterView = [UIView new];
    //下拉加载
    _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_tableViewModel getLatestExpressInfoFromServer];
    }];
    
    //设置监听
    __weak typeof(self) weakSelf = self;
    [self.KVOController observe:_tableViewModel keyPath:@"isRefreshed" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        [weakSelf.mainTableView.mj_header endRefreshing];
        weakSelf.tableViewDataArray = [NSMutableArray arrayWithArray:weakSelf.tableViewModel.tableViewDataArray];
        [weakSelf.mainTableView reloadData];
    }];
    //开始加载
    [_mainTableView.mj_header beginRefreshing];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [_userHeadImageView sd_setImageWithURL:[NSURL URLWithString:[AVUser currentUser][@"headImage"]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        NSLog(@"ERROR is %@",error);
    }];
    _userHeadImageView.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:1.0].CGColor;
    
    [_userNameLabel setText:[AVUser currentUser].username];
}

- (IBAction)GotoMySendedExpressAction:(id)sender {
    if (![AVUser currentUser]) {
       [self presentViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginAndRegister"] animated:YES completion:nil];
    }
    else{
        self.hidesBottomBarWhenPushed = YES;
        [self performSegueWithIdentifier:@"MySendedExpress" sender:self];
        self.hidesBottomBarWhenPushed = NO;
    }
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

#pragma mark UITableViewDelegate & UITableViewDataSource
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
        cell.selectedBackgroundView = [UIView new];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:1.0 green:88.0/255.0 blue:101.0/255.0 alpha:1.0];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];
    self.hidesBottomBarWhenPushed = YES;
    [self performSegueWithIdentifier:@"AcceptExpressBefor" sender:_tableViewDataArray[indexPath.row]];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark prepareForSegue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"AcceptExpressBefor"]) {
        XYAcceptExpressViewController *destinationVC = segue.destinationViewController;
        destinationVC.cellItem = (AVObject *)sender;
    }
}





@end
