//
//  XYMainTableViewModel.m
//  校园快递_Online
//
//  Created by 白彬涵 on 16/4/26.
//  Copyright © 2016年 Philips. All rights reserved.
//

#import "XYMainTableViewModel.h"

@interface XYMainTableViewModel ()
@property (nonatomic, assign) BOOL isRefreshed;
@property (nonatomic, strong, readwrite) NSMutableArray *tableViewDataArray;

@end


@implementation XYMainTableViewModel

- (void)getLatestExpressInfoFromServer{
    AVQuery *query = [AVQuery queryWithClassName:@"LatestExpressList"];
    BOOL boolNum = NO;
    [query whereKey:@"isAccepted" equalTo:[NSNumber numberWithBool:boolNum]];
    [query whereKey:@"completed" equalTo:[NSNumber numberWithBool:boolNum]];
    __weak typeof(self) weakSelf = self;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            weakSelf.tableViewDataArray = [NSMutableArray arrayWithArray:objects];
            [weakSelf willChangeValueForKey:@"isRefreshed"];
            [weakSelf didChangeValueForKey:@"isRefreshed"];
        }
        else{
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
        }
    }];
}

- (void)getMyAcountExpressInfoFromServer{
    AVQuery *query = [AVQuery queryWithClassName:@"LatestExpressList"];
    BOOL boolNum = NO;
    [query whereKey:@"isAccepted" equalTo:[NSNumber numberWithBool:boolNum]];
    [query whereKey:@"hicompleted" equalTo:[NSNumber numberWithBool:boolNum]];
    __weak typeof(self) weakSelf = self;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            weakSelf.tableViewDataArray = [NSMutableArray arrayWithArray:objects];
            [weakSelf willChangeValueForKey:@"isRefreshed"];
            [weakSelf didChangeValueForKey:@"isRefreshed"];
        }
        else{
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
        }
    }];
}


@end
