//
//  NetEngine.h
//  55likeLibDemo
//
//  Created by 55like on 2018/9/30.
//  Copyright © 2018年 55like lj. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "NSString+JSONCategories.h"
#import "SVProgressHUD.h"
#import "Foundation.h"
#import "NSString+expanded.h"
#import "UIView+expanded.h"
#import "NSDictionary+expanded.h"

@interface NetEngineAF : NSObject

typedef void (^CurrencyResponseBlock)(id resData,BOOL isCache);

typedef void (^ResponseBlock)(id resData,BOOL isCache);

typedef void (^NEErrorBlock)(NSError* error);

+(id)Share;


/**
 get请求

 @param url 地址（全地址）
 @param completion 返回值
 @param errorBlock 失败
 @return 任务对象
 */
+(id) createGetActionAllURL:(NSString*) url
                 parameters:(id)parameters
               onCompletion:(ResponseBlock) completion
                    onError:(NEErrorBlock) errorBlock;
+(id) createGetActionAllURL_nilActivity:(NSString*) url
                             parameters:(id)parameters
                           onCompletion:(ResponseBlock) completion
                                onError:(NEErrorBlock) errorBlock;
+(id) createGetAction:(NSString*) url
           parameters:(id)parameters
         onCompletion:(ResponseBlock) completion;
+(id) createGetAction:(NSString*) url
           parameters:(id)parameters
         onCompletion:(ResponseBlock) completion
              onError:(NEErrorBlock) errorBlock;
+(id) createGetAction_nilActivity:(NSString*) url
                       parameters:(id)parameters
                     onCompletion:(ResponseBlock) completion;
+(id) createGetAction_nilActivity:(NSString*) url
                       parameters:(id)parameters
                     onCompletion:(ResponseBlock) completion
                          onError:(NEErrorBlock) errorBlock;

@end
