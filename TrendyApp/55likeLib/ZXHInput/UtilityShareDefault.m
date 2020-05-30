//
//  UtilityShareDefault.m
//  zhuiKeMarketing
//
//  Created by 55like on 2018/11/2.
//  Copyright © 2018年 55like lj. All rights reserved.
//

#import "UtilityShareDefault.h"
#import "SDWebImageManager.h"
#import "SDWebImageCompat.h"
//#import "SharedItem.h"

@interface UtilityShareDefault (){
}
@property(nonatomic,strong)id shareData;
@property(nonatomic,strong)UIImage * shareTempImage;
@end
@implementation UtilityShareDefault

static UtilityShareDefault *_utilityinstance=nil;
static dispatch_once_t utility_Share;

+(id)shareInstence
{
    dispatch_once(&utility_Share, ^ {
        _utilityinstance = [[UtilityShareDefault alloc] init];
    });
    return _utilityinstance;
}

#pragma mark Share
/**
 系统分享(链接方式)
 
 @param data 分享数据 @{@"imageUrl":@"",@"title":@"",@"url":@""}
 @param shareS 分享结果
 */
- (void)showShareUrlData:(id)data suc:(AllcallBlock)shareS
{
    _xxallBlock=shareS;
    _shareData=data;
    _shareTempImage=nil;
    if (![[_shareData ojsk:@"url"] notEmptyOrNull]) {
        [SVProgressHUD showImage:nil status:@"分享必须有URL地址"];
        return;
    }
    [self VerifyWhetherTherePicture];
}

//验证图片是否存在
-(void)VerifyWhetherTherePicture{
    BOOL boolDown=YES;
    if ([[_shareData ojsk:@"imageUrl"] notEmptyOrNull]) {
        NSString *url=[_shareData ojsk:@"imageUrl"];
        NSString *urlImage =[url hasPrefix:@"http"]?url:[NSString stringWithFormat:@"http://%@%@",basePicPath,url];
        
        NSString *cacheImageKey = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:urlImage]];
        if (cacheImageKey.length) {
            NSString *cacheImagePath = [[SDImageCache sharedImageCache] defaultCachePathForKey:cacheImageKey];
            if (cacheImagePath.length && [[NSFileManager defaultManager] fileExistsAtPath:cacheImagePath]) {
                //有图片
                _shareTempImage=[[UIImage alloc]initWithContentsOfFile:cacheImagePath];
            }else{
                DLog(@"cacheImagePath:%@",cacheImagePath);
                //不存在
                boolDown=NO;
                //下载
                [SDWebImageManager.sharedManager loadImageWithURL:[NSURL URLWithString:urlImage] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                    float currentProgress = (float)receivedSize/(float)expectedSize;
                    if (currentProgress>=1) {
                        
                    }
                }completed:^(UIImage *image, NSData *data, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    if (image) {
                        self.shareTempImage=image;
                        [SDWebImageManager.sharedManager.imageCache storeImage:image forKey:urlImage completion:^{
                            DLog(@"fenxiang_ok:%@",imageURL);
                            [self VerifyWhetherTherePicture];
                        }];
                    }else{
                        DLog(@"图片下载失败 error :%@",error);
                        [self.shareData setValue:@"" forKey:@"imageUrl"];
                        [self VerifyWhetherTherePicture];
                    }
                    
                    
                } ];
            }
        }
        
    }
    if (boolDown) {
        [self shareImagesActivity];
    }
    
}

//分享
-(void)shareImagesActivity{
   
    __weak typeof(self) weakSelf=self;
   
    NSMutableArray *items = [[NSMutableArray alloc] init];
    if([[_shareData ojsk:@"title"] notEmptyOrNull]){
        [items addObject:[_shareData ojsk:@"title"]];
    }
    //这里是一张本地的图片
    if (_shareTempImage) {
        [items addObject:_shareTempImage];
    }
    //URL
    [items addObject:[NSURL URLWithString:[_shareData ojsk:@"url"]]];
    
   
    //---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    //多图分享
    UIActivityViewController *activityViewController =[[UIActivityViewController alloc] initWithActivityItems:items
                                                                                        applicationActivities:nil];
    
    //尽量不显示其他分享的选项内容
    
//    activityViewController.excludedActivityTypes =  @[UIActivityTypePrint,UIActivityTypeMail, UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];//
    // 分享完成
    activityViewController.completionWithItemsHandler = ^(NSString *activityType, BOOL completed,
                                                          NSArray *returnedItems, NSError *activityError) {
        
        // 分享完成或退出分享时调用该方法
        if (completed) {
            DLog(@"完成分享:%@",activityType);
            NSString *strConten=@"分享到其他平台";//com.tencent.xin.sharetimeline,好友；
            if ([activityType isEqualToString:@"com.tencent.xin.sharetimeline"]) {
                strConten=[NSString stringWithFormat:@"分享到微信"];
            }else if ([activityType isEqualToString:@"com.tencent.mqq.ShareExtension"]){
                strConten=[NSString stringWithFormat:@"分享到QQ"];
            }else if ([activityType isEqualToString:@"com.sina.weibo.ShareExtension"]){
                strConten=[NSString stringWithFormat:@"分享到微博"];
            }else if ([activityType isEqualToString:UIActivityTypeCopyToPasteboard]){
                strConten=[NSString stringWithFormat:@"拷贝了一份"];
            }else if ([activityType isEqualToString:@"com.apple.mobilenotes.SharingExtension"]){
                strConten=[NSString stringWithFormat:@"添加到‘备忘录’"];
            }else if ([activityType isEqualToString:@"com.apple.mobileslideshow.StreamShareService"]){
                strConten=[NSString stringWithFormat:@"iCloud照片共享"];
            }else if ([activityType isEqualToString:UIActivityTypeAirDrop]){
                strConten=[NSString stringWithFormat:@"AirDrop共享"];
            }
            weakSelf.allBlock?weakSelf.xxallBlock(@{@"type":strConten}, 200, nil):nil;
//                [self shareView:nil successData:@{@"type":strConten}];
        }else{
            weakSelf.allBlock?weakSelf.xxallBlock(activityError, 0, nil):nil;
            DLog(@"分享失败:%@",activityError);
            //                [SVProgressHUD showErrorWithStatus:@"您已取消分享！"];
        }
    };
    _boolShowSVProgress=NO;
    SendNotify(ZKHiddenAudioPlayBtton, nil)
    [UTILITY.currentViewController presentViewController:activityViewController animated:TRUE completion:^{
        [SVProgressHUD dismiss];
    }];
    
}
-(void)saveImages:(NSMutableArray *)images{
    _boolShowSVProgress=NO;
    __weak typeof(self) weakSelf=self;
    [UTILITY saveImagesLocalAlbum:images withBlock:^(id data, int status, NSString *msg) {
        [SVProgressHUD dismiss];
        weakSelf.allBlock?weakSelf.xxallBlock(images, status, msg):nil;
    }];
}

@end
