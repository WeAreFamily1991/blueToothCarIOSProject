

#import "NSString+expanded.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString(expanded)

- (NSString *)stringByReplaceHTML{
    
    NSScanner *theScanner;
    NSString *text = nil;
    NSString *html = self;
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@" "];
        
    } // while //
    
    return html;
    
}

-(NSString*)replaceControlString
{
    NSString *tempStr = self;
    tempStr=[tempStr stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    tempStr=[tempStr stringByReplacingOccurrencesOfString:@"\b" withString:@"\\b"];
    tempStr=[tempStr stringByReplacingOccurrencesOfString:@"\f" withString:@"\\f"];
    tempStr=[tempStr stringByReplacingOccurrencesOfString:@"\r" withString:@"\\t"];
    tempStr=[tempStr stringByReplacingOccurrencesOfString:@"\t" withString:@"\\r"];
    tempStr=[tempStr stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    tempStr=[tempStr stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    
    return tempStr;
}
-(NSString*)replaceStoreKey
{
    NSString *tempStr = self;
    NSRange range=[tempStr rangeOfString:@"user.lat="];
    if (range.length==0) {
        range=[tempStr rangeOfString:@"loc.latOffset="];
        if (range.length==0) {
            range=[tempStr rangeOfString:@"lat="];
            if (range.length!=0) {
                NSInteger l=[[tempStr substringFromIndex:[tempStr rangeOfString:@"lng="].location] rangeOfString:@"&"].location;
                range.length=[tempStr rangeOfString:@"lng="].location-range.location+l;
                tempStr=[tempStr stringByReplacingCharactersInRange:range withString:@""];
            }
        }else{
            NSInteger l=[[tempStr substringFromIndex:[tempStr rangeOfString:@"loc.lngOffset="].location] rangeOfString:@"&"].location;
            range.length=[tempStr rangeOfString:@"loc.lngOffset="].location-range.location+l;
            tempStr=[tempStr stringByReplacingCharactersInRange:range withString:@""];
        }
    }else{
        NSInteger l=[[tempStr substringFromIndex:[tempStr rangeOfString:@"user.lng="].location] rangeOfString:@"&"].location;
        range.length=[tempStr rangeOfString:@"user.lng="].location-range.location+l;
        tempStr=[tempStr stringByReplacingCharactersInRange:range withString:@""];
    }
    return tempStr;
}

//"upload/".length=7
-(NSString*)imagePathType:(imageType)__type
{
    if ((__type != imageSmallType && __type != imageBigType)) {
        return self;
    }else{
        return [self stringByReplacingOccurrencesOfString:@"/" withString:__type==imageSmallType?@"/s":@"/b" options:0 range:NSMakeRange(7, [self length]-7)];
    }
}
- (CGFloat)getHeightByWidth:(NSInteger)_width font:(UIFont *)_font
{
    //!self不会调用，不用判断了
    return [self sizeWithFont:_font constrainedToSize:CGSizeMake(_width, 1000) lineBreakMode:(NSLineBreakMode)UILineBreakModeCharacterWrap].height;
}

//- (NSString *)indentString:(NSString*)_string font:(UIFont *)_font
//{
//    if (!_string) {
//        return self;
//    }else{
//        CGSize  size=[_string sizeWithFont:_font];
//        NSLog(@"%f,%f",size.width/[@" " sizeWithFont:_font].width,[@" " sizeWithFont:_font].width);
//        return [NSString stringWithFormat:@"%@%@",[@"" stringByPaddingToLength:(size.width/[@"_" sizeWithFont:_font].width+2)*2 withString:@" " startingAtIndex:0],self];
//    }
//}
- (NSString *)indentLength:(CGFloat)_len font:(UIFont *)_font
{
    NSString *str=@"";
    CGFloat temp=0.0;
    while (temp<=_len) {
        str=[str stringByAppendingString:@" "];
        temp=[str sizeWithFont:_font].width;
    }
    return [NSString stringWithFormat:@"%@%@",str,self];
    //[@"" stringByPaddingToLength:(_len/[@"_" sizeWithFont:_font].width+1) withString:@"_" startingAtIndex:0]
}
/**
 验证输入内容是否标准
 
 @param strInfo 提示语
 @return 真假
 */
- (BOOL)notEmptyInputWithInfo:(NSString *)strInfo{
    //验证特殊字符
    if ([self isEqualToString:@"Null"] ||
        [self isEqualToString:@"null"] ||
        [self isEqualToString:@"NULL"]) {
        [SVProgressHUD showImage:nil status:[NSString stringWithFormat:@"输入非法字符'%@'",self]];
        return NO;
    }
    //验证空内容
    if ([self isEqualToString:@""] || [self isEqualToString:@"\"\""] || [self isEqualToString:@"''"]) {
        [SVProgressHUD showImage:nil status:strInfo?strInfo:@"输入内容不能为空！"];
        return NO;
    }
    return YES;
}
- (BOOL)notEmpty
{
    if ([self isEqualToString:@""] || [self isEqualToString:@"\"\""] || [self isEqualToString:@"''"]) {
        return NO;
    }
    return YES;
}
- (BOOL)notEmptyOrNull
{
    if ([self isEqualToString:@""]||[self isEqualToString:@"null"] || [self isEqualToString:@"\"\""] || [self isEqualToString:@"''"]) {
        return NO;
    }
    return YES;
}

+ (NSString *)replaceEmptyOrNull:(NSString *)checkString
{
    if (!checkString || [checkString isEqualToString:@""]||[checkString isEqualToString:@"null"]) {
        return @"";
    }
    return checkString;
}
-(NSString*)replaceTime
{
    NSString *tempStr = self;
    tempStr=[tempStr stringByReplacingOccurrencesOfString:@"-" withString:@"年" options:0 range:NSMakeRange(0, 5)];
    tempStr=[tempStr stringByReplacingOccurrencesOfString:@"-" withString:@"月"];
    tempStr=[tempStr stringByAppendingString:@"日"];
    return tempStr;
}

- (NSString*)soapMessage:(NSString *)key,...
{
    NSString *akey;
    va_list ap;
    va_start(ap, key);
    NSString *obj = nil;
    if (key) {
        if ([key rangeOfString:@"<"].length == 0)
            obj=[NSString stringWithFormat:@"<%@>%@</%@>",key,@"%@",key];
        else
            obj = key;
        
        while (obj&&(akey=va_arg(ap,id))) {
            if ([akey rangeOfString:@"<"].length == 0)
                obj=[obj stringByAppendingFormat:@"<%@>%@</%@>",akey,@"%@",akey];
            else
                obj = [obj stringByAppendingString:akey];
        }
        va_end(ap);
    }
    
    return [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?><soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:soap=\"http://soap.csc.iofd.cn/\"> <soapenv:Header/> <soapenv:Body><soap:%@>%@</soap:%@></soapenv:Body></soapenv:Envelope>",self,obj?obj:@"",self];
}
- (NSString *)md5{
    const char *concat_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(concat_str, (CC_LONG)strlen(concat_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++){
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
    
}

- (CGSize)SIZEwF:(CGFloat )font W:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:font];
    CGSize maxSize = CGSizeMake(maxW, 0x1.fffffep+127f
                                );
    
    // 获得系统版本
    if ( ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)) {
        return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    } else {
        return [self sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:maxSize];
    }
}

- (CGFloat)HEIGHTwF:(CGFloat )font W:(CGFloat)maxW{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:font];
    CGSize maxSize = CGSizeMake(maxW, 0x1.fffffep+127f
                                );
    
    // 获得系统版本
    if ( ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)) {
        return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.height;
    } else {
        return [self sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:maxSize].height;
    }
}


