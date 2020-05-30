//
//  LanguageService.m
//  TrendyApp
//
//  Created by 55like on 2019/3/1.
//  Copyright © 2019 55like. All rights reserved.
//

#import "LanguageService.h"
#import "NSObject+JSONCategories.h"
#import "NSString+JSONCategories.h"
#import "Utility_Location.h"
@interface LanguageService()
{
    NSString* _appLanguage;
}
@property(nonatomic,strong)NSMutableDictionary*languageServiceDataDic;

/**
 页面的key
 */
@property(nonatomic,copy)NSString*pageKey;

/**
 页面的值 的 key
 */
@property(nonatomic,strong)NSString*pagetitleKey;
@end
@implementation LanguageService

static LanguageService *_languageService=nil;
static dispatch_once_t utilityLanguageService;

-(NSString *)appLanguage{
    if (_appLanguage==nil) {
        NSString*applanguage=[[NSUserDefaults standardUserDefaults]objectForKey:@"appLanguage"];
        if ([applanguage isKindOfClass:[NSString class]] &&[applanguage notEmptyOrNull]) {
        }else{
            NSArray *languages = [NSLocale preferredLanguages];
            applanguage = [languages objectAtIndex:0];
            applanguage = @"jp-";
        }
        //        applanguage=@"zh";
        [self setAppLanguage:applanguage];
        
        
        
    }
    if ([_appLanguage isEqualToString:@"cn"]) {
//        return @"en";
        return @"cn";
    }
    
    
    return _appLanguage;
}
-(NSString *)pageKey{
    if (_pageKey==nil) {
        
//        NSString *keyLanguage=nil;
        if ([self.appLanguage isEqualToString: @"cn"]) {
            _pageKey=@"zh";
        }else{
            _pageKey=self.appLanguage;
        }
    }
    return _pageKey;
}

-(NSString *)pagetitleKey{
    if (_pagetitleKey==nil) {
        _pagetitleKey=[NSString stringWithFormat:@"%@_title",self.pageKey];
        
        
    }
    return _pagetitleKey;
}


-(void)setAppLanguage:(NSString *)appLanguage{
    
    [[Utility_Location shareInstence] removeCityInfo];
    if ([appLanguage hasPrefix: @"zh"]||[appLanguage hasPrefix: @"cn"]) {//当前语言是否为中文繁体
        appLanguage=@"cn";
//        @"cn";
    }else  if ([appLanguage hasPrefix: @"en"]) {
        appLanguage=@"en";
    }else  if ([appLanguage hasPrefix: @"zd"]) {
        appLanguage=@"zd";
    }else  if ([appLanguage hasPrefix: @"ja"]||[appLanguage hasPrefix: @"jp"]) {
        appLanguage=@"jp";
//        @"jp";
    }else{
        appLanguage=@"en";
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:appLanguage forKey:@"appLanguage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    _pageKey=nil;
    _pagetitleKey=nil;
    _appLanguage=appLanguage;
}

+(instancetype)shareInstence{
    dispatch_once(&utilityLanguageService, ^ {
        _languageService = [[LanguageService alloc] init];
        
        NSString*applanguagestr=[[NSUserDefaults standardUserDefaults]objectForKey:@"appLanguagedata"];
        _languageService.languageServiceDataDic=[applanguagestr objectFromJSONString ];
    });
    return _languageService;
}

-(void)loadLanguageData{
    [[NetEngine Share] createAction:NETypeHttpPost withUrl:@"http://trendycarshare.jp/api/common/pageDisplay" withParams:nil     withFile:nil withCache:NO withMask:SVProgressHUDMaskTypeNone onCompletion:^(id resData, BOOL isCache) {
        [[NSUserDefaults standardUserDefaults] setObject:[resData JSONString] forKey:@"appLanguagedata"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.languageServiceDataDic=resData;
//        callBackBlok(nil,200,nil);
    } onError:nil];
}

-(void)loadLanguageDataWithBlock:(AllcallBlock)callBackBlok{
    if (_languageServiceDataDic) {
        callBackBlok(nil,200,nil);
        return;
    }
//    @"appLanguagedata".intValue;
//    @"appLanguagedata".integerValue;
//    @"appLanguagedata".floatValue;
    [[NetEngine Share] createAction:NETypeHttpPost withUrl:@"http://trendycarshare.jp/api/common/pageDisplay" withParams:nil     withFile:nil withCache:NO withMask:SVProgressHUDMaskTypeClear onCompletion:^(id resData, BOOL isCache) {
        [[NSUserDefaults standardUserDefaults] setObject:[resData JSONString] forKey:@"appLanguagedata"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.languageServiceDataDic=resData;
        callBackBlok(nil,200,nil);
    } onError:^(NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loadLanguageDataWithBlock:callBackBlok];
        });        
    }];
}

//-(NSString*)getStrWithPageKey:(NSString*)pageKey withStrKey:(NSString*)strKey{
//    return [NSString stringWithFormat:@"%@%@",[self.languageServiceDataDic[pageKey][@"language"][strKey][@"zh"] notEmptyOrNull]?@"'":@"",strKey];
//}
//-(NSString*)getPageTitleWithPageKey:(NSString*)pageKey {
//    return [NSString stringWithFormat:@"%@%@",[self.languageServiceDataDic[pageKey][@"zh_title"] notEmptyOrNull]?@"'":@"",pageKey];
//}

-(NSString*)getStrWithPageKey:(NSString*)pageKey withStrKey:(NSString*)strKey{
    #pragma mark  是否只显示 语言key
    if ([_appLanguage isEqualToString:@"zd"]) {
            NSString*pagPre=[pageKey substringToIndex:1];
            if (pageKey.length>=3) {
                pagPre=[pageKey substringToIndex:3];
            }
            return  [NSString stringWithFormat:@"%@.%@",pagPre,strKey];
    }
    

    NSString*str=[NSString stringWithFormat:@"%@",self.languageServiceDataDic[pageKey][@"language"][strKey][self.pageKey]];
//    if (![str notEmptyOrNull]||![self.pageKey isEqualToString:@"zh"] ) {
//    if (![str notEmptyOrNull]) {
//        return [NSString stringWithFormat:@"%@,%@",strKey,pageKey];
//    }
    str=[str stringByReplacingOccurrencesOfString:@"%s" withString:@"%@"];
    str=[str stringByReplacingOccurrencesOfString:@"\\％@" withString:@"%@"];
    str=[str stringByReplacingOccurrencesOfString:@"％@" withString:@"%@"];
    return str;
}
-(NSString*)getPageTitleWithPageKey:(NSString*)pageKey {
#pragma mark  是否只显示 语言key
    
    if ([_appLanguage isEqualToString:@"zd"]) {
        return [NSString stringWithFormat:@"p.%@",pageKey];
    }
    NSString*str=[NSString stringWithFormat:@"%@",self.languageServiceDataDic[pageKey][self.pagetitleKey]];
    //    if (![str notEmptyOrNull]||![self.pageKey isEqualToString:@"zh"] ) {
    if (![str notEmptyOrNull] ) {
        return [NSString stringWithFormat:@"%@",pageKey];
    }
    
    str=[str stringByReplacingOccurrencesOfString:@"%s" withString:@"%@"];
    str=[str stringByReplacingOccurrencesOfString:@"\\％@" withString:@"%@"];
    str=[str stringByReplacingOccurrencesOfString:@"％@" withString:@"%@"];
    return str;
}

@end
