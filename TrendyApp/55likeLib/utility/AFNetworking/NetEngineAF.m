//
//  NetEngine.m
//  55likeLibDemo
//
//  Created by 55like on 2018/9/30.
//  Copyright © 2018年 55like lj. All rights reserved.
//

#import "NetEngineAF.h"
#import "Utility.h"

@implementation NetEngineAF

+(id)Share
{
    static NetEngineAF *_NetEngineinstance=nil;
    static dispatch_once_t netEngine;
    dispatch_once(&netEngine, ^ {
        _NetEngineinstance = [[NetEngineAF alloc] init];
//        _NetEngineinstance = [[NetEngine alloc] initWithHostName:baseDomain apiPath:basePath customHeaderFields:nil];
//        _NetEngineinstance.portNumber=[basePort intValue];
//        [_NetEngineinstance useCache];
    });
//    if (![_NetEngineinstance.readonlyHostName isEqualToString:baseDomain] || ![_NetEngineinstance.apiPath isEqualToString:basePath] ) {
//        _NetEngineinstance = [[NetEngine alloc] initWithHostName:baseDomain apiPath:basePath customHeaderFields:nil];
//        _NetEngineinstance.portNumber=[basePort intValue];
//        [_NetEngineinstance useCache];
//    }
//    
    return _NetEngineinstance;
}
-(AFHTTPSessionManager *)sharedManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //最大请求并发任务数
    manager.operationQueue.maxConcurrentOperationCount = 50;
    
    // 请求格式
    // AFHTTPRequestSerializer      二进制格式
    // AFJSONRequestSerializer      JSON
    // AFPropertyListRequestSerializer  PList(是一种特殊的XML,解析起来相对容易)
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    
    // 超时时间
    manager.requestSerializer.timeoutInterval = 30.0f;
    // 设置请求头
//    [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
    // 设置接收的Content-Type
    manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];
    
    // 返回格式
    // AFHTTPResponseSerializer      二进制格式
    // AFJSONResponseSerializer      JSON
    // AFXMLParserResponseSerializer   XML,只能返回XMLParser,还需要自己通过代理方法解析
    // AFXMLDocumentResponseSerializer (Mac OS X)
    // AFPropertyListResponseSerializer  PList
    // AFImageResponseSerializer     Image
    // AFCompoundResponseSerializer    组合
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//返回格式 JSON
    //设置返回C的ontent-type
    manager.responseSerializer.acceptableContentTypes=[[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];
    
    return manager;
}

#pragma mark get
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
                    onError:(NEErrorBlock) errorBlock{
    return [[NetEngineAF Share] createGetActionURL:url parameters:parameters isFullLink:YES onCompletion:completion onError:errorBlock withMask:SVProgressHUDMaskTypeClear];
}
+ (id)createGetActionAllURL_nilActivity:(NSString *)url
                             parameters:(id)parameters
                           onCompletion:(ResponseBlock)completion
                                onError:(NEErrorBlock)errorBlock{
    return [[NetEngineAF Share] createGetActionURL:url parameters:parameters isFullLink:YES onCompletion:completion onError:errorBlock withMask:SVProgressHUDMaskTypeNone];
}
+(id) createGetAction:(NSString*) url
           parameters:(id)parameters
         onCompletion:(ResponseBlock) completion{
    return [self createGetAction:url parameters:parameters onCompletion:completion onError:nil];
}
+(id) createGetAction:(NSString*) url
           parameters:(id)parameters
         onCompletion:(ResponseBlock) completion
              onError:(NEErrorBlock) errorBlock{
    return [[NetEngineAF Share] createGetActionURL:url parameters:parameters isFullLink:NO onCompletion:completion onError:errorBlock withMask:SVProgressHUDMaskTypeClear];;
}
+(id) createGetAction_nilActivity:(NSString*) url
                       parameters:(id)parameters
                     onCompletion:(ResponseBlock) completion{
    return [self createGetAction_nilActivity:url parameters:parameters onCompletion:completion onError:nil];
}
+(id) createGetAction_nilActivity:(NSString*) url
                       parameters:(id)parameters
                     onCompletion:(ResponseBlock) completion
                          onError:(NEErrorBlock) errorBlock{
    return [[NetEngineAF Share] createGetActionURL:url parameters:parameters isFullLink:NO onCompletion:completion onError:errorBlock withMask:SVProgressHUDMaskTypeNone];
}

