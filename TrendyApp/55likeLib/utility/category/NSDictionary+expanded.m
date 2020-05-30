

#import "NSDictionary+expanded.h"


@implementation NSDictionary (expanded)
- (id)objectForJSONKey:(id)aKey
{
    id value = [self objectForKey:aKey];
    if (!value||value==[NSNull null]) {
        return nil;
    }else{
        if ([value isKindOfClass:[NSNumber class]]) {
            return [NSString stringWithFormat:@"%@",value];
        }
        else if([value isKindOfClass:[NSString class]]){
            if ([value isEqualToString:@""] || [value isEqualToString:@"null"]) {
                return  nil;
            }
        }
        return value;
    }
}
- (NSString*)valueForJSONStrKey:(NSString *)key
{
    NSString *str = [self valueForJSONKey:key];
    return str?str:@"";
}
- (id)valueForJSONKey:(NSString *)key
{
    id value = [self valueForKey:key];
    if (!value||value==[NSNull null]) {
        return nil;
    }else{
        if ([value isKindOfClass:[NSNumber class]]) {
            return [NSString stringWithFormat:@"%@",value];
        }else if([value isKindOfClass:[NSString class]]){
            if ([value isEqualToString:@""] || [value isEqualToString:@"null"]) {
                return  nil;
            }
        }
        return value;
    }
}
- (id)valueForJSONKeys:(NSString *)key,...NS_REQUIRES_NIL_TERMINATION
{
    id object=[self valueForJSONKey:key];
    NSString *akey;
    va_list ap;
    va_start(ap, key);
    while (object&&(akey=va_arg(ap,id))) {
        object=[object valueForJSONKey:akey];
    }
    va_end(ap);
    return object;
}
//always return an array
- (void)setObjects:(id)objects forKey:(id)aKey
{
    if (!aKey || !objects || [self isKindOfClass:[NSMutableDictionary class]]) {
        return;
    }
    if ([self objectForKey:aKey]) {
        NSMutableArray *array = [NSMutableArray arrayWithArray:[self objectForKey:aKey]];
        [array addObject:objects];
        [(NSMutableDictionary*)self setObject:array forKey:aKey];
    }
    else
    {
        [(NSMutableDictionary*)self setObject:[NSMutableArray arrayWithObject:objects] forKey:aKey];
    }
}
-(id)ojk:(id)aKey{
    return   [self objectForJSONKey:aKey];
}
-(NSString*)ojsk:(NSString *)key{
    NSString*strReturn=@"";
    
    id value = [self valueForKey:key];
    if (value==nil||value==[NSNull null]) {
        strReturn = @"";
    }else{
        if ([value isKindOfClass:[NSNumber class]]) {
            strReturn = [NSString stringWithFormat:@"%@",value];
        }else if([value isKindOfClass:[NSString class]]){
            if ([value isEqualToString:@""] || [value isEqualToString:@"null"]) {
                strReturn =  @"";
            }else{
                strReturn =value;
            }
        }else{
            strReturn =value;
        }
        //        return value;
    }
    
    if ([key rangeOfString:@"price"].length) {
        return [strReturn formPriceStr];
    }
    return strReturn;
    //    return [self valueForJSONStrKey:key];
    
}


-(NSString *)wgetParamStr{
    NSDictionary*dictionary=self;
    NSArray*keyArry=[dictionary allKeys];
    NSMutableString*mstr=[NSMutableString new];
    for (NSString *keyname in keyArry) {
        NSString*value=[dictionary objectForKey:keyname];
        if([value isKindOfClass:[NSString class]]){
            if ([keyname isEqual:[keyArry firstObject ]]) {
                [mstr appendFormat:@"?%@=%@",keyname,value];
            }else{
                [ mstr appendFormat:@"&%@=%@",keyname,value];
            }
        }
    }
    
    return mstr;
    
}
-(NSString *)description{
    
    return self.jsonStrSYS;
    
}

@end
