

#import "NSObject+expanded.h"
#import "WSModelObject.h"
#import "objc/runtime.h"
static char somethingAdd;

static char addSomeUpdataBlock;
@implementation NSObject (expanded)



- (void)performSelector:(SEL)aSelector withBool:(BOOL)aValue
{
    BOOL myBoolValue = aValue; // or NO
    
    NSMethodSignature* signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature: signature];
    [invocation setTarget: self];
    [invocation setSelector: aSelector];
    [invocation setArgument: &myBoolValue atIndex: 2];
    [invocation invoke];
}

- (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects {
    NSMethodSignature *signature = [self methodSignatureForSelector:aSelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:aSelector];
    
    NSUInteger i = 1;
    for (id object in objects) {
        [invocation setArgument:(__bridge void *)(object) atIndex:++i];
    }
    [invocation invoke];
    
    if ([signature methodReturnLength]) {
        id data;
        [invocation getReturnValue:&data];
        return data;
    }
    return nil;
}

- (id)performSelector:(SEL)aSelector withParameters:(void *)firstParameter, ... {
    NSMethodSignature *signature = [self methodSignatureForSelector:aSelector];
    NSUInteger length = [signature numberOfArguments];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:aSelector];
    
    [invocation setArgument:&firstParameter atIndex:2];
    va_list arg_ptr;
    va_start(arg_ptr, firstParameter);
    for (NSUInteger i = 3; i < length; ++i) {
        void *parameter = va_arg(arg_ptr, void *);
        [invocation setArgument:&parameter atIndex:i];
    }
    va_end(arg_ptr);
    
    [invocation invoke];
    
    if ([signature methodReturnLength]) {
        id data;
        [invocation getReturnValue:&data];
        return data;
    }
    return nil;
}




-(void)performBlock:(AllcallBlock)block afterDelay:(NSInteger)timeafter{
    [self performSelector:@selector(performBlok:) withObject:block afterDelay:timeafter];
}

-(void)performBlok:(AllcallBlock)block{
    if (block) {
        block(nil,200,nil);
    }
    
}

