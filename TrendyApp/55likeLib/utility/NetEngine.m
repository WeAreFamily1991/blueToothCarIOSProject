
//

#import "AFHTTPSessionManager.h"
#import "NetEngine.h"
#import "Foundation.h"
#import "Utility.h"
#import "SDDataCache.h"
#import "NSString+JSONCategories.h"
#import <SVProgressHUD.h>
//#import <DDXML.h>

@implementation NetEngine

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
+(id)Share
{
    static NetEngine *_NetEngineinstance=nil;
    static dispatch_once_t netEngine;
    dispatch_once(&netEngine, ^ {
        _NetEngineinstance = [[NetEngine alloc] init];
        //        _NetEngineinstance = [[NetEngine alloc] initWithHostName:baseDomain apiPath:basePath customHeaderFields:nil];
        //        _NetEngineinstance.portNumber=[basePort intValue];
        //        [_NetEngineinstance useCache];
    });
    //    if (![_NetEngineinstance.readonlyHostName isEqualToString:baseDomain] || ![_NetEngineinstance.apiPath isEqualToString:basePath] ) {
    //        _NetEngineinstance = [[NetEngine alloc] initWithHostName:baseDomain apiPath:basePath customHeaderFields:nil];
    //        _NetEngineinstance.portNumber=[basePort intValue];
    //        [_NetEngineinstance useCache];
    //    }
    
    return _NetEngineinstance;
}
+(void)cancel
{
    [SVProgressHUD dismiss];
    //[[NetEngine Share] cancelAllOperations];
}

- (void)cancelAllOperations
{
    //[super performSelector:@selector(cancelAllOperations)];
}
/**
 @method
 @abstract 网络请求总方法
 @discussion 包括GET POST SOAP DownFile UploadFile
 @param netype 网络请求类型  urlInfo 链接后缀 params {key:value...} fileinfo {uploadkey:data}  usecache 缓存标示
 @result JSon
 */
-(id)createAction:(NEType)netype
          withUrl:(NSString*)url
       withParams:(NSDictionary*)parameters
         withFile:(id)filePaths
        withCache:(BOOL)usecache
         withMask:(SVProgressHUDMaskType)mask
     onCompletion:(ResponseBlock)completionBlock
          onError:(MKNKErrorBlock)errorBlock{
    
    if (parameters==nil) {
        krequestParam
        parameters=dictparam;
    }
    
    if(mask!=SVProgressHUDMaskTypeNone){
//        [SVProgressHUD showWithStatus:@"请稍候..." maskType:mask];//showWithMaskType:mask
        [SVProgressHUD showWithStatus:nil maskType:mask];//showWithMaskType:mask
    }
    if (!url) {
        DLog(@"url 为空");
        errorBlock?errorBlock(nil):nil;
    }
    NSString*apiURL=url;
    if (![url hasPrefix:@"http"]) {
        if(![baseDomain notEmptyOrNull]) {
            DLog(@"Hostname is nil, use operationWithURLString: method to create absolute URL operations");
            errorBlock?errorBlock(nil):nil;
        }
        
        NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@://%@", baseUseSSL ? @"https" : @"http", baseDomain];
        if([basePort integerValue] != 0){
            [urlString appendFormat:@":%@", basePort];
        }
        if([basePath notEmptyOrNull]){
            [urlString appendFormat:@"/%@", basePath];
        }
        [urlString appendFormat:@"/%@", url];
        url=urlString;
    }
//    DLog(@"getUrl:%@",url);
    //    void (^block)(NSMutableArray*)=^(NSMutableArray* marray){
    //
    //    };
    void (^myblock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) =^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(mask!=SVProgressHUDMaskTypeNone){
            [SVProgressHUD dismiss];
        }
        if(!responseObject){
            errorBlock?errorBlock(nil):nil;
            return;
        }
        if (!responseObject) {
            [SVProgressHUD showErrorWithStatus:@"Data Error"];
            errorBlock?errorBlock(nil):nil;
        }else{
            NSMutableDictionary *ddd=(id)responseObject;
            ddd=[ddd toBeMutableObj];
            if ([[ddd valueForJSONKey:@"status"] isEqualToString:@"-99"]) {
                [ddd setValue:@"502" forKey:@"status"];
            }else if ([[ddd ojsk:@"status"] isEqualToString:@"1"]) {
                [ddd setObject:@"200" forKey:@"status"];
            }
            if ([[ddd ojsk:@"detail"] notEmptyOrNull]) {
                [ddd setObject:[ddd ojsk:@"detail"] forKey:@"info"];
                [ddd removeObjectForKey:@"detail"];
            }
            UTILITY.strtimestamp=[[ddd ojk:@"param"] ojsk:@"timestamp"];
            
#ifdef DEBUG
            
            [ddd setApiInfoWithApiStr:apiURL withPathStr:nil];
            NSMutableString*logstr=[NSMutableString new];
            [logstr appendFormat:@"\n\n\n\n\n\n\n返回数据：\n%@",ddd.jsonStrSYS];
            [logstr appendFormat:@"\n\n请求地址：   \n\%@%@",url,[parameters wgetParamStr]];
            [logstr appendFormat:@"\n\n控制器信息 %@",UTILITY.ControllerInfor];
            if ([url rangeOfString:@"common/pageDisplay"].length) {
                
            }else{
                
                NSLog(@"%@",logstr);
            }
#else
            //do sth.
#endif
            
            if ([[ddd valueForJSONKey:@"status"] isEqualToString:@"502"]) {
                [kUtility_Login clearUserInfoInDefault];
                [SVProgressHUD showImage:nil status:[ddd valueForJSONKey:@"info"] ];
                [self performSelector:@selector(backLogin) withObject:nil afterDelay:1.0];
                //                    completionBlock(nil,completedOperation.isCachedResponse);
            }else{
                completionBlock(ddd,NO);
            }
        }
    } ;
    void (^error)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)=
    ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(mask!=SVProgressHUDMaskTypeNone){
            [SVProgressHUD dismiss];
        }
