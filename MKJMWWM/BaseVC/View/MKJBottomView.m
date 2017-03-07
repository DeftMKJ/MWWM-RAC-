//
//  MKJBottomView.m
//  MKJMWWM
//
//  Created by mintou on 2017/3/1.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJBottomView.h"
#import "NSObject+CustomButton.h"
#import <Masonry.h>

@interface MKJBottomView ()

@property (nonatomic,strong) UIButton *zanButton;
@property (nonatomic,strong) UIButton *caiButton;
@property (nonatomic,strong) UIButton *reposetButton;
@property (nonatomic,strong) UIButton *commentButton;

@end

@implementation MKJBottomView


- (void)reuseCellRefreshData:(MKJDemoTableViewCellViewModel *)viewModel
{
    viewModel = viewModel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLayout];
        [self setupBinding];
        [self setupData];
    }
    return self;
}

- (void)setupLayout
{
    _zanButton = [self creatButtonWithTitle:@""
                                      image:nil
                                        gap:10];
    [self addSubview:_zanButton];
    
    _caiButton = [self creatButtonWithTitle:@""
                                      image:nil
                                        gap:10];
    [self addSubview:_caiButton];
    
    _reposetButton = [self creatButtonWithTitle:@""
                                          image:nil
                                            gap:10];
    [self addSubview:_reposetButton];
    
    _commentButton = [self creatButtonWithTitle:@""
                                          image:nil
                                            gap:10];
    [self addSubview:_commentButton];
}

-(void)setupBinding{
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width / 4.0f;
    CGFloat height = 50;
    [_zanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(width, height));
    }];
    
    [_caiButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_zanButton.mas_right);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(width, height));
    }];
    
    [_reposetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_caiButton.mas_right);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(width, height));
    }];
    
    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_reposetButton.mas_right);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(width, height));
    }];
    
}

- (void)setupData
{
    [self.zanButton setTitle:[NSString stringWithFormat:@"%ld",self.viewModel.entity.love] forState:UIControlStateNormal];
    [self.zanButton setImage:[UIImage imageNamed:@"mainCellDing"] forState:UIControlStateNormal];
    
    [self.caiButton setTitle:[NSString stringWithFormat:@"%ld",self.viewModel.entity.cai] forState:UIControlStateNormal];
    [self.caiButton setImage:[UIImage imageNamed:@"mainCellCai"] forState:UIControlStateNormal];
    
    [self.reposetButton setTitle:[NSString stringWithFormat:@"%ld",self.viewModel.entity.repost] forState:UIControlStateNormal];
    [self.reposetButton setImage:[UIImage imageNamed:@"mainCellShare"] forState:UIControlStateNormal];
    
    [self.commentButton setTitle:[NSString stringWithFormat:@"%ld",self.viewModel.entity.comment] forState:UIControlStateNormal];
    [self.commentButton setImage:[UIImage imageNamed:@"mainCellComment"] forState:UIControlStateNormal];
}


- (void)setViewModel:(MKJDemoTableViewCellViewModel *)viewModel
{
    _viewModel = viewModel;
    [self setupData];
}



@end
