//
//  XYMainTableViewCell.m
//  校园快递_Online
//
//  Created by 白彬涵 on 16/4/26.
//  Copyright © 2016年 Philips. All rights reserved.
//

#import "XYMainTableViewCell.h"

@implementation XYMainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_userNameLabel setText:@"---"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setCellItem:(AVObject *)cellItem{
    _cellItem = cellItem;
    
    //date
    NSDate *date = _cellItem.createdAt;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateString = [dateFormatter stringFromDate:date];
    [_dateLabel setText:currentDateString];
    
    [_startPointLabel setText:_cellItem[@"startPoint"]];
    
    [_destinationLabel setText:_cellItem[@"destination"]];
    
    [_expressCompanyLabel setText:_cellItem[@"expressCompany"]];
    
    [_tipLabel setText:[NSString stringWithFormat:@"小费:%@元",_cellItem[@"tip"]]];
    
    AVQuery *query = [AVQuery queryWithClassName:@"_User"];
    AVUser *user = _cellItem[@"sendUser"];
    __weak typeof(self) weakSelf = self;
    [query getObjectInBackgroundWithId:user.objectId block:^(AVObject *object, NSError *error) {
        AVUser *user = (AVUser *)object;
        [weakSelf.userNameLabel setText:user.username];
    }];
}

@end
