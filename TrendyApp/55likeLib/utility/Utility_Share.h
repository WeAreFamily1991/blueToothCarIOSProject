//
//  Utility_Share.h
//  DianChengDemo
//
//  Created by 55like on 2018/5/15.
//  Copyright © 2018年 55like. All rights reserved.
//

#import <Foundation/Foundation.h>

//-1取消 0失败 1成功 2未知错误
typedef void (^ShareActionSuc)(NSInteger NoSuc,NSString *descr);

@interface Utility_Share : MYBaseService
+(id)shareInstence;


@property (nonatomic, strong) ShareActionSuc shareSuc;
/*
 {
 "src": "/upload/tumour/1/1478856592.jpg",
 "title": "出现肿瘤别慌",
 "descr": "出现肿瘤别慌",
 "url": "http://www.jiusheng.com/wappage/news_detail?id=1"
 }
 */
- (void)showShareData:(NSDictionary *)dic suc:(ShareActionSuc)shareS;

@end
