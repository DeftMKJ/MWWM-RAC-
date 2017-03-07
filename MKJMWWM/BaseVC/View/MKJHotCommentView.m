//
//  MKJHotCommentView.m
//  MKJMWWM
//
//  Created by mintou on 2017/3/1.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJHotCommentView.h"
#import <Masonry.h>

@interface MKJHotCommentView ()

@property (nonatomic,strong) UILabel *hotLabel;

@end

@implementation MKJHotCommentView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLayout];
        [self setupData];
    }
    return self;
}


- (void)setupLayout
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:12];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    [self addSubview:label];
    self.hotLabel = label;
    [self.hotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.equalTo(self);
        make.right.mas_equalTo(self).with.offset(0);
    }];
}

- (void)setViewModel:(MKJDemoTableViewCellViewModel *)viewModel
{
    _viewModel = viewModel;
    [self setupData];
}

- (void)setupData
{
    if (self.viewModel.entity.top_cmt.count == 0) {
        return;
    }
    MKJHotCommnetModel *model = self.viewModel.entity.top_cmt.firstObject;
    NSMutableAttributedString *mutableAtt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@:",model.username]
                                                                                   attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13],
                                                                                                NSForegroundColorAttributeName : [UIColor blueColor]}];
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:model.content
                                                                 attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13],
                                                                              NSForegroundColorAttributeName : [UIColor blackColor]}];
    [mutableAtt appendAttributedString:string];
    self.hotLabel.attributedText = mutableAtt;
}







@end
