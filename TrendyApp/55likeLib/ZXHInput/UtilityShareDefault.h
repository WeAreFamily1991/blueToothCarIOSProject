//
//  UtilityShareDefault.h
//  zhuiKeMarketing
//
//  Created by 55like on 2018/11/2.
//  Copyright © 2018年 55like lj. All rights reserved.
//

#import "MYBaseService.h"
#define kUtilityShareDefault [UtilityShareDefault shareInstence]

@interface UtilityShareDefault : MYBaseService

+(id)shareInstence;

@property (nonatomic, strong) AllcallBlock xxallBlock;
@property (nonatomic, assign) BOOL  boolShowSVProgress;

/**
 系统分享(链接方式)

 @param data 分享数据 @{@"imageUrl":@"",@"title":@"",@"url":@""}
 @param shareS 分享结果
 */
- (void)showShareUrlData:(id )data suc:(AllcallBlock)shareS;


@end
