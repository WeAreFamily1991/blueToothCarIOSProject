//
//  Utility_pushService.h
//  TrendyApp
//
//  Created by 55like on 2019/4/28.
//  Copyright © 2019 55like. All rights reserved.
//

#import "MYBaseService.h"

#define kUtility_pushService [Utility_pushService shareInstence]
NS_ASSUME_NONNULL_BEGIN

@interface Utility_pushService : MYBaseService
-(void)receviveNoticeWithDic:(NSMutableDictionary*)dic;
-(void)receviveNoticeforwordWithDic:(NSMutableDictionary*)dic;
@end

NS_ASSUME_NONNULL_END
