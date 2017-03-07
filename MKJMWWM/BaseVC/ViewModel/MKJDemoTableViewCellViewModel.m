//
//  MKJDemoTableViewCellViewModel.m
//  MKJMWWM
//
//  Created by mintou on 2017/3/1.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJDemoTableViewCellViewModel.h"
#import <UIKit/UIKit.h>


@interface MKJDemoTableViewCellViewModel ()

@property (nonatomic,strong) MKJTopicModel *entity;

@end

@implementation MKJDemoTableViewCellViewModel
@dynamic entity;

- (NSString *)publishTopicContent
{
    return self.entity.text;
}


- (NSString *)headerImageURL
{
    return self.entity.profile_image;
}

- (NSString *)name
{
    return self.entity.name;
}

- (NSString *)createTime
{
    return self.entity.created_at;
}

- (NSNumber *)hotCommnetHeight
{
    if (self.entity.top_cmt.count == 0) {
        return @0;
    }
    MKJHotCommnetModel *model = self.entity.top_cmt.firstObject;
    NSMutableAttributedString *mutableAtt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@:",model.username]
                                                                                   attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13],
                                                                                                NSForegroundColorAttributeName : [UIColor blueColor]}];
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:model.content
                                                                 attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13],
                                                                              NSForegroundColorAttributeName : [UIColor blackColor]}];
    [mutableAtt appendAttributedString:string];
    return @([mutableAtt boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height);
}


- (NSNumber *)totalHeight
{
    CGFloat contentHeight = [[self publishTopicContent] boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + 40;
    CGFloat hotCommentHeight = [[self hotCommnetHeight] floatValue];
    
    if (self.entity.top_cmt.count != 0) {
        return @(50 + contentHeight + 50 + 20 + hotCommentHeight + 20);
    }
    return @(50 + contentHeight + 50 + 20);
}

@end
