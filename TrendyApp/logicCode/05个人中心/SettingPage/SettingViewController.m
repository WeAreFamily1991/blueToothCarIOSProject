//
//  SettingViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/1.
//  Copyright © 2019 55like. All rights reserved.
//

#import "SettingViewController.h"
#import "MYRHTableView.h"
#import "SwitchLanguageViewController.h"
#import "ChangeBindingMailBoxViewController.h"
#import "ModifyPasswordViewController.h"
#import "AboutUsViewController.h"
#import "SelectWebUrlViewController.h"

#import "SDImageCache.h"
@interface SettingViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@end

@implementation  SettingViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self navbarTitle:kST(@"setUp")];
    [self addView];
}
#pragma mark -   write UI
-(void)addView{
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    
    NSArray*arrayContent=@[
                           @{
                               @"classStr":@"GSettingCellView",
                               @"name":kS(@"setUp", @"switchLanguage"),
                               @"frameY":@"10",
                               @"describe":@"",
                               @"actionType":@"switchLanguage",
                               },
                           @{
                               @"classStr":@"GSettingCellView",
                               @"name":kS(@"setUp", @"changeBindingMailbox"),
                               @"frameY":@"10",
                               @"describe":@"",
                               @"actionType":@"changeBindingMailbox",
                               },
                           @{
                               @"classStr":@"GSettingCellView",
                               @"name":kS(@"setUp", @"modifyPassword"),
                               @"frameY":@"",
                               @"describe":@"",
                               @"actionType":@"modifyPassword",
                               },
                           @{
                               @"classStr":@"GSettingCellView",
                               @"name":kS(@"setUp", @"aboutUs"),
                               @"frameY":@"10",
                               @"describe":@"",
                               @"actionType":@"aboutUs",
                               },
                           @{
                               @"classStr":@"GSettingCellView",
                               @"name":kS(@"setUp", @"clearCache"),
                               @"frameY":@"",
                               @"describe":@"",
                               @"actionType":@"clearCache",
                               },
                           @{
                               @"classStr":@"GSettingCellView",
//                               @"name":@"注册协议",
                               @"name":kS(@"setUp", @"register"),
                               @"frameY":@"10",
                               @"describe":@"",
                               @"actionType":@"xxx",
                               },
                           @{
                               @"classStr":@"GSettingCellView",
//                               @"name":@"特定商業交易法",
                               @"name":kS(@"setUp", @"userService"),
                               @"frameY":@"",
                               @"describe":@"",
                               @"actionType":@"xxx",
                               },
                           @{
                               @"classStr":@"GSettingCellView",
//                               @"name":@"隱私協定",
                               @"name":kS(@"setUp", @"privacy"),
                               @"frameY":@"",
                               @"describe":@"",
                               @"actionType":@"xxx",
                               },
                           ];
    for (int i=0; i<arrayContent.count; i++) {
        UIView*viewCell=[UIView getViewWithConfigData:arrayContent[i]];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewCell];
        if ([[arrayContent[i] ojsk:@"actionType"] notEmptyOrNull]) {
            [viewCell addViewTarget:self select:@selector(menuBtnClick:)];
        }
    }
    
    if (kUtility_Login.isLogIn) {
        
        WSSizeButton*btnLogOut=[RHMethods buttonWithframe:CGRectMake(0, 20, kScreenWidth, 50) backgroundColor:rgbwhiteColor text:kS(@"setUp", @"logout") font:17 textColor:rgb(13, 107, 154) radius:0 superview:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:btnLogOut];
        
        [btnLogOut addViewClickBlock:^(UIView *view) {
            [kUtility_Login logoOut];
        }];
    }
 
}
-(void)menuBtnClick:(UIButton*)btn{ 
      __weak __typeof(self) weakSelf = self;
    if ([[btn.data ojsk:@"actionType"] isEqualToString:@"switchLanguage"]){
        [self pushController:[SwitchLanguageViewController class] withInfo:nil withTitle:[btn.data ojsk:@"name"]];
    }else if ([[btn.data ojsk:@"actionType"] isEqualToString:@"changeBindingMailbox"]) {
        [kUtility_Login mustLogInWithBlock:^(id data, int status, NSString *msg) {
            
            [weakSelf pushController:[ChangeBindingMailBoxViewController class] withInfo:nil withTitle:[btn.data ojsk:@"name"]];
        }];
        
    
    
    }else if ([[btn.data ojsk:@"actionType"] isEqualToString:@"modifyPassword"]){
        [kUtility_Login mustLogInWithBlock:^(id data, int status, NSString *msg) {
            
            [weakSelf pushController:[ModifyPasswordViewController class] withInfo:nil withTitle:[btn.data ojsk:@"name"]];
        }];
        
    
    
    }else if ([[btn.data ojsk:@"actionType"] isEqualToString:@"aboutUs"]){
        [self pushController:[AboutUsViewController class] withInfo:nil withTitle:[btn.data ojsk:@"name"]];
    }else if ([[btn.data ojsk:@"actionType"] isEqualToString:@"clearCache"]){
        UIAlertController*alertcv=[UIAlertController alertControllerWithTitle:kS(@"setUp", @"dialog_message_clear_cache") message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertcv addAction:[UIAlertAction actionWithTitle:kS(@"setUp", @"dialog_button_positive") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alertcv addAction:[UIAlertAction actionWithTitle:kS(@"setUp", @"dialog_button_negative") style:UIAlertActionStyleCancel handler:nil]];
        [UTILITY.currentViewController presentViewController:alertcv animated:YES completion:^{
            
        }];
//    }else if([[btn.data ojsk:@"name"] isEqualToString:@"注册协议"]){
        
    }else if([[btn.data ojsk:@"name"] isEqualToString:kS(@"setUp", @"register")]){
        krequestParam
        //        注册协议：http://h5.trendycarshare.jp/home/welcome/rule_reg?apptype=app&language=cn/en/jp
        //        特定商業交易法：http://h5.trendycarshare.jp/home/welcome/rule_service?apptype=app&language=cn/en/jp
        //        隱私協定：http://h5.trendycarshare.jp/home/welcome/rule_privacy?apptype=app&language=cn/en/jp
        //        没翻译
        [dictparam setObject:@"app" forKey:@"apptype"];
        [dictparam setObject:@"app" forKey:@"apptype"];
        [UTILITY.currentViewController pushController:[SelectWebUrlViewController class] withInfo:nil withTitle:@"" withOther:[NSString stringWithFormat:@"http://h5.trendycarshare.jp/home/welcome/rule_reg%@",dictparam.wgetParamStr]];
//    }else if([[btn.data ojsk:@"name"] isEqualToString:@"特定商業交易法"]){
    }else if([[btn.data ojsk:@"name"] isEqualToString:kS(@"setUp", @"userService")]){
        krequestParam
        //        注册协议：http://h5.trendycarshare.jp/home/welcome/rule_reg?apptype=app&language=cn/en/jp
        //        特定商業交易法：http://h5.trendycarshare.jp/home/welcome/rule_service?apptype=app&language=cn/en/jp
        //        隱私協定：http://h5.trendycarshare.jp/home/welcome/rule_privacy?apptype=app&language=cn/en/jp
        //        没翻译
        [dictparam setObject:@"app" forKey:@"apptype"];
        [dictparam setObject:@"app" forKey:@"apptype"];
        [UTILITY.currentViewController pushController:[SelectWebUrlViewController class] withInfo:nil withTitle:@"" withOther:[NSString stringWithFormat:@"http://h5.trendycarshare.jp/home/welcome/rule_service%@",dictparam.wgetParamStr]];
//    }else if([[btn.data ojsk:@"name"] isEqualToString:@"隱私協定"]){
    }else if([[btn.data ojsk:@"name"] isEqualToString:kS(@"setUp", @"privacy")]){
        krequestParam
        //        注册协议：http://h5.trendycarshare.jp/home/welcome/rule_reg?apptype=app&language=cn/en/jp
        //        特定商業交易法：http://h5.trendycarshare.jp/home/welcome/rule_service?apptype=app&language=cn/en/jp
        //        隱私協定：http://h5.trendycarshare.jp/home/welcome/rule_privacy?apptype=app&language=cn/en/jp
        //        没翻译
        [dictparam setObject:@"app" forKey:@"apptype"];
        [dictparam setObject:@"app" forKey:@"apptype"];
        [UTILITY.currentViewController pushController:[SelectWebUrlViewController class] withInfo:nil withTitle:@"" withOther:[NSString stringWithFormat:@"http://h5.trendycarshare.jp/home/welcome/rule_privacy%@",dictparam.wgetParamStr]];
    }
}

-(void)clearCacheClicked{
    
    [SVProgressHUD showWithStatus:nil maskType:SVProgressHUDMaskTypeNone ];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSFileManager* fileManager=[NSFileManager defaultManager];
        NSString *filespath = DOCUMENTS_CHAT_FOLDER;//语音文件
        BOOL blDele= [fileManager removeItemAtPath:filespath error:nil];
        DLog(@"语音删除:%d",blDele);
        //本土语言聊天语音文件DOCUMENTS_FOLDER
        BOOL byDele= [fileManager removeItemAtPath:DOCUMENTS_FOLDER error:nil];
        DLog(@"语音删除:%d",byDele);
        NSString *filesShareImagePath = DOCUMENTS_SHARE_IMAGES;//分享拼接图片文件
        BOOL blDele1= [fileManager removeItemAtPath:filesShareImagePath error:nil];
        DLog(@"分享拼接图片删除:%d",blDele1);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            DLog(@"清理图片缓存");
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                [SVProgressHUD showImage:nil status:kS(@"setUp", @"dialog_message_clear_cache")];
            }];
        });
    });
    
    
    
}
#pragma mark  request data from the server use tableview

#pragma mark - request data from the server

#pragma mark - event listener function


#pragma mark - delegate function


@end
