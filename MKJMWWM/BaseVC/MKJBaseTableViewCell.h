//
//  MKJBaseTableViewCell.h
//  MKJMWWM
//
//  Created by mintou on 2017/2/28.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKJTableViewCellViewModel.h"
@interface MKJBaseTableViewCell : UITableViewCell

@property (nonatomic,strong,readonly) MKJTableViewCellViewModel *viewModel;



/**
 cell的初始化方法
 通过cellViewModel来创建一个cell 调用setupdata来绑定数据
 @param tableView tableView
 @param viewModel cellViewModel
 @return cell
 */
+ (instancetype)cellForTableView:(UITableView *)tableView viewModel:(MKJTableViewCellViewModel *)viewModel;

- (void)setupLayout;
- (void)setupBinding;
- (void)setupData;

// 用来计算高度
+(NSNumber *)calculateRowHeightWithViewModel:(MKJTableViewCellViewModel *)viewModel;

@end
