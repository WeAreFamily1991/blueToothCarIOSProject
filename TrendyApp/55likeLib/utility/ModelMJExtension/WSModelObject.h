//
//  WSModleObject.h
//  55likeLibDemo
//
//  Created by 55like on 2018/9/30.
//  Copyright © 2018年 55like lj. All rights reserved.
//

#import "WDExtension.h"
#import <Foundation/Foundation.h>
@interface WSModelObject : NSObject

/**
 返回对象 objectForJSONKey
 
 @param aKey key
 @return obj 对象（是什么就返回什么）
 */
-(id)ojk:(id)aKey;

/**
 返回字符串 valueForJSONStrKey
 
 @param key key
 @return 字符串
 */
-(NSString*)ojsk:(NSString *)key;
-(void)setObject:(id)obj forKey:(NSString*)key;
@end
