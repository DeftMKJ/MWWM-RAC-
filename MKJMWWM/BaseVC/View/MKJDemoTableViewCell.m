//
//  MKJDemoTableViewCell.m
//  MKJMWWM
//
//  Created by mintou on 2017/3/1.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJDemoTableViewCell.h"
#import <Masonry.h>
#import "MKJBottomView.h"
#import "MKJHotCommentView.h"
#import <UIImageView+WebCache.h>

@interface MKJDemoTableViewCell ()
@property (nonatomic,strong) UIView *headerInfoView;
@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *creatTimeLabel;
@property (nonatomic,strong) UILabel *ctxLabel;
@property (nonatomic,strong) MKJBottomView *bottomView;
@property (nonatomic,strong) MKJHotCommentView *hotCommentView;
@property (nonatomic,strong) UIView *line;




@end

@implementation MKJDemoTableViewCell
@dynamic viewModel;

- (void)setupLayout
{
    [super setupLayout];
    // 头部
    UIView *headerInfoView = [[UIView alloc] init];
//    headerInfoView.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:headerInfoView];
    self.headerInfoView = headerInfoView;
    
    // 头像
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.headerInfoView addSubview:imageView];
    imageView.layer.cornerRadius = 20;
    imageView.layer.masksToBounds = YES;
    self.headImageView = imageView;
    
    // 名字
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:11];
    label.textColor = [UIColor blueColor];
    [self.headerInfoView addSubview:label];
    self.nameLabel = label;
    
    // 时间Label
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = [UIColor lightGrayColor];
    timeLabel.font = [UIFont systemFontOfSize:9];
    [self.headerInfoView addSubview:timeLabel];
    self.creatTimeLabel = timeLabel;
    
    
    
    // 发表文本
    UILabel *label1 = [[UILabel alloc] init];
    label1.numberOfLines = 0;
    label1.font = [UIFont systemFontOfSize:15];
    label1.textColor = [UIColor redColor];
    [self.contentView addSubview:label1];
    self.ctxLabel = label1;
    
    
    // 底部四格标签
    self.bottomView = [[MKJBottomView alloc] initWithFrame:CGRectZero];
//    self.bottomView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:self.bottomView];
    
    
    // 人们评论的View
    self.hotCommentView = [[MKJHotCommentView alloc] initWithFrame:CGRectZero];
    self.hotCommentView.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
    [self.contentView addSubview:self.hotCommentView];
    
    UIView *underLine = [[UIView alloc] init];
    underLine.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.contentView addSubview:underLine];
    self.line = underLine;
}

- (void)setupBinding
{
    [super setupBinding];
    
    [self.headerInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.equalTo(self.contentView);
        make.height.equalTo(@(50));
        
    }];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.headerInfoView);
        make.left.equalTo(@(20));
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.headImageView.mas_top);
        make.left.equalTo(self.headImageView.mas_right).with.offset(10);
        make.right.equalTo(self.headerInfoView);
        
    }];
    
    [self.creatTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.nameLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.headImageView.mas_right).with.offset(10);
        make.right.equalTo(self.headerInfoView);
        
    }];
    
    
    
    // 做约束的更新替换操作
    [self.ctxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.headerInfoView.mas_bottom).with.offset(20);
        make.left.equalTo(self.contentView).with.offset(20);
        make.right.equalTo(self.contentView).with.offset(-20);
        
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.ctxLabel.mas_bottom).with.offset(20);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(@50);
        
    }];
    
    [self.hotCommentView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.bottomView.mas_bottom).with.offset(20);
        make.left.equalTo(self.contentView).with.offset(20);
        make.right.equalTo(self.contentView).with.offset(-20);
        make.height.equalTo(@50);
    }];
    
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(@1);
    }];
}

- (void)setupData
{
    [super setupData];
    // 根据cell里面的ViewModel去获取数据
    self.bottomView.viewModel = self.viewModel;
    self.ctxLabel.text = [self.viewModel publishTopicContent];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[self.viewModel headerImageURL]] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    self.nameLabel.text = self.viewModel.name;
    self.creatTimeLabel.text = self.viewModel.createTime;
    self.hotCommentView.viewModel = self.viewModel;
    [self.hotCommentView mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.height.equalTo(self.viewModel.hotCommnetHeight);
    }];
    self.hotCommentView.hidden = (self.viewModel.entity.top_cmt.count == 0);
}

+ (NSNumber *)calculateRowHeightWithViewModel:(MKJDemoTableViewCellViewModel *)viewModel
{
    return [viewModel cacheCellHeightWithCalculateBlock:^NSNumber * _Nonnull{
        return viewModel.totalHeight;
    }];
}

@end
