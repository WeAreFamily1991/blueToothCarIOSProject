
//
//  UILabel+atrribulttext.m
//  GangFuBao
//
//  Created by home on 15/12/6.
//  Copyright © 2015年 55like. All rights reserved.
//

#import "UILabel+atrribulttext.h"

@implementation UILabel (atrribulttext)
/**
 放置图片的
 
 @param t_image 目标颜色
 @param t_size 目标大小
 @param t_index 目标下标
 */
-(void)setImage:(UIImage *)t_image contentSize:(CGSize)t_size atIndex:(NSInteger)t_index{
    NSMutableAttributedString *attriString ;
    if (!t_image) {
        return;
    }
    if (self.attributedText) {
        attriString=[[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
        
    }else{
        NSString*str= self.text;
        attriString = [[NSMutableAttributedString alloc] initWithString:str];
    }
    // 添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = t_image;//[UIImage imageNamed:@"Chat_head"];
    //计算文字padding-top ，使图片垂直居中
    CGFloat textPaddingTop = (self.font.lineHeight - self.font.pointSize) / 2.0;
    // 设置图片大小
    attch.bounds = CGRectMake(0, -textPaddingTop, t_size.width, t_size.height);
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    t_index=t_index<0?0:t_index;
    [attriString insertAttributedString:string atIndex:t_index];
    self.attributedText=attriString;
}
-(void)setColor:(UIColor *)textcoler contenttext:(NSString *)text{
    [self setColor:textcoler font:self.font contenttext:text];
}
-(void)setColor:(UIColor *)textcoler font:(UIFont *)textFont contenttext:(NSString *)text{
    [self setColor:textcoler font:textFont contenttext:text CycleText:YES];
}
-(void)setColor:(UIColor *)textcoler font:(UIFont *)textFont contenttext:(NSString *)text CycleText:(BOOL)a_bool{
    NSMutableAttributedString *attriString ;
    if (self.attributedText) {
        attriString=[[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
        
    }else{
        NSString*str= self.text;
        attriString = [[NSMutableAttributedString alloc] initWithString:str];
    }
    NSMutableDictionary *attributeDict=[NSMutableDictionary new];
    if (textcoler) {
        [attributeDict setValue:textcoler forKey:NSForegroundColorAttributeName];
    }
    if (textFont) {
        [attributeDict setValue:textFont forKey:NSFontAttributeName];
    }
    //    NSDictionary *attributeDict = @{
    //                                    NSForegroundColorAttributeName:textcoler,
    //                                    NSFontAttributeName:textFont
    //                                    };
    //NSRange hh=[self.text rangeOfString:text];
    //[attriString setAttributes:attributeDict range:hh];
    NSString *strTempTxt=self.text;
    //      NSRange  hh ={0,1};
    BOOL boolNext=NO;
    float fx_temp=0;
    do {
        NSRange hh=[strTempTxt rangeOfString:text];
        if (hh.location == NSNotFound) {
            //不存在
        }else{
            [attriString setAttributes:attributeDict range:NSMakeRange(fx_temp+hh.location, hh.length)];
            fx_temp+=hh.location+hh.length;
            strTempTxt=[strTempTxt substringFromIndex:hh.location+hh.length];
            if ([strTempTxt containsString:text] && a_bool) {
                boolNext=YES;
            }else{
                boolNext=NO;
            }
        }
    } while (boolNext);
    //        [attriString setAttributes:attributeDict range:[self.sumStr rangeOfString:RSC.bname]];
    //        self.aSumstr=attriString;
    self.attributedText=attriString;
}

-(void)setAllTextLineSpacing:(CGFloat)lineS{
    NSMutableAttributedString *attriString ;
    if (self.attributedText) {
        attriString=[[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    }else{
        NSString*str= self.text;
        attriString = [[NSMutableAttributedString alloc] initWithString:str];
    }
    NSMutableParagraphStyle *paragraphStyleT = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyleT setLineSpacing:lineS];//调整行间距
    [paragraphStyleT setLineBreakMode:NSLineBreakByTruncatingTail];
    [attriString addAttribute:NSParagraphStyleAttributeName value:paragraphStyleT range:NSMakeRange(0, [self.text length])];
    self.attributedText = attriString;
}

-(void)labelSetColorWithAttributedStringType:(ZHLLabelType)type textstr:(NSString *)text content:(id)content location:(NSInteger)loc length:(NSInteger)len{
    
    
    
    
    NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:text];
    
    // 颜色0
    // 字体大小1
    // 带斜线2
    //下划线3
    // 背景颜色4
    // 阴影5
    //字体倾斜6
    switch (type) {
        case 0:
        {
            [AttributedStr addAttribute:NSForegroundColorAttributeName
                                  value:content
                                  range:NSMakeRange(loc, len)];
        }
            break;
        case 1:
        {
            [AttributedStr addAttribute:NSFontAttributeName
             
                                  value:content
             
                                  range:NSMakeRange(loc, len)];
        }
            break;
        case 2:
        {
            [AttributedStr addAttribute:NSStrikethroughStyleAttributeName
                                  value:@(NSUnderlineStyleSingle)
                                  range:NSMakeRange(loc, len)];
        }
            break;
        case 3:
        {
            [AttributedStr addAttribute:NSUnderlineStyleAttributeName
                                  value:[NSNumber numberWithInt:NSUnderlineStyleDouble]
                                  range:NSMakeRange(loc, len)];
        }
            break;
        case 4:
        {
            [AttributedStr addAttribute:NSBackgroundColorAttributeName
                                  value:content
                                  range:NSMakeRange(loc, len)];
        }
            break;
        case 5:
        {
            
            [AttributedStr addAttribute:NSShadowAttributeName value:content range:NSMakeRange(loc, len)];
        }
            break;
        case 6:
        {
            
            
            NSInteger num = [content integerValue];
            [AttributedStr addAttribute:NSObliquenessAttributeName value:@(num) range:NSMakeRange(loc, len)];
            
        }
            break;
        default:
            break;
    }
    
    
    [self setAttributedText:AttributedStr];
    
    
    
}

- (void)changeLineSpaceForLabelWithSpace:(float)space {
    
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
    
}

- (void)changeWordSpaceForLabelWithSpace:(float)space {
    
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
    
}

- (void)changeSpaceForLabelWithLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
    
}

///改变lbl宽度
-(void)changeLabelWidth{
    float fw=[self sizeThatFits:CGSizeMake(MAXFLOAT, H(self))].width;
    self.frameWidth=fw;
}
///改变lbl高度
-(void)changeLabelHeight{
    float fh=[self sizeThatFits:CGSizeMake(W(self),MAXFLOAT)].height;
    self.frameHeight=fh;
}



@end
