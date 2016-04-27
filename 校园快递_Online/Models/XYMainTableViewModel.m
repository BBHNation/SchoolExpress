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
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSMutableArray<AVObject *> *expresses = [NSMutableArray new];
        for (int i=0; i<objects.count; i++) {
            AVObject *object = objects[i];
            if (![object[@"isAccepted"] boolValue]) {
                [expresses addObject:object];
            }
        }
        
        _tableViewDataArray = [NSMutableArray arrayWithArray:expresses];
        AVObject *object = [_tableViewDataArray lastObject];
        AVUser *user = object[@"sendUser"];
        NSLog(@"%@",user.objectId);
        
        [self willChangeValueForKey:@"isRefreshed"];
        [self didChangeValueForKey:@"isRefreshed"];
    }];
}

- (void)getMyAcountExpressInfoFromServer{
    
}


@end