#ifdef DEBUG
        NSMutableString*logstr=[NSMutableString new];
        [logstr appendFormat:@"\n\n\n\n\n\n错误信息：\n\n %@:",error];
        [logstr appendFormat:@"\n\n请求地址：   \n\%@%@",url,[parameters wgetParamStr]];
        [logstr appendFormat:@"\n\n控制器信息 %@",UTILITY.ControllerInfor];
        NSLog(@"%@",logstr);
#endif
        errorBlock?errorBlock(error):nil;
    };
    //    NETypeHttpGet = 1,//return JSON   get
    //    NETypeDownFile, //return DATA     get
    //    NETypeHttpPost,//return JSON      post
    //    NETypeUploadFile, //return JSON   post
    //    NETypeSoap // return XML            post
    NSURLSessionDataTask *dataTask ;
    if (netype==NETypeHttpGet) {
        dataTask = [[self sharedManager] GET:url parameters:parameters headers:nil progress:nil success:myblock failure:error];
    }else if(netype==NETypeHttpPost){
        dataTask = [[self sharedManager] POST:url parameters:parameters headers:nil progress:nil success:myblock failure:error];
    }else if(netype==NETypeJSONPost){
        AFHTTPSessionManager *manager=[self sharedManager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer]; //
        dataTask = [manager POST:url parameters:parameters headers:nil progress:nil success:myblock failure:error];
    }else if(netype==NETypeDownFile){
        // 设置请求的URL地址
        // 创建请求对象
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        // 下载任务
        NSURLSessionDownloadTask *task = [[self sharedManager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
            // 下载进度
            NSLog(@"当前下载进度为:%lf", 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            // 下载地址
            NSLog(@"默认下载地址%@",targetPath);
            NSString *filePath ;
            if (filePaths) {
                NSLog(@"下载存放地址%@",filePaths);
                filePath = filePaths;
            }else{
                //这里模拟一个路径 真实场景可以根据url计算出一个md5值 作为fileKey
                NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
                NSTimeInterval a=[dat timeIntervalSince1970];
                NSString* fileKey = [NSString stringWithFormat:@"/file_%0.f/%@", a,[url lastPathComponent]];//[url lastPathComponent]
                // 设置下载路径,通过沙盒获取缓存地址,最后返回NSURL对象
                NSString *strFile=[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"DownloadTask55like"];
                filePath = [strFile stringByAppendingPathComponent:fileKey];
                
                DLog(@"[ lastPathComponent]:%@\n filePath:%@",[filePath lastPathComponent],filePath)
                
            }
            ////删除最后一个路径节点元素
            NSString *strFile=[filePath stringByDeletingLastPathComponent];//[filePath stringByReplacingOccurrencesOfString:[filePath lastPathComponent] withString:@""];
            __block BOOL isDir = YES;
            if (![[NSFileManager defaultManager]fileExistsAtPath:strFile isDirectory:&isDir ]) {// isDir判断是否为文件夹
                [[NSFileManager defaultManager]createDirectoryAtPath:strFile withIntermediateDirectories:YES attributes:nil error:nil];
            }
            return [NSURL fileURLWithPath:filePath]; // 返回的是文件存放在本地沙盒的地址
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            // 下载完成调用的方法
            if(mask!=SVProgressHUDMaskTypeNone){
                [SVProgressHUD dismiss];
            }
            NSLog(@"filePath---%@", filePath);
#ifdef DEBUG
            
            NSMutableString*logstr=[NSMutableString new];
            [logstr appendFormat:@"NETypeDownFile：\n\n\n\n\n\n返回数据：\n%@",filePath];
            [logstr appendFormat:@"\n\n请求地址：   \n\%@%@",url,[parameters wgetParamStr]];
            [logstr appendFormat:@"\n\n控制器信息 %@",UTILITY.ControllerInfor];
            NSLog(@"%@",logstr);
#endif
            completionBlock(filePath,NO);
        }];
        //启动下载任务
        [task resume];
        return nil;
    }else{
    }
    return dataTask;
}



