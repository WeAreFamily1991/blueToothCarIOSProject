
typedef enum {
    imageSmallType,
    imageMiddlType,
    imageBigType,
}imageType;
#import <Foundation/Foundation.h>

@interface NSString(expanded)

-(NSString*)replaceControlString;
-(NSString*)imagePathType:(imageType)__type;
- (CGFloat)getHeightByWidth:(NSInteger)_width font:(UIFont *)_font;
//- (NSString *)indentString:(NSString*)_string font:(UIFont *)_font;
- (NSString *)indentLength:(CGFloat)_len font:(UIFont *)_font;
/**
 验证输入内容是否标准
 
 @param strInfo 提示语
 @return 真假
 */
- (BOOL)notEmptyInputWithInfo:(NSString *)strInfo;
/**
 验证内容是否为空的
 （不验证Null）
 @return 真假
 */
- (BOOL)notEmpty;
- (BOOL)notEmptyOrNull;
+ (NSString *)replaceEmptyOrNull:(NSString *)checkString;
-(NSString*)replaceTime;
-(NSString*)replaceStoreKey;
- (NSString*)soapMessage:(NSString *)key,...;
- (NSString *)md5;

/**
 根据字体与宽度获取lable的size
 
 @param font 字体大小
 @param maxW 宽度
 @return size
 */
- (CGSize)SIZEwF:(CGFloat )font W:(CGFloat)maxW;


#pragma mark zxhalwaysuse 常用 根据 字体 （大小）与宽度获取lable的高度
/**
 根据字体与宽度获取lable的高度
 
 @param font 字体大小
 @param maxW 宽度
 @return size
 */
- (CGFloat)HEIGHTwF:(CGFloat )font W:(CGFloat)maxW;

#pragma mark zxhalwaysuse 常用 根据 字体 与宽度获取lable的高度
/**
 根据字体与宽度获取lable的高度
 
 @param font 字体
 @param maxW 宽度
 @return size
 */
- (CGFloat)HEIGHTwaF:(UIFont* )font W:(CGFloat)maxW;


/**
 根据字体获取宽度
 
 @param font 字体大小
 @return 返回值
 */
-(CGFloat)widthWithFont:(CGFloat )font;


/**
 更改过行间距算高度
 */
- (CGFloat)changeLineSpaceForLabelWithSpace:(float)space labW:(CGFloat)w font:(UIFont *)font;
///小图(获取小图路径
-(NSString *)small_UrlGetFileName;
///中图(获取小图路径
-(NSString *)middle_UrlGetFileName;


//- @"appLanguagedata".intValue;
//@"appLanguagedata".integerValue;
//@"appLanguagedata".floatValue;
//-(int)price_intValue;
//-(NSInteger)price_integerValue;
//-(float)price_floatValue;
//-(NSString*)realPrice;
-(NSString*)formPriceStr;
-(NSString*)noformPriceStr;
@end

