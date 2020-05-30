//
//  WSNetTool.h
//  EastCollection
//
//  Created by 55like on 17/02/2017.
//  Copyright © 2017 55like. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "WSNetTools.h"
#import "WSModelObject.h"
@interface WSNetTools : NSObject



#pragma mark zxhalwaysuse 常用 自动生成modle类

/**
 / 去掉斜杠，首字母大写

 @param apiurl 接口
 @param json 字典
 */
+(void)fileWithAPIUrl:(NSString*)apiurl Json:(NSDictionary*)json;

+(void)fileJson:(NSDictionary*)dic modelname:(NSString*)modelname HeadrPrefix:(NSString*)hpx folderName:(NSString*)folderName;

@end