#pragma  data - DataActions
/**
 @method
 @abstract soap 下载
 @discussion soap
 @param msg xml请求串
 @result xml的json字符串
 */
+(id) createSoapAction:(NSString*) msg
          onCompletion:(ResponseBlock) completion
{
    return [[NetEngine Share] createAction:NETypeSoap withUrl:msg withParams:nil withFile:nil withCache:YES withMask:SVProgressHUDMaskTypeClear onCompletion:completion onError:nil];
}

+(id) createSoapAction:(NSString*) msg
          onCompletion:(ResponseBlock) completionBlock
               onError:(MKNKErrorBlock) errorBlock
              useCache:(BOOL)usecache
               useMask:(SVProgressHUDMaskType)mask
{
    return [[NetEngine Share] createAction:NETypeSoap withUrl:msg withParams:nil withFile:nil withCache:usecache withMask:mask onCompletion:completionBlock onError:errorBlock];
}


/**
 @method
 @abstract 下载文件和获取get返回值
 @param url 包含url?param=1&param=2
 @result json字符串
 */
+(id) createGetAction:(NSString*) url
         onCompletion:(ResponseBlock) completion
{
    return [[NetEngine Share] createAction:NETypeHttpGet withUrl:url withParams:nil withFile:nil withCache:NO withMask:SVProgressHUDMaskTypeClear onCompletion:completion onError:nil];
}

+(id) createGetAction_LJ:(NSString*) url
            onCompletion:(ResponseBlock) completion
{
    return [[NetEngine Share] createAction:NETypeHttpGet withUrl:url withParams:nil withFile:nil withCache:NO withMask:SVProgressHUDMaskTypeNone onCompletion:completion onError:nil];
}

+(id) createGetAction_LJ_two:(NSString*) url
                onCompletion:(ResponseBlock) completion
                     onError:(MKNKErrorBlock) errorBlock
{
    return [[NetEngine Share] createAction:NETypeHttpGet withUrl:url withParams:nil withFile:nil withCache:NO withMask:SVProgressHUDMaskTypeNone onCompletion:completion onError:errorBlock];
}

/**
 JSON
 
 @param url 地址
 @param params 参数
 @param completion 返回值
 @param errorBlock 错误值
 @return 任务
 */
