//
//  MKJDemoEntity.h
//  MKJMWWM
//
//  Created by mintou on 2017/3/1.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJBaseEntity.h"

@class MKJTopicInfo;
@interface MKJTopicRoot : MKJBaseEntity

@property (nonatomic,strong) MKJTopicInfo *info;
@property (nonatomic,strong) NSArray *list;

@end

@interface MKJTopicInfo : MKJBaseEntity

@property (nonatomic,assign) NSInteger count;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,copy) NSString *maxid;
@property (nonatomic,copy) NSString *maxtime; // 分页传的数据

@end

@interface MKJTopicModel : MKJBaseEntity
// 	头像的图片url地址
@property (nonatomic,copy) NSString *profile_image;

// 是否新浪大V
@property (nonatomic,assign) BOOL sina_v;

// 发帖人的昵称
@property (nonatomic,copy) NSString *name;

// 帖子的内容
@property (nonatomic,copy) NSString *text;

// 系统审核通过后创建帖子的时间
@property (nonatomic,copy) NSString *created_at;


// 收藏量
@property (nonatomic,assign) NSInteger love;

// 踩的人数
@property (nonatomic,assign) NSInteger cai;

// 转发的数量
@property (nonatomic,assign) NSInteger repost;

// 帖子的被评论数量
@property (nonatomic,assign) NSInteger comment;

// 热门评论数组
@property (nonatomic,strong) NSArray *top_cmt;

@end


@interface MKJHotCommnetModel : MKJBaseEntity

@property (nonatomic,copy) NSString *content; // 热门评论内容
@property (nonatomic,copy) NSString *username; // 热门评论的人名字

@end