-(id) createGetActionURL:(NSString*) url
              parameters:(id)parameters
              isFullLink:(BOOL) isFullLink
            onCompletion:(CurrencyResponseBlock) completionBlock
                 onError:(NEErrorBlock) errorBlock
                withMask:(SVProgressHUDMaskType)mask
{
    
    if(mask!=SVProgressHUDMaskTypeNone){
//        [SVProgressHUD showWithStatus:@"请稍候..." maskType:mask];//showWithMaskType:mask
        [SVProgressHUD showWithStatus:nil maskType:mask];//showWithMaskType:mask
    }
    if (!url) {
        DLog(@"url 为空");
        errorBlock?errorBlock(nil):nil;
    }
    if (!isFullLink) {
        if(![baseDomain notEmptyOrNull]) {
            DLog(@"Hostname is nil, use operationWithURLString: method to create absolute URL operations");
            errorBlock?errorBlock(nil):nil;
        }
        
        NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@://%@", baseUseSSL ? @"https" : @"http", baseDomain];
        if([basePort integerValue] != 0){
            [urlString appendFormat:@":%@", basePort];
        }
        if(![basePath notEmptyOrNull]){
            [urlString appendFormat:@"/%@", basePath];
        }
        [urlString appendFormat:@"/%@", url];
        url=urlString;
    }
    DLog(@"getUrl:%@",url);
    NSURLSessionDataTask *dataTask = [[self sharedManager] GET:url parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(!responseObject){
            errorBlock?errorBlock(nil):nil;
            return;
        }
        [SVProgressHUD dismiss];
        NSDictionary *ddd=responseObject;
        if (!ddd) {
            [SVProgressHUD showErrorWithStatus:@"Data Error"];
            errorBlock?errorBlock(nil):nil;
        }else{
            ddd=[ddd toBeMutableObj];
            if(mask!=SVProgressHUDMaskTypeNone)
                [SVProgressHUD dismiss];
            
            
#ifdef DEBUG
            NSMutableString*logstr=[NSMutableString new];
            [logstr appendFormat:@"\n\n\n\n\n\n\n返回数据：\n%@",ddd.jsonStrSYS];
            [logstr appendFormat:@"\n\n请求地址：   \n\%@%@",url,[parameters wgetParamStr]];
            [logstr appendFormat:@"\n\n控制器信息 %@",UTILITY.ControllerInfor];
            NSLog(@"%@",logstr);
#else
            //do sth.
#endif
            
            
            if ([[ddd valueForJSONKey:@"status"] isEqualToString:@"502"]) {
                [[Utility Share] clearUserInfoInDefault];
                [SVProgressHUD showImage:nil status:[ddd valueForJSONKey:@"info"] ];
                [self performSelector:@selector(backLogin) withObject:nil afterDelay:1.0];
                //                    completionBlock(nil,completedOperation.isCachedResponse);
            }else{
                completionBlock(ddd,NO);
            }
        }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
#ifdef DEBUG
            NSMutableString*logstr=[NSMutableString new];
            [logstr appendFormat:@"\n\n\n\n\n\n错误信息：\n\n %@:",error];
            [logstr appendFormat:@"\n\n请求地址：   \n\%@%@",url,[parameters wgetParamStr]];
            [logstr appendFormat:@"\n\n控制器信息 %@",UTILITY.ControllerInfor];
            NSLog(@"%@",logstr);
#endif
            errorBlock?errorBlock(error):nil;
        }];
    
    return dataTask;
}


#pragma mark zkSeletor

-(void)backLogin{
    [kUtility_Login clearUserInfoInDefault];
    [kUtility_Login showLoginAlert];
}


@end
