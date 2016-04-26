//
//  XYMainTableViewCellITem.h
//  校园快递_Online
//
//  Created by 白彬涵 on 16/4/26.
//  Copyright © 2016年 Philips. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYMainTableViewCellITem : NSObject

@property (nonatomic, strong) NSString *headImageUrlString;
@property (nonatomic, strong) NSString *startPointString;
@property (nonatomic, strong) NSString *destinationString;
@property (nonatomic, strong) NSString *userNameString;
@property (nonatomic, strong) NSString *expressCompanyString;
@property (nonatomic, strong) NSString *tipString;
@property (nonatomic, assign) NSTimeInterval releaseTimeInterval;

@end