+(id) createPostActionJSON:(NSString*) url
                withParams:(NSDictionary*)params
              onCompletion:(ResponseBlock) completion
                   onError:(MKNKErrorBlock) errorBlock{
    return [[NetEngine Share] createAction:NETypeJSONPost withUrl:url withParams:params withFile:nil withCache:NO withMask:SVProgressHUDMaskTypeClear onCompletion:completion onError:errorBlock];
}

+(id) createPostAction:(NSString*) url
            withParams:(NSDictionary*)params
          onCompletion:(ResponseBlock) completion
               onError:(MKNKErrorBlock) errorBlock{
    return [[NetEngine Share] createAction:NETypeHttpPost withUrl:url withParams:params withFile:nil withCache:NO withMask:SVProgressHUDMaskTypeClear onCompletion:completion onError:errorBlock];
}
/**
 @method
 @abstract 获取post返回值
 @param url 请求链接  params post参数
 @result json字符串
 */
+(id) createPostAction:(NSString*) url
            withParams:(NSDictionary*)params
          onCompletion:(ResponseBlock) completion{
    return [[NetEngine Share] createAction:NETypeHttpPost withUrl:url withParams:params withFile:nil withCache:NO withMask:SVProgressHUDMaskTypeClear onCompletion:completion onError:nil];
}

/**
 @method
 @abstract 带缓存、下载提示控制的 get和post请求
 @param url 包含url?param=1&param=2的get请求 或 含params的post请求
 @result json字符串
 */
+(id) createHttpAction:(NSString*) url
             withCache:(BOOL)usecache
            withParams:(NSDictionary*)params
              withMask:(SVProgressHUDMaskType)mask
          onCompletion:(ResponseBlock) completionBlock
               onError:(MKNKErrorBlock) errorBlock{
    return [[NetEngine Share] createAction:params?NETypeHttpPost:NETypeDownFile withUrl:url withParams:params withFile:nil withCache:usecache withMask:mask onCompletion:completionBlock onError:errorBlock];
}



#pragma mark - fileAction
+(id) createFileAction:(NSString*) url
              withFile:(NSString*)filePath
          onCompletion:(CurrencyResponseBlock) completionBlock
               onError:(MKNKErrorBlock) errorBlock
              withMask:(SVProgressHUDMaskType)mask
{
    return [[NetEngine Share] createAction:NETypeDownFile withUrl:url withParams:nil withFile:filePath withCache:NO withMask:mask onCompletion:completionBlock onError:errorBlock];
}


#pragma mark - uplaodFileAction
//多张图片/文件（图片、语音、视频等等）
/**
 *上传文件 多个文件
 (NSMutableArray *) fileArray
 
 (nsstirng *)fileType-----文件类型（image:图片，other:其他）必传字段
 
 //fileType==image
 
 (NSData*) fileData
 (NSString *)fileKey
 (NSString *)fileName
 
 //fileType==voice
 
 (NSData*) fileData
 (NSString *)fileKey
 (NSString *)fileName
 
 //fileType==...
 
 (NSString *)fileUrl
 (NSString *)fileKey
 
 */

+(id) uploadAllFileAction:(NSString*) url
               withParams:(NSDictionary*)params
                fileArray:(NSMutableArray *)fileArray
                 progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
             onCompletion:(CurrencyResponseBlock)completionBlock
                  onError:(MKNKErrorBlock)errorBlock
                 withMask:(SVProgressHUDMaskType)mask{
    return [[NetEngine Share]uploadAllFileAction:url withParams:params fileArray:fileArray progress:uploadProgress onCompletion:completionBlock onError:errorBlock withMask:mask];
}

