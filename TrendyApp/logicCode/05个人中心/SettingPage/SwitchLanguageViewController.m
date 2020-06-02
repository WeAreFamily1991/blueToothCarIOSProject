//
//  SwitchLanguageViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/4.
//  Copyright © 2019 55like. All rights reserved.
//

#import "SwitchLanguageViewController.h"
#import "MYRHTableView.h"
//#import ""
#import "WSButtonGroup.h"
#import "AppDelegate.h"
@interface SwitchLanguageViewController ()<WSButtonGroupdelegate>
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)WSButtonGroup*btnGroup;
@end

@implementation  SwitchLanguageViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    [self rightButton:kS(@"switchLanguage", @"Preservation") image:nil sel:@selector(saveBtnClick:)];
    [self navbarTitle:kST(@"switchLanguage")];
    
    if ([kLanguageService.appLanguage isEqualToString:@"cn"]) {
        [_btnGroup btnClickAtIndex:0];
    }else if ([kLanguageService.appLanguage isEqualToString:@"en"]) {
        [_btnGroup btnClickAtIndex:1];
    }else if ([kLanguageService.appLanguage isEqualToString:@"jp"]) {
        [_btnGroup btnClickAtIndex:2];
    }else if ([kLanguageService.appLanguage isEqualToString:@"zd"]) {
        [_btnGroup btnClickAtIndex:3];
    }
}
-(void)saveBtnClick:(UIButton*)btn{
    
//    kLanguageService.apiUrl(@"")
    krequestParam
    [dictparam setObject:[_btnGroup.currentSelectBtn getAddValueForKey:@"typeStr"] forKey:@"language"];
    if ([[dictparam ojsk:@"language"] isEqualToString:@"zd"]) {
        [dictparam setObject:@"en" forKey:@"language"];
    }
    
    [NetEngine createPostAction:@"welcome/set_user_language" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
//            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
            kLanguageService.appLanguage=[_btnGroup.currentSelectBtn getAddValueForKey:@"typeStr"];
            [[UTILITY getAddValueForKey:@"AppDelegate"] clearAndinitAllController];
            
            NSString* languageStr=kLanguageService.appLanguage;
            
            //    当前语言 appLanguage cn jp en
            
            if ([languageStr isEqualToString:@"cn"]) {
                languageStr=@"zh_Hans_HK";
            }else if ([languageStr isEqualToString:@"jp"]) {
                
                languageStr=@"ja_JP";
            }else if ([languageStr isEqualToString:@"en"]) {
                
                languageStr=@"en_US";
            }
            // 强制 成 当前设置语言
            [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:languageStr,nil]
                                                      forKey:@"AppleLanguages"];
            
            
            
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
            
        }
    }];

    
    
}

#pragma mark -   write UI
-(void)addView{
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
   
    _btnGroup=[WSButtonGroup new];
    _btnGroup.delegate=self;
    NSArray*arraytitle=@[kS(@"switchLanguage", @"Chinese"),kS(@"switchLanguage", @"English"),kS(@"switchLanguage", @"Japanese"),@"字段",];
    NSArray*arraykey=@[@"cn",@"en",@"jp",@"zd",];
    for (int i=0; i<arraytitle.count; i++) {
         WSSizeButton*btnCellView=[RHMethods buttonWithframe:CGRectMake(0, 0, kScreenWidth, 55) backgroundColor:rgb(255, 255, 255) text:arraytitle[i] font:16 textColor:rgb(51, 51, 51) radius:0 superview:nil];
        [btnCellView setAddValue:arraykey[i] forKey:@"typeStr"];
        [_btnGroup addButton:btnCellView];
        [_mtableView.defaultSection.noReUseViewArray addObject:btnCellView];
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(15, 0, btnCellView.frameWidth-15, 1) backgroundcolor:rgb(238, 238, 238) superView:btnCellView];
        viewLine.frameBY=0;
        [btnCellView setBtnLableFrame:CGRectMake(16, 0, 150, btnCellView.frameHeight)];
        [btnCellView setImageStr:@"" SelectImageStr:@"complete1"];
        [btnCellView setBtnImageViewFrame:CGRectMake(0, 0, 18.5, 13)];
        [btnCellView imgbeCY];
        btnCellView.imgframeRX=15;
        if (i==0) {
            btnCellView.frameY=1;
//            btnCellView.selected=YES;
        }
    }
    
    
}
#pragma mark  request data from the server use tableview

#pragma mark - request data from the server
#pragma mark - event listener function
-(void)WSButtonGroupChange:(WSButtonGroup *)btnCrop{
    
    
}
#pragma mark - delegate function


@end