- (CGFloat)HEIGHTwaF:(UIFont* )font W:(CGFloat)maxW{
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, 0x1.fffffep+127f
                                );
    
    // 获得系统版本
    if ( ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)) {
        return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.height;
    } else {
        return [self sizeWithFont:font constrainedToSize:maxSize].height;
    }
    
}
-(CGFloat)widthWithFont:(CGFloat )font
{
    UIFont*zmfont=[UIFont systemFontOfSize:font];
    NSDictionary *attrs = @{NSFontAttributeName : zmfont};
    
    CGSize maxsize=CGSizeMake(MAXFLOAT, font);
    return [self boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
}
//更改过行间距算高度
- (CGFloat)changeLineSpaceForLabelWithSpace:(float)space labW:(CGFloat)w font:(UIFont *)font{
    
    NSString *labelText = self;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, w, 0)];
    lab.attributedText = attributedString;
    lab.numberOfLines = 0;
    lab.font = font;
    [lab sizeToFit];
    
    CGFloat h = 0;
    
    h = lab.frameHeight;
    
    //    lab = nil;
    
    
    return h;
    
}

///小图(获取小图路径
-(NSString *)small_UrlGetFileName{
    NSString *fileName = [self lastPathComponent];
    //    DLog(@"\n\n\nfileName:%@\n\n\n",fileName);
    NSString *strUrl=self;
    if ([fileName notEmptyOrNull] &&
        ([strUrl rangeOfString:baseDomain].length>0)&&
        ([strUrl rangeOfString:@"album"].length>0)) {
        strUrl=[strUrl stringByReplacingOccurrencesOfString:fileName withString:[NSString stringWithFormat:@"small_%@",fileName]];
    }
    return strUrl;
}
///中图(获取小图路径
-(NSString *)middle_UrlGetFileName{
    NSString *fileName = [self lastPathComponent];
    //    DLog(@"\n\n\nfileName:%@\n\n\n",fileName);
    NSString *strUrl=self;
    if ([fileName notEmptyOrNull] &&
        ([strUrl rangeOfString:baseDomain].length>0)&&
        ([strUrl rangeOfString:@"album"].length>0)) {
        strUrl=[strUrl stringByReplacingOccurrencesOfString:fileName withString:[NSString stringWithFormat:@"middle_%@",fileName]];
    }
    return strUrl;
}

-(NSString*)formPriceStr{
    NSString*strReturn=self;
    if ([strReturn rangeOfString:@","].length||strReturn.floatValue<1000) {
    }else{
        NSString*priceStr=[NSString stringWithFormat:@"%.0f",strReturn.floatValue];
        NSString*str=@"";
        if (priceStr.length>3) {
            int length = (int)priceStr.length;
            for (int i=0; i<length; i++) {
                if (i%3==0&&i>0) {
                    str =[NSString stringWithFormat:@"%@,%@",[priceStr substringWithRange:NSMakeRange(length-1-i, 1)],str];
                }else{
                    str =[NSString stringWithFormat:@"%@%@",[priceStr substringWithRange:NSMakeRange(length-1-i, 1)],str];
                }
            }
        }
        strReturn = str;
//        strReturn =str.noformPriceStr;
    }
    return strReturn;
}
-(NSString*)noformPriceStr{
    NSString*strReturn=self;
    if ([strReturn rangeOfString:@","].length) {
        return [strReturn stringByReplacingOccurrencesOfString:@"," withString:@""];
    }
    return self;
}

@end