-(id) uploadAllFileAction:(NSString*) url
               withParams:(NSDictionary*)params
                fileArray:(NSMutableArray *)fileArray
                 progress:(void (^)(NSProgress * _Nonnull))uploadProgress
             onCompletion:(CurrencyResponseBlock)completionBlock
                  onError:(MKNKErrorBlock)errorBlock
                 withMask:(SVProgressHUDMaskType)mask{
    
    if(mask!=SVProgressHUDMaskTypeNone){
        [SVProgressHUD showWithMaskType:mask];
    }
    if (!url) {
        DLog(@"url 为空");
        errorBlock?errorBlock(nil):nil;
    }
    NSString*apiURL=url;
    if (![url hasPrefix:@"http"]) {
        if(![baseDomain notEmptyOrNull]) {
            DLog(@"Hostname is nil, use operationWithURLString: method to create absolute URL operations");
            errorBlock?errorBlock(nil):nil;
        }
        
        NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@://%@", baseUseSSL ? @"https" : @"http", baseDomain];
        if([basePort integerValue] != 0){
            [urlString appendFormat:@":%@", basePort];
        }
        if([basePath notEmptyOrNull]){
            [urlString appendFormat:@"/%@", basePath];
        }
        [urlString appendFormat:@"/%@", url];
        url=urlString;
    }
    // 创建URL资源地址
    NSURLSessionDataTask *DataTask= [[self sharedManager] POST:url parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSDictionary *dd in fileArray) {
            if ([[dd valueForJSONStrKey:@"fileType"] isEqualToString:@"image"]) {
                [formData appendPartWithFileData:[dd objectForKey:@"fileData"] name:[dd valueForJSONStrKey:@"fileKey"] fileName:[dd valueForJSONStrKey:@"fileName"] mimeType:@"image/jpeg" ];
            }else if ([[dd valueForJSONStrKey:@"fileType"] isEqualToString:@"voice"]) {
                [formData appendPartWithFileData:[dd objectForKey:@"fileData"] name:[dd valueForJSONStrKey:@"fileKey"] fileName:[dd valueForJSONStrKey:@"fileName"] mimeType:@"audio/AMR" ];
            }else{
                [formData appendPartWithFileURL:[dd objectForKey:@"fileUrl"] name:[dd valueForJSONStrKey:@"fileKey"] error:nil];
            }
        }
    } progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *ddd=(id)responseObject;
        
        ddd=[ddd toBeMutableObj];
        if ([[ddd valueForJSONKey:@"status"] isEqualToString:@"-99"]) {
            [ddd setValue:@"502" forKey:@"status"];
        }else if ([[ddd ojsk:@"status"] isEqualToString:@"1"]) {
            [ddd setObject:@"200" forKey:@"status"];
        }
        if ([[ddd ojsk:@"detail"] notEmptyOrNull]) {
            [ddd setObject:[ddd ojsk:@"detail"] forKey:@"info"];
            [ddd removeObjectForKey:@"detail"];
        }
        if(mask!=SVProgressHUDMaskTypeNone)
            [SVProgressHUD dismiss];
        
        
#ifdef DEBUG
        [ddd setApiInfoWithApiStr:apiURL withPathStr:nil];
        NSMutableString*logstr=[NSMutableString new];
        [logstr appendFormat:@"\n\n\n\n\n\n\n返回数据：\n%@",ddd.jsonStrSYS];
        [logstr appendFormat:@"\n\n请求地址：   \n\%@%@",url,[params wgetParamStr]];
        [logstr appendFormat:@"\n\n控制器信息 %@",UTILITY.ControllerInfor];
        NSLog(@"%@",logstr);
#else
        //do sth.
#endif
        
        if ([[ddd valueForJSONKey:@"status"] isEqualToString:@"502"]) {
            [kUtility_Login clearUserInfoInDefault];
            [SVProgressHUD showImage:nil status:[ddd valueForJSONKey:@"info"] ];
            [self performSelector:@selector(backLogin) withObject:nil afterDelay:1.0];
            //                    completionBlock(nil,completedOperation.isCachedResponse);
        }else{
            completionBlock(ddd,NO);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"网络超时"];
        DLog(@"errorHandler网络超时:%@",error);
        errorBlock?errorBlock(error):nil;
    }];
    
    return DataTask;
}



#pragma mark zkSeletor

-(void)backLogin{
    [kUtility_Login clearUserInfoInDefault];
    [kUtility_Login showLoginAlert];
    
}


//-(NSString*) cacheDirectoryName {
//
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = paths[0];
//    NSString *cacheDirectoryName = [documentsDirectory stringByAppendingPathComponent:@"cscImages"];
//    return cacheDirectoryName;
//}
@end
