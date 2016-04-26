//
//  XYMainTableViewModel.h
//  校园快递_Online
//
//  Created by 白彬涵 on 16/4/26.
//  Copyright © 2016年 Philips. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYMainTableViewModel : NSObject

@property (nonatomic, strong, readonly) NSMutableArray *tableViewDataArray;

- (void)getLatestExpressInfoFromServer;
    
- (void)getMyAcountExpressInfoFromServer;

@end
