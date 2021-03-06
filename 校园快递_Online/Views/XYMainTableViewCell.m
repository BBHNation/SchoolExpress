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
    _userHeadImageView.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:1.0].CGColor;
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
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    NSString *currentDateString = [dateFormatter stringFromDate:date];
    [_dateLabel setText:currentDateString];
    
    [_startPointLabel setText:_cellItem[@"startPoint"]];
    
    [_destinationLabel setText:_cellItem[@"destination"]];
    
    [_expressCompanyLabel setText:_cellItem[@"expressCompany"]];
    
    [_tipLabel setText:[NSString stringWithFormat:@"%@元",_cellItem[@"tip"]]];
    
    [_userNameLabel setText:_cellItem[@"sendUserName"]];
    
    [_userHeadImageView sd_setImageWithURL:[NSURL URLWithString:_cellItem[@"sendUserHeadImage"]]];
    
    
    /*
    AVQuery *query = [AVQuery queryWithClassName:@"_User"];
    AVUser *user = _cellItem[@"sendUser"];
    __weak typeof(self) weakSelf = self;
    [query getObjectInBackgroundWithId:user.objectId block:^(AVObject *object, NSError *error) {
        AVUser *user = (AVUser *)object;
        [weakSelf.userNameLabel setText:user.username];
        [weakSelf.userHeadImageView sd_setImageWithURL:[NSURL URLWithString:user[@"headImage"]] placeholderImage:nil];
    }];
     */
    
    
//    if ([_cellItem[@"completed"] boolValue]) {
//        self.contentView.backgroundColor = [UIColor lightGrayColor];
//    }
}

@end
