

#import <Foundation/Foundation.h>

/**
 数据更新block
 
 @param data 更新的数据
 @param weakme 避免循环引用 更新的自身指针
 */
typedef void (^UpDataBlock)(id data,id weakme);
@interface NSObject (expanded)
//perfrom for bool
- (void)performSelector:(SEL)aSelector withBool:(BOOL)aValue;
- (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects;
- (id)performSelector:(SEL)aSelector withParameters:(void *)firstParameter, ...;


/**
 执行一个block 多长时间之后
 
 @param block 要执行的block
 @param timeafter 时间秒
 */
-(void)performBlock:(AllcallBlock)block afterDelay:(NSInteger)timeafter;

//json 相关


-(id)getSafeObjWithkey:(NSString*)key;
-(void)setSafeObj:(id)obj forKey:(NSString*)key;





#pragma mark  - 运行时添加属性


/**
 动态为view添加属性
 
 @param someThing 所添加对象
 @param key 关键字
 */
- (void)setAddValue:(id)someThing forKey:(NSString *)key;


/**
 获取为view添加的对象
 
 @param key 关键字
 @return 获取对象
 */
- (id)getAddValueForKey:(NSString *)key;


/**
 移除对象
 
 @param key 关键字
 */
- (void)removeAddValueForkey:(NSString *)key;

/**
 成为一个可变的对象（数组变成可变数组，）
 
 @return 返回的新对象
 */
-(id)toBeMutableObj;


-(void)setApiInfoWithApiStr:(NSString*)apiStr withPathStr:(NSString*)pathStr;
-(NSString*)jsonStrSYS;

//-(void)setAddUpdataBlock:(UpDataBlock)addUpdataBlock;

@property(nonatomic,copy)UpDataBlock addUpdataBlock;

/**
 绑定的数据
 */
@property(nonatomic,strong)id data;

/**
 更新数据
 */
-(void)upDataMe;


/**
 更新数据
 */
-(void)upDataMeWithData:(id)data;

@end


