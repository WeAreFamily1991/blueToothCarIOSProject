//
//  Utility_Share.m
//  DianChengDemo
//
//  Created by 55like on 2018/5/15.
//  Copyright © 2018年 55like. All rights reserved.
//

#import "Utility_Share.h"
///分享
//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKUI/ShareSDKUI.h>

@implementation Utility_Share

static Utility_Share *_utilityinstance=nil;
static dispatch_once_t utility_Share;

+(id)shareInstence
{
    dispatch_once(&utility_Share, ^ {
        _utilityinstance = [[Utility_Share alloc] init];
    });
    return _utilityinstance;
}

#pragma mark Share
////分享
- (void)showShareData:(NSDictionary *)dic suc:(ShareActionSuc)shareS
{
    self.shareSuc = shareS;
    NSString *strTitle=[dic valueForJSONStrKey:@"title"];
    if (strTitle.length>25) {
        strTitle=[NSString stringWithFormat:@"%@...",[strTitle substringToIndex:25]];
    }
    NSString *strContent=[dic valueForJSONStrKey:@"descr"];
    if (strContent.length>50) {
        strContent=[NSString stringWithFormat:@"%@...",[strContent substringToIndex:50]];
    }
    
//    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//    
//    NSArray* imageArray ;
//    if ([[dic valueForJSONStrKey:@"src"] notEmptyOrNull]) {
//        NSString *src=[dic valueForJSONStrKey:@"src"];
//        src=[src hasPrefix:@"http"]?src:[NSString stringWithFormat:@"http://%@%@",basePicPath,src];
//        imageArray= @[[NSURL URLWithString:src]];
//    }
//    [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"%@ %@",strContent,[dic valueForJSONStrKey:@"url"]]
//                                     images:imageArray
//                                        url:[NSURL URLWithString:[dic valueForJSONStrKey:@"url"]]
//                                      title:strTitle
//                                       type:SSDKContentTypeAuto];
//    
//    SSUIShareSheetConfiguration *config = [[SSUIShareSheetConfiguration alloc] init];
//    //设置分享菜单为简洁样式
//    config.style = SSUIActionSheetStyleSimple;
//    //设置竖屏有多少个item平台图标显示
//    config.columnPortraitCount = 2;
//    //设置横屏有多少个item平台图标显示
//    config.columnLandscapeCount = 3;
//    //设置取消按钮标签文本颜色
//    config.cancelButtonTitleColor = [UIColor redColor];
//    //设置对齐方式（简约版菜单无居中对齐）
//    config.itemAlignment = SSUIItemAlignmentCenter;
//    //设置标题文本颜色
//    config.itemTitleColor = [UIColor greenColor];
//    //设置分享菜单栏状态栏风格
//    config.statusBarStyle = UIStatusBarStyleLightContent;
//    //设置支持的页面方向（单独控制分享菜单栏）
//    config.interfaceOrientationMask = UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskLandscape;
//    //设置分享菜单栏的背景颜色
//    config.menuBackgroundColor = [UIColor redColor];
//    //取消按钮是否隐藏，默认不隐藏
//    config.cancelButtonHidden = YES;
//    //设置直接分享的平台（不弹编辑界面）
//    config.directSharePlatforms = @[@(SSDKPlatformTypeSinaWeibo),@(SSDKPlatformTypeTwitter)];
//    
//    [ShareSDK showShareActionSheet:nil
//                       customItems:nil
//                       shareParams:shareParams
//                sheetConfiguration:nil
//                    onStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
//        if (state==SSDKResponseStateSuccess) {
//            DLog(@"____成功");
//            NSString *strTemp=@"未知";
//            if (platformType==SSDKPlatformTypeQQ ) {
//                strTemp=@"QQ";
//            }else if (platformType==SSDKPlatformSubTypeQZone) {
//                strTemp=@"QQ空间";
//            }else if (platformType==SSDKPlatformSubTypeQQFriend) {
//                strTemp=@"QQ好友";
//            }else if (platformType==SSDKPlatformSubTypeWechatSession) {
//                strTemp=@"微信好友";
//            }else if (platformType==SSDKPlatformSubTypeWechatTimeline) {
//                strTemp=@"微信朋友圈";
//            }else if (platformType==SSDKPlatformTypeWechat||
//                      platformType==SSDKPlatformSubTypeWechatFav) {
//                strTemp=@"微信";
//            }
//            self.shareSuc?self.shareSuc(1,strTemp):nil;
//            self.shareSuc = nil;
//        }else if (state==SSDKResponseStateFail){
//            DLog(@"\n\nerror:%@\n\n",error);
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
//                                                            message:[NSString stringWithFormat:@"%@",error]
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:nil, nil];
//            [alert show];
//            self.shareSuc?self.shareSuc(0,@""):nil;
//            self.shareSuc = nil;
//        }else if (state==SSDKResponseStateCancel){
//            DLog(@"取消分享")
//            self.shareSuc?self.shareSuc(-1,@""):nil;
//            self.shareSuc = nil;
//        }
//    }];
    
}

@end
