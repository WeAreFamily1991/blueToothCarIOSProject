//
//  Myimage.h
//  SpookCam
//
//  Created by 55like on 17/04/2017.
//
//

#import <Foundation/Foundation.h>
#import "SubRectOnly.h"
@interface Myimage : NSObject
#pragma mark  - 0 整体运用


@property(nonatomic,assign) UInt32 * startPixelIndex;

/**
 高度 图片的高度需要/2
 */
@property(nonatomic,assign)NSUInteger height;

/**
 宽度 图片的宽度需要/2
 */
@property(nonatomic,assign)NSUInteger width;

/**
 相对与父对象的x值 对自身来说没有意义 /2
 */
@property(nonatomic,assign)NSUInteger x;

/**
 相对与父对象的x值 对自身来说没有意义 /2
 */
@property(nonatomic,assign)NSUInteger y;
@property(nonatomic,strong)UIImageView*bianjianimage;

#pragma mark  - 位置计算转换
@property(nonatomic,assign)float fx;
@property(nonatomic,assign)float fy;
@property(nonatomic,assign)float fwidth;
@property(nonatomic,assign)float fheight;
@property(nonatomic,assign)float fXW;
@property(nonatomic,assign)float fRX;
@property(nonatomic,assign)float fYH;
@property(nonatomic,assign)float fBY;
@property(nonatomic,assign)float fCX;
@property(nonatomic,assign)float fCY;

#pragma mark  -

/**
 绘图 上下文 是图形上下文,可以将其理解为一块画布
 */
@property(nonatomic,assign)CGContextRef contextindex;

/**
 使用RGB模式的颜色空间（在Quartz 2D中凡是使用带有Create或者Copy关键字方法创建的对象，在使用后一定要使用对应的方法释放
 */
@property(nonatomic,assign)CGColorSpaceRef colorSpaceIndex;

/**
 初始的图片对象
 */
@property(nonatomic,strong)UIImage*originalImage;


/**
 重新设置所有值 创建新的上下文
 */
-(void)restarAll;


/**
 获取UIImageView 用于显示
 
 @return UIImageView
 */
-(UIImageView*)getimageView;


+(Myimage*)getWith:(Myimage*)superMyimge with:(SubRectOnly*) subrect;
+(Myimage*)MyimageWithMyimage:(Myimage*)superMyimge X:(NSInteger)X  Y:(NSInteger)Y  Width:(NSInteger)width Height:(NSUInteger) height;
+(Myimage*)MyimageWithStr:(NSString*)imagestr;

+(Myimage*)MyimageWithImage:(UIImage*)imagexx;


-(void)clearmarray;

/**
 将当前图片的当前状态 插入到当前控制器的当前scrollView
 */
-(void)insertMeToScrollView;

#pragma mark  - 1,整体剪裁
/**
 锐化 根据比率 提高识别度
 */
-(void)RuhuiHuaWithBata;

/**
 找出所有图片的边界 描绘出说有的边框
 */
-(void)findbind;
/**
 寻找单独的方块
 
 @return 单独的方块 从外到里 进行边界查找
 */
-(Myimage*)getLaggestRect320;

@property(nonatomic,assign)BOOL isScreenWidth;

/**
 找到最大的那一个 Myimage
 
 @return Myimage 寻找单独的方块
 */
-(Myimage*)getLaggestRect;


#pragma mark 获取识别出来的所有长方形

/**
 找出所有的矩形 Myiimage
 
 @return 矩形边框
 */
-(NSMutableArray*)getAllRects;
@property(nonatomic,strong)NSMutableArray*allRectsArray;


#pragma mark - 2文字合并

@property(nonatomic,weak)Myimage*superMyImage;

/**
 判断是不是文字方块
 
 @return YES 是
 */
-(BOOL)isTextView;


/**
 图片类型 空的时候没有类型  @"第一次文字合并"  @"第二次文字合并"
 @"第一次文字合并"  但行合并之后
 @"第二次文字合并"  如果存在多行多行合并
 */
@property(nonatomic,copy)NSString*imageType;





/**
 @"第一次文字合并" 第一次合并 之前的 Myimage 一定是 文字  如果图片其他元为空
 */
@property(nonatomic,strong)NSMutableArray*sub1TextArray;


/**
 @"第二次文字合并" 之后将所有的的字控件放到一块
 */
@property(nonatomic,strong)NSMutableArray*subImage1TypeArray;


/**
 @"第一次文字合并" 第一次合并 之前的 Myimage 有 @"第一次文字合并"
 */
@property(nonatomic,strong)NSMutableArray*sub2TextArray;


/**
 @"第二次文字合并" 之后将所有的的字控件放到一块
 */
@property(nonatomic,strong)NSMutableArray*subImage2TypeArray;


#pragma mark  第一次文字合并

/**
 颜色统计数组
 发现可能出现 高度或者宽度为0 的对象
 @return <#return value description#>
 */
-(NSMutableArray *)colortongjiSuju;
/**
 颜色数据统计
 */
-(void)logColorTongji;

/**
 myimage 对象 文字第一次合并 但行的进行合并
 
 @param subArray 传入的SubRectOnly 的对象数组
 @return  Myimage 对象 数组
 */
-(NSMutableArray*)getRectHeBing:(NSMutableArray*)subArray;



#pragma mark  第二次文字合并
/**
 myimage 对象数组 第二次合并 多行合并
 
 @param subArray 传入的 Myimage 的对象数组
 @return  Myimage 对象 数组
 */
-(NSMutableArray*)get2RectHeBing:(NSMutableArray*)subArray;




#pragma mark - 3代码书写



/**
 如果是文字的时候 取非白色的 颜色分布最多的颜色

 @return 文字颜色
 */
-(UInt32)textColor;


-(NSString*)writeMeHfileWithClassName:(NSString*)className;
-(NSString*)writeMeMfileWithClassName:(NSString*)className;

/**
 创建的时候控件的类名
 */
@property(nonatomic,copy)NSString*myClassNameStr;
/**
 创建的时候的文件路径 （用来存放图片数据）
 */
@property(nonatomic,copy)NSString*filePath;

///**
// 生成书写代码的字段 writeVariableName
//
// @param index 变量的数字 防止重复
// */
//-(NSString*)writeCreatCodeWith:(int)index;

/**
 书写的时候变量名称
 */
@property(nonatomic,copy)NSString*writeVariableName;

/**
 变量的创建字段
 */
@property(nonatomic,copy)NSString*writeCreatStr;
/**
 变量的类型名称
 */
@property(nonatomic,copy)NSString*writeCreatTypeStr;

@property(nonatomic,copy)NSString*writeX;
@property(nonatomic,copy)NSString*writeRX;

@property(nonatomic,assign)BOOL isCenterX;

@property(nonatomic,copy)NSString*writeY;

@property(nonatomic,copy)NSString*writeTextColor;


@property(nonatomic,copy)NSString*writeTextfont;
@property(nonatomic,copy)NSString*writeTextStr;



@property(nonatomic,copy)NSString*writeWidth;

@property(nonatomic,copy)NSString*writeHight;




@end