-(id)getSafeObjWithkey:(NSString*)key{
    
    if ([self isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    id dic=self;
    if (![self isKindOfClass:[NSDictionary class]]) {
        
        
        if (![self respondsToSelector:NSSelectorFromString(key)]) {
            return [self getAddValueForKey:key];
        }
        
        return   [self valueForKeyPath:key];
        
        
    }
    
    NSDictionary*dict=dic;
    id value=  [dict objectForKey:key];
    //    id value = [self objectForKey:aKey];
    if (!value||value==[NSNull null]) {
        
        
        return nil;
        
        
    }else{
        if ([value isKindOfClass:[NSNumber class]]) {
            return [NSString stringWithFormat:@"%@",value];
        }
        else if([value isKindOfClass:[NSString class]]){
            if ([value isEqualToString:@""] || [value isEqualToString:@"null"]) {
                return  @"";
            }
        }
        return value;
    }
    
}

-(void)setSafeObj:(id)obj forKey:(NSString*)key{
    
    id dic=self;
    if (![self isKindOfClass:[NSDictionary class]]) {
        
        if (![self respondsToSelector:NSSelectorFromString(key)]) {
            
            [self setAddValue:obj forKey:key];
            
            return ;
        }
        
        [self setValue:obj forKey:key];
        return;
    }else{
        
        [dic setObject:obj forKey:key];
        return;
    }
}

-(void)setAddValue:(id)someThing forKey:(NSString *)key{
    if (!someThing) {
        [self removeAddValueForkey:key];
        
        return;
    }
    
    
    NSMutableDictionary *operations = objc_getAssociatedObject(self, &somethingAdd);
    if (operations) {
        //        return operations;
    }else{
        operations = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, &somethingAdd, operations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        //        return operations;
    }
    
    [operations setObject:someThing forKey:key];
    
#ifdef DEBUG
    //    ([self isKindOfClass:[UIView class]]||[self isKindOfClass:[BaseViewController class]])
    if (([self isKindOfClass:[UIView class]]&&[key isEqualToString:@"data"])||[self isKindOfClass:[BaseViewController class]]) {
        
        NSMutableDictionary*  someThing =[operations objectForKey:@"data"];
        UIView*viewSelf=(id)self;
        if ([self isKindOfClass:[BaseViewController class]]) {
            BaseViewController*viewc=(id)self;
            someThing=operations;
            viewSelf=viewc.navView;
        }
        
        
        UIView*view1=[operations objectForKey:@"addINdexButton"];
        if (view1==nil) {
            __weak __typeof(self) weakSelf = self;
            
            view1=[UIView viewWithFrame:CGRectMake(0, 0, 10, 10) backgroundcolor:RGBACOLOR(0, 0, 222, 0.2) superView:nil reuseId:nil];
            //            [self setAddValue:view1 forKey:@"addINdexButton"];
            //            [operations objectForKey:@""];
            [operations setObject:view1 forKey:@"addINdexButton"];
            [view1 addViewClickBlock:^(UIView *view) {
                
                NSMutableDictionary*  someThing =[operations objectForKey:@"data"];
                NSMutableString*logstr=[NSMutableString new];
                [ logstr appendFormat:@"\n%@",NSStringFromClass([weakSelf class])];
                //                if (weakSelf.type) {
                //                    [logstr appendString:@"\n type:"];
                //                    [logstr appendString: weakSelf.type];
                //                }
                if (someThing) {
                    [logstr appendString:@"\n数据："];
                    if ([someThing isKindOfClass:[NSString class]]) {
                        [logstr appendString:(id)someThing];
                    }else{
                        [logstr appendString: [someThing jsonStrSYS]];
                    }
                }
                NSLog(@"%@",logstr);
            }];
        }
        [viewSelf addSubview:view1];
        if ([self isKindOfClass:[BaseViewController class]]) {
            view1.frameRX=0;
            view1.frameBY=0;
        }
        //        [view1 beCenter];
        
    }
    
    
#endif
    
    
}
-(id)getAddValueForKey:(NSString *)key{
    
    NSMutableDictionary *operations = objc_getAssociatedObject(self, &somethingAdd);
    
    if (operations==nil) {
        return nil;
    }
    
#ifdef DEBUG
    //    ([self isKindOfClass:[UIView class]]||[self isKindOfClass:[BaseViewController class]])
    if (([self isKindOfClass:[UIView class]]&&[key isEqualToString:@"data"])||[self isKindOfClass:[BaseViewController class]]) {
        
        NSMutableDictionary*  someThing =[operations objectForKey:@"data"];
        UIView*viewSelf=(id)self;
        if ([self isKindOfClass:[BaseViewController class]]) {
            BaseViewController*viewc=(id)self;
            someThing=operations;
            viewSelf=viewc.navView;
        }
        
        
        UIView*view1=[operations objectForKey:@"addINdexButton"];
        if (view1==nil) {
            __weak __typeof(self) weakSelf = self;
            
            view1=[UIView viewWithFrame:CGRectMake(0, 0, 10, 10) backgroundcolor:RGBACOLOR(0, 0, 222, 0.2) superView:nil reuseId:nil];
            //            [self setAddValue:view1 forKey:@"addINdexButton"];
            //            [operations objectForKey:@""];
            [operations setObject:view1 forKey:@"addINdexButton"];
            [view1 addViewClickBlock:^(UIView *view) {
                NSMutableDictionary*  someThing =[operations objectForKey:@"data"];
                NSMutableString*logstr=[NSMutableString new];
                [ logstr appendFormat:@"\n%@",NSStringFromClass([weakSelf class])];
                //                if (weakSelf.type) {
                //                    [logstr appendString:@"\n type:"];
                //                    [logstr appendString: weakSelf.type];
                //                }
                if (someThing) {
                    [logstr appendString:@"\n数据："];
                    if ([someThing isKindOfClass:[NSString class]]) {
                        [logstr appendString:(id)someThing];
                    }else{
                        [logstr appendString: [someThing jsonStrSYS]];
                    }
                }
                NSLog(@"%@",logstr);
            }];
        }
        [viewSelf addSubview:view1];
        if ([self isKindOfClass:[BaseViewController class]]) {
            view1.frameRX=0;
            view1.frameBY=0;
        }
        //        [view1 beCenter];
        
    }
    
    
#endif
    
    return [operations objectForKey:key];
}
-(void)removeAddValueForkey:(NSString *)key{
    
    
    NSMutableDictionary *operations = objc_getAssociatedObject(self, &somethingAdd);
    
    if (operations==nil) {
        return ;
    }
    
    [operations removeObjectForKey:key];
    
}

/**
 成为一个可变的对象（数组变成可变数组，）
 
 @return 返回的新对象
 */
-(id)toBeMutableObj{
    if ([self isKindOfClass:[NSArray class]]) {
        NSArray*me=(id)self;
        NSMutableArray*marray=[NSMutableArray new];
        for (int i=0; i<[me count]; i++) {
            [marray addObject: [me[i] toBeMutableObj]];
        }
        return marray;
        
    }else if([self isKindOfClass:[NSDictionary class]]){
        NSDictionary*me=(id)self;
        
        NSArray*keyArray=[me allKeys];
        NSMutableDictionary*mdic=[NSMutableDictionary new];
        for (int i=0; i<keyArray.count; i++) {
            NSString*key=keyArray[i];
            [mdic setObject:[[me objectForKey:key] toBeMutableObj] forKey:key];
        }
        //         [mdic setObject:@"abc" forKey:@"cdse"];
        return mdic;
        
    }
    
    return self;
}
-(void)setApiInfoWithApiStr:(NSString*)apiStr withPathStr:(NSString*)pathStr{
    
    if (pathStr==nil) {
        pathStr=@"";
    }
    if (apiStr==nil) {
        apiStr=@"";
    }
    if ([self isKindOfClass:[NSArray class]]) {
        NSArray*me=(id)self;
        for (int i=0; i<[me count]; i++) {
            [me[i] setApiInfoWithApiStr:apiStr withPathStr:[NSString stringWithFormat:@"%@[]",pathStr]];
        }
    }else if([self isKindOfClass:[NSDictionary class]]){
        NSMutableDictionary*me=(id)self;
        [me setObject:[NSString stringWithFormat:@"%@ %@",apiStr,pathStr] forKey:@"😁___apiStr"];
        NSArray*keyArray=[me allKeys];
        for (int i=0; i<keyArray.count; i++) {
            NSString*key=keyArray[i];
            [[me objectForKey:key] setApiInfoWithApiStr:apiStr withPathStr:[NSString stringWithFormat:@"%@>%@",pathStr,key]];
        }
        
    }
}
-(NSString *)jsonStrSYS{
    NSError *parseError = nil;
    NSDictionary*dic=[self getpuredic];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
#pragma mark  wd 打印字符串注释
    NSString*str=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return [str stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    //    return [[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
}

-(NSDictionary*)getpuredic{
    
    if ([self isKindOfClass:[WSModelObject class]]) {
        return [self wkeyValues];
    }
    if ([self isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary*msdic=[NSMutableDictionary new];
        //    [mstr appendString:@"{\n"];
        NSArray*keyArry=[(NSDictionary*)self allKeys];
        for (NSString *keyname in keyArry) {
            NSObject*obj=[(NSDictionary*)self objectForJSONKey:keyname];
            obj= [(NSDictionary*)obj getpuredic];
            if (obj) {
                [msdic setValue:obj forKey:keyname];
            }
            
        }
        return msdic;
    }
    if ([self isKindOfClass:[NSString class]]) {
        return (NSDictionary*)self;
    }
    if ([self isKindOfClass:[NSNumber class]]) {
        return (NSDictionary*)self;
    }
    if ([self isKindOfClass:[NSArray class]]) {
        
        NSMutableArray*array=[NSMutableArray new];
        for (NSDictionary*dic in (NSArray*)self) {
            [array addObject:[dic getpuredic]];
        }
        return (NSDictionary*)array;
    }
    
    
    
    //    return self.wkeyValues;
    return [NSDictionary new];
    
}



-(void)setAddUpdataBlock:(UpDataBlock)addUpdataBlock{
    if (addUpdataBlock==nil) {
        id obj=   objc_getAssociatedObject(self, &addSomeUpdataBlock);
        
        if (obj) {
            objc_removeAssociatedObjects(obj);
        }
        return;
    }
    
    objc_setAssociatedObject(self, &addSomeUpdataBlock, addUpdataBlock, OBJC_ASSOCIATION_COPY);
}
-(UpDataBlock)addUpdataBlock{
    
    return objc_getAssociatedObject(self, &addSomeUpdataBlock);;
}

-(NSMutableDictionary *)data{
    return [self getAddValueForKey:@"data"];
}
-(void)setData:(id)dataDic{
    if (dataDic) {
        [self setAddValue:dataDic forKey:@"data"];
    }else{
        [self removeAddValueForkey:@"data"];
    }
    
    
    
}
-(void)upDataMe{
    if (self.addUpdataBlock) {
        self.addUpdataBlock(self.data, self);
    }
}

-(void)upDataMeWithData:(id)data{
    self.data=data;
    if (self.addUpdataBlock) {
        self.addUpdataBlock(self.data, self);
    }
}
@end


