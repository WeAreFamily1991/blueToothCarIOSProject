
//#import "MKNetworkEngine.h"
#import "SVProgressHUD.h"
#import "Foundation.h"
#import "NSString+expanded.h"
#import "UIView+expanded.h"
#import "NSDictionary+expanded.h"

typedef enum {
    NETypeHttpGet = 1,//return JSON   get
    NETypeDownFile, //return DATA     get
    NETypeJSONPost,//return JSON      post
    NETypeHttpPost,//return JSON      post
    NETypeUploadFile, //return JSON   post
    NETypeSoap // return XML            post
}NEType;

@interface NetEngine : NSObject
typedef void (^CurrencyResponseBlock)(id resData,BOOL isCache);

typedef void (^ResponseBlock)(id resData,BOOL isCache);
typedef void (^MKNKErrorBlock)(NSError* error);
typedef void (^MKNKImageBlock) (UIImage* fetchedImage, NSURL* url, BOOL isInCache);


+(id)Share;
+(void)cancel;

+(id) createSoapAction:(NSString*) msg
          onCompletion:(ResponseBlock) completion;

+(id) createSoapAction:(NSString*) msg
          onCompletion:(ResponseBlock) completionBlock
               onError:(MKNKErrorBlock) errorBlock
              useCache:(BOOL)usecache
               useMask:(SVProgressHUDMaskType)mask;


+(id) createGetAction:(NSString*) url
         onCompletion:(ResponseBlock) completion;
+(id) createGetAction_LJ:(NSString*) url
            onCompletion:(ResponseBlock) completion;
+(id) createGetAction_LJ_two:(NSString*) url
                onCompletion:(ResponseBlock) completion
                     onError:(MKNKErrorBlock) errorBlock;


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
                   onError:(MKNKErrorBlock) errorBlock;
+(id) createPostAction:(NSString*) url
            withParams:(NSDictionary*)params
          onCompletion:(ResponseBlock) completion
               onError:(MKNKErrorBlock) errorBlock;
+(id) createPostAction:(NSString*) url
            withParams:(NSDictionary*)params
          onCompletion:(ResponseBlock) completion;

+(id) createHttpAction:(NSString*) url
             withCache:(BOOL)usecache
            withParams:(NSDictionary*)params
              withMask:(SVProgressHUDMaskType)mask
          onCompletion:(ResponseBlock) completionBlock
               onError:(MKNKErrorBlock) errorBlock;





/**
 下载文件
 
 @param url 链接
 @param filePath 返回路径
 @param completionBlock 成功数据
 @param errorBlock 错误
 @param mask 活动指示
 @return  任务
 */
+(id) createFileAction:(NSString*) url
              withFile:(NSString*)filePath
          onCompletion:(CurrencyResponseBlock) completionBlock
               onError:(MKNKErrorBlock) errorBlock
              withMask:(SVProgressHUDMaskType)mask;



/**
 @method
 @abstract 网络请求总方法
 @discussion 包括GET POST SOAP DownFile UploadFile
 @param netype 网络请求类型  urlInfo 链接后缀 params {key:value...} fileinfo {uploadkey:data}  usecache 缓存标示
 @result JSon
 */
-(id)createAction:(NEType)netype
          withUrl:(NSString*)urlInfo
       withParams:(NSDictionary*)params
         withFile:(NSArray*)filePaths
        withCache:(BOOL)usecache
         withMask:(SVProgressHUDMaskType)mask
     onCompletion:(ResponseBlock)completionBlock
          onError:(MKNKErrorBlock)errorBlock;



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
                 withMask:(SVProgressHUDMaskType)mask;





@end
