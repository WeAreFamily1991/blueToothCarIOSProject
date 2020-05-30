//
//  LanguageService.h
//  TrendyApp
//
//  Created by 55like on 2019/3/1.
//  Copyright © 2019 55like. All rights reserved.
//

#import "MYBaseService.h"

#define kLanguageService [LanguageService shareInstence]
//#define kS(page,strkey) [[LanguageService shareInstence] getStrWithPageKey: page withStrKey: strkey ]
#define kS(page,strkey) [[LanguageService shareInstence] getStrWithPageKey: page withStrKey: strkey ]

#define kST(page) [[LanguageService shareInstence] getPageTitleWithPageKey: page ]
NS_ASSUME_NONNULL_BEGIN



@interface LanguageService : MYBaseService

/**
 当前语言 appLanguage cn jp en 
 
 */
@property(nonatomic,copy)NSString*appLanguage;

-(void)loadLanguageDataWithBlock:(AllcallBlock)callBackBlok;
-(NSString*)getStrWithPageKey:(NSString*)pageKey withStrKey:(NSString*)strKey;
-(NSString*)getPageTitleWithPageKey:(NSString*)pageKey ;
-(void)loadLanguageData;
@end

NS_ASSUME_NONNULL_END
