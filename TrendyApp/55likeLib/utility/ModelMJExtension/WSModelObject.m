//
//  WSModleObject.m
//  55likeLibDemo
//
//  Created by 55like on 2018/9/30.
//  Copyright © 2018年 55like lj. All rights reserved.
//

#import "WSModelObject.h"

@implementation WSModelObject
-(id)ojk:(id)aKey{
    if (![self respondsToSelector:NSSelectorFromString(aKey)]) {
        return [self getAddValueForKey:aKey];
    }
    return   [self valueForKeyPath:aKey];
}
-(NSString *)ojsk:(NSString *)key{
    id value=[self ojk:key];
    
    
    if (value==nil||value==[NSNull null]) {
        return @"";
    }else{
        if ([value isKindOfClass:[NSNumber class]]) {
            return [NSString stringWithFormat:@"%@",value];
        }else if([value isKindOfClass:[NSString class]]){
            if ([value isEqualToString:@""] || [value isEqualToString:@"null"]) {
                return  @"";
            }
        }
        return value;
    }
    
}
-(void)setObject:(id)obj forKey:(NSString *)key{
    if (![self respondsToSelector:NSSelectorFromString(key)]) {
        [self setAddValue:obj forKey:key];
        return ;
    }
    [self setValue:obj forKey:key];
}
@end
