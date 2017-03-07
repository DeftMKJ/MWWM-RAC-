//
//  MKJBaseTableViewCell.m
//  MKJMWWM
//
//  Created by mintou on 2017/2/28.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJBaseTableViewCell.h"

@interface MKJBaseTableViewCell ()
@property (nonatomic,strong) MKJTableViewCellViewModel *viewModel;

@end

@implementation MKJBaseTableViewCell

+ (instancetype)cellForTableView:(UITableView *)tableView viewModel:(MKJTableViewCellViewModel *)viewModel
{
    NSString *identify = NSStringFromClass([self class]);
    MKJBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        [cell setupLayout];
        [cell setupBinding];
    }
    cell.viewModel = viewModel;
    [cell setupData];
    return cell;
}

// cell里面实现，通过viewModel去存储数据，高度由这个Block返回给ViewModel保存起来
+ (NSNumber *)calculateRowHeightWithViewModel:(MKJTableViewCellViewModel *)viewModel
{
    return nil;
}


- (void)setupLayout
{
    
}

- (void)setupBinding{
}

- (void)setupData
{
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
