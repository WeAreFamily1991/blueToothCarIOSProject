

#import "RHMethods.h"
#import "WSKeyBoardTextField.h"
#import "WSBeBigImageView.h"
@implementation RHMethods

+ (UITextField *)textFieldlWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor placeholder:(NSString *)aplaceholder text:(NSString*)atext{
    return [self textFieldlWithFrame:aframe font:afont color:acolor placeholder:aplaceholder text:atext supView:nil];
}
+ (UILabel*)labelWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor text:(NSString*)atext{
    return [self labelWithFrame:aframe font:afont color:acolor text:atext supView:nil];
}
+ (UILabel*)labelWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor text:(NSString*)atext textAlignment:(NSTextAlignment)aalignment{
    return [self labelWithFrame:aframe font:afont color:acolor text:atext textAlignment:aalignment supView:nil reuseId:nil];
}
+ (UILabel*)labelWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor text:(NSString*)atext textAlignment:(NSTextAlignment)aalignment setLineSpacing:(float)afloat{
    return [self labelWithFrame:aframe font:afont color:acolor text:atext textAlignment:aalignment setLineSpacing:afloat supView:nil];
}
+(UIButton*)buttonWithFrame:(CGRect)_frame title:(NSString*)_title  image:(NSString*)_image bgimage:(NSString*)_bgimage{
    return [self buttonWithFrame:_frame title:_title image:_image bgimage:_bgimage supView:nil];
}
+(UIImageView*)imageviewWithFrame:(CGRect)_frame defaultimage:(NSString*)_image{
    return [self imageviewWithFrame:_frame defaultimage:_image supView:nil];
}
+(UIImageView*)imageviewWithFrame:(CGRect)_frame defaultimage:(NSString*)_image contentMode:(UIViewContentMode )cmode{
    return [self imageviewWithFrame:_frame defaultimage:_image contentMode:cmode supView:nil];
}
+(UIImageView*)imageviewWithFrame:(CGRect)_frame defaultimage:(NSString*)_image stretchW:(NSInteger)_w stretchH:(NSInteger)_h{
    return [self imageviewWithFrame:_frame defaultimage:_image stretchW:_w stretchH:_h supView:nil];
}

///分割线
+(UIView *)lineViewWithFrame:(CGRect)_frame{
    return [self lineViewWithFrame:_frame supView:nil];
}



+ (UITextField *)textFieldlWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor placeholder:(NSString *)aplaceholder text:(NSString*)atext supView:(UIView *)sView{
    return [RHMethods textFieldlWithFrame:aframe font:afont color:acolor placeholder:aplaceholder text:atext supView:sView reuseId:nil];
}

+ (UITextField *)textFieldlWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor placeholder:(NSString *)aplaceholder text:(NSString*)atext supView:(UIView *)sView   reuseId:(NSString*)reuseID{
    if ([sView getAddValueForKey:reuseID]) {
        
        UITextField *baseTextField=[sView getAddValueForKey:reuseID];
        baseTextField.frame=aframe;
        return baseTextField;
        
    }else{
        UITextField *baseTextField=[[WSKeyBoardTextField alloc]initWithFrame:aframe];
        [baseTextField setKeyboardType:UIKeyboardTypeDefault];
        [baseTextField setBorderStyle:UITextBorderStyleNone];
        [baseTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [baseTextField setTextColor:acolor];
        baseTextField.placeholder=aplaceholder;
        baseTextField.font=afont;
        [baseTextField setSecureTextEntry:NO];
        [baseTextField setReturnKeyType:UIReturnKeyDone];
        [baseTextField setText:atext];
        baseTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        if (sView) {
            [sView addSubview:baseTextField];
            if (reuseID) {
                [sView setAddValue:baseTextField forKey:reuseID];
            }
        }
        return baseTextField;
    }
}

/**
 *    根据aframe返回相应高度的label（默认透明背景色，白色高亮文字）
 *
 *    @param    aframe    预期框架 若height=0则计算高度  若width=0则计算宽度
 *    @param    afont    字体
 *    @param    acolor    颜色
 *    @param    atext    内容
 *
 *    @return    UILabel
 */
+ (UILabel*)labelWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor text:(NSString*)atext supView:(UIView *)sView
{
    return [self labelWithFrame:aframe font:afont color:acolor text:atext textAlignment:NSTextAlignmentLeft supView:sView reuseId:nil];// autorelease];
}

/**
 *    根据aframe返回相应高度的label（默认透明背景色，白色高亮文字）
 *
 *    @param    aframe    预期框架 若height=0则计算高度  若width=0则计算宽度
 *    @param    afont    字体
 *    @param    acolor    颜色
 *    @param    atext    内容
 *  @param  aalignment   位置
 *  @param  afloat   行距(文本不能为空)
 *
 *    @return    UILabel
 */
+ (UILabel*)labelWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor text:(NSString*)atext textAlignment:(NSTextAlignment)aalignment setLineSpacing:(float)afloat supView:(UIView *)sView
{
    UILabel *lblTemp=[self labelWithFrame:aframe font:afont color:acolor text:atext textAlignment:aalignment supView:sView reuseId:nil];
    if (afloat && [atext notEmptyOrNull]) {
        lblTemp.numberOfLines=0;
        
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:lblTemp.text];
        NSMutableParagraphStyle *paragraphStyleT = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyleT setLineSpacing:afloat];//调整行间距
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyleT range:NSMakeRange(0, [atext length])];
        lblTemp.attributedText = attributedString;
        if (!aframe.size.height) {
            CGSize size = [lblTemp sizeThatFits:CGSizeMake(aframe.size.width, MAXFLOAT)];
            aframe.size.height = size.height;
            lblTemp.frame=aframe;
        }
        
    }
    return lblTemp;
}

+ (UILabel*)labelWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor text:(NSString*)atext textAlignment:(NSTextAlignment)aalignment supView:(UIView *)sView   reuseId:(NSString*)reuseID
{
    if ([sView getAddValueForKey:reuseID]) {
        UILabel *baseLabel=[sView getAddValueForKey:reuseID];
        //        if(afont)baseLabel.font=afont;
        //        if(acolor)baseLabel.textColor=acolor;
        //        //     baseLabel.lineBreakMode=UILineBreakModeCharacterWrap;
        //        baseLabel.text=atext;
        //        baseLabel.textAlignment=aalignment;
        //        baseLabel.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
        //        [baseLabel setLineBreakMode:NSLineBreakByTruncatingTail|NSLineBreakByWordWrapping];
        
        
        //        if(aframe.size.height>20){
        //            baseLabel.numberOfLines=0;
        //        }
        if (!aframe.size.height) {
            //            baseLabel.numberOfLines=0;
            CGSize size = [baseLabel sizeThatFits:CGSizeMake(aframe.size.width, MAXFLOAT)];
            aframe.size.height = size.height;
            baseLabel.frame = aframe;
        }else if (!aframe.size.width) {
            CGSize size = [baseLabel sizeThatFits:CGSizeMake(MAXFLOAT, 20)];
            aframe.size.width = size.width;
            baseLabel.frame = aframe;
        }else{
            baseLabel.frame=aframe;            
        }
        //    baseLabel.adjustsFontSizeToFitWidth=YES
        //        baseLabel.backgroundColor=[UIColor clearColor];
        //        baseLabel.highlightedTextColor=acolor;//kVersion7?[UIColor whiteColor]:
        //        if (sView) {
        //            [sView addSubview:baseLabel];
        //            if (reuseID) {
        //                [sView setAddValue:baseLabel forKey:reuseID];
        //            }
        //
        //        }
        
        return baseLabel;// autorelease];
    }else{
        UILabel *baseLabel=[[UILabel alloc] initWithFrame:aframe];
        if(afont)baseLabel.font=afont;
        if(acolor)baseLabel.textColor=acolor;
        //     baseLabel.lineBreakMode=UILineBreakModeCharacterWrap;
        baseLabel.text=atext;
        baseLabel.textAlignment=aalignment;
        baseLabel.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
        [baseLabel setLineBreakMode:NSLineBreakByTruncatingTail|NSLineBreakByWordWrapping];
        
        
        if(aframe.size.height>20){
            baseLabel.numberOfLines=0;
        }
        if (!aframe.size.height) {
            baseLabel.numberOfLines=0;
            CGSize size = [baseLabel sizeThatFits:CGSizeMake(aframe.size.width, MAXFLOAT)];
            aframe.size.height = size.height;
            baseLabel.frame = aframe;
        }else if (!aframe.size.width) {
            CGSize size = [baseLabel sizeThatFits:CGSizeMake(MAXFLOAT, 20)];
            aframe.size.width = size.width;
            baseLabel.frame = aframe;
        }
        //    baseLabel.adjustsFontSizeToFitWidth=YES
        baseLabel.backgroundColor=[UIColor clearColor];
        baseLabel.highlightedTextColor=acolor;//kVersion7?[UIColor whiteColor]:
        if (sView) {
            [sView addSubview:baseLabel];
            if (reuseID) {
                [sView setAddValue:baseLabel forKey:reuseID];
            }
            
        }
        
        return baseLabel;// autorelease];
    }
    
    
}
+ (UILabel*)labelWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor text:(NSString*)atext textAlignment:(NSTextAlignment)aalignment supView:(UIView *)sView {
    
    return [RHMethods labelWithFrame:aframe font:afont color:acolor text:atext textAlignment:aalignment supView:sView reuseId:nil];
}

+(UIButton*)buttonWithFrame:(CGRect)_frame title:(NSString*)_title image:(NSString*)_image bgimage:(NSString*)_bgimage supView:(UIView *)sView
{
    UIButton *baseButton=[UIButton buttonWithType:UIButtonTypeCustom];//[[UIButton alloc] initWithFrame:_frame];
    baseButton.frame=_frame;
    baseButton.titleLabel.font=fontTitle;
    if (_title) {
        [baseButton setTitle:_title forState:UIControlStateNormal];
        [baseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    if (_image && [_image notEmptyOrNull]) {
        [baseButton setImage:[UIImage imageNamed:_image] forState:UIControlStateNormal];
    }
    if (_bgimage && [_bgimage notEmptyOrNull]) {
        UIImage *bg = [UIImage imageNamed:_bgimage];
        [baseButton setBackgroundImage:bg forState:UIControlStateNormal];
        if (_frame.size.height<0.00001) {
            _frame.size.height = bg.size.height*_frame.size.width/bg.size.width;
            [baseButton setFrame:_frame];
        }else if(_frame.size.width<0.00001) {
            _frame.size.width = bg.size.width*_frame.size.height/bg.size.height;
            _frame.origin.x = (kScreenWidth-_frame.size.width)/2.0;
            [baseButton setFrame:_frame];
        }
    }
    if (sView) {
        [sView addSubview:baseButton];
    }
    
    return baseButton;// autorelease];
}
+(UIButton*)buttonWithFrame:(CGRect)_frame title:(NSString*)_title  image:(NSString*)_image bgimage:(NSString*)_bgimage supView:(UIView *)sView reuseId:(NSString*)reuseID{
    if ([sView getAddValueForKey:reuseID]) {
        UIButton *baseButton=[sView getAddValueForKey:reuseID];
        baseButton.frame=_frame;
        baseButton.titleLabel.font=fontTitle;
        if (_title) {
            [baseButton setTitle:_title forState:UIControlStateNormal];
            [baseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        if (_image && [_image notEmptyOrNull]) {
            [baseButton setImage:[UIImage imageNamed:_image] forState:UIControlStateNormal];
        }
        return baseButton;
    }else{
        UIButton *baseButton=[self buttonWithFrame:_frame title:_title image:_image bgimage:_bgimage supView:sView ];
        [sView setAddValue:baseButton forKey:reuseID];
        return baseButton;
    }
}


+(UIImageView*)imageviewWithFrame:(CGRect)_frame defaultimage:(NSString*)_image supView:(UIView *)sView
{
    //    return [self imageviewWithFrame:_frame defaultimage:_image stretchW:0 stretchH:0 supView:sView reuseId:nil];// autorelease];
    UIImageView*imageview=  [self imageviewWithFrame:_frame defaultimage:_image supView:sView reuseId:nil];
    if ([_image isEqualToString:@"photo"]||_image==nil) {
        imageview.backgroundColor=rgb(222, 222, 222);
    }
    
    return imageview ;
}
+(UIImageView*)imageviewWithFrame:(CGRect)_frame defaultimage:(NSString*)_image supView:(UIView *)sView  reuseId:(NSString*)reuseID
{
    if ([sView getAddValueForKey:reuseID]) {
        UIImageView*imageV= [sView getAddValueForKey:reuseID];
        imageV.frame=_frame;
        return imageV;
    }else{
        UIImageView*imageV= [self imageviewWithFrame:_frame defaultimage:_image stretchW:0 stretchH:0 supView:sView];
        if (sView &&reuseID) {
            [sView setAddValue:imageV forKey:reuseID];
        }
        return imageV;// autorelease];
    }
    
}


+(UIImageView*)imageviewWithFrame:(CGRect)_frame defaultimage:(NSString*)_image contentMode:(UIViewContentMode )cmode supView:(UIView *)sView{
    UIImageView *imageT=[self imageviewWithFrame:_frame defaultimage:_image stretchW:0 stretchH:0 supView:sView];
    [imageT setContentMode:cmode];
    return imageT;
}
//-1 if want stretch half of image.size
+(UIImageView*)imageviewWithFrame:(CGRect)_frame defaultimage:(NSString*)_image stretchW:(NSInteger)_w stretchH:(NSInteger)_h supView:(UIView *)sView
{
    UIImageView *imageview = nil;
    if(_image && [_image notEmptyOrNull]){
        if (_w&&_h) {
            UIImage *image = [UIImage imageNamed:_image];
            if (_w==-1) {
                _w = image.size.width/2;
            }
            if(_h==-1){
                _h = image.size.height/2;
            }
            imageview = [[UIImageView alloc] initWithImage:
                         [image stretchableImageWithLeftCapWidth:_w topCapHeight:_h]];
            imageview.contentMode=UIViewContentModeScaleToFill;
        }else{
            imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_image]];
            imageview.contentMode=UIViewContentModeScaleAspectFill;
        }
    }else{
        imageview=[[UIImageView alloc] init];
        imageview.contentMode=UIViewContentModeScaleAspectFill;
    }
    if (CGRectIsEmpty(_frame)) {
        [imageview setFrame:CGRectMake(_frame.origin.x,_frame.origin.y, imageview.image.size.width, imageview.image.size.height)];
    }else{
        [imageview setFrame:_frame];
    }
    imageview.clipsToBounds=YES;
    if (sView) {
        [sView addSubview:imageview];
    }
    if ([_image isEqualToString:@"photo"]) {
        imageview.backgroundColor=rgb(240, 240, 240);
    }
    
    return  imageview;// autorelease];
}



+(UIView *)lineViewWithFrame:(CGRect)_frame supView:(UIView *)sView
{
    UIView *viewLine=[[UIView alloc] initWithFrame:_frame];
    viewLine.backgroundColor=rgbLineColor;
    if (sView) {
        [sView addSubview:viewLine];
    }
    return viewLine;// autorelease];
}



+(UIView*)viewWithFrame:(CGRect)aframe backgroundcolor:(UIColor*)color superView:(UIView*)view{
    return [RHMethods viewWithFrame:aframe backgroundcolor:color superView:view reuseId:nil];
}

+(UIView*)viewWithFrame:(CGRect)aframe backgroundcolor:(UIColor*)color superView:(UIView*)view  reuseId:(NSString*)reuseID{
    if ([view getAddValueForKey:reuseID]) {
        UIView*lineView=[view getAddValueForKey:reuseID];
        lineView.frame=aframe;
        return lineView;
    }else{
        UIView*lineView=[[UIView alloc]initWithFrame:aframe];
        lineView.frame=aframe;
        lineView.backgroundColor=color;
        [view addSubview:lineView];
        if (reuseID) {
            [view setAddValue:lineView forKey:reuseID];
        }
        return lineView;
    }
}



+(UILabel*)lableX:(CGFloat)X Y:(CGFloat )Y W:(CGFloat)Width Height:(CGFloat)Height  font:(CGFloat)font  superview:(UIView*)superview withColor:coler text:(NSString*)text{
    return   [RHMethods lableX:X Y:Y W:Width Height:Height font:font superview:superview withColor:coler text:text reuseId:nil];
}

//根据reuseID 进行复用，缓存， 缓存到控件中，第二次设置的时候只设置frame 其他属性不进行设置
+(UILabel*)lableX:(CGFloat)X Y:(CGFloat )Y W:(CGFloat)Width Height:(CGFloat)Height  font:(CGFloat)font  superview:(UIView*)superview withColor:coler text:(NSString*)text reuseId:(NSString*)reuseID{
    if (coler==nil) {
        coler=RGBACOLOR(0x33, 0x33, 0x33, 1);
    }
    UILabel*lb=[RHMethods labelWithFrame:CGRectMake(X, Y, Width, Height) font:Font(font) color:coler text:text textAlignment:NSTextAlignmentLeft supView:superview reuseId:reuseID];
    if (Height==font&&Height!=0) {
        [lb setAddValue:@"1" forKey:@"lablezhuanhuan"];
        lb.frame=CGRectMake(X, Y-2, lb.frameWidth, Height+4);
    }
    return lb;
    
}

+(UILabel*)RlableRX:(CGFloat)RX Y:(CGFloat )Y W:(CGFloat)Width Height:(CGFloat)Height  font:(CGFloat)font  superview:(UIView*)superview withColor:coler text:(NSString*)text{
    return [RHMethods RlableRX:RX Y:Y W:Width Height:Height font:font superview:superview withColor:coler text:text reuseId:nil];
}
+(UILabel*)RlableRX:(CGFloat)RX Y:(CGFloat )Y W:(CGFloat)Width Height:(CGFloat)Height  font:(CGFloat)font  superview:(UIView*)superview withColor:coler text:(NSString*)text  reuseId:(NSString*)reuseID{
    if (coler==nil) {
        coler=RGBACOLOR(0x33, 0x33, 0x33, 1);
    }
    UILabel*lb=[RHMethods labelWithFrame:CGRectMake(superview.frameWidth-RX-Width, Y, Width, Height) font:Font(font) color:coler text:text textAlignment:NSTextAlignmentRight supView:superview reuseId:reuseID];
    if (Height==font&&Height!=0) {
        [lb setAddValue:@"1" forKey:@"lablezhuanhuan"];
        lb.frame=CGRectMake(superview.frameWidth-RX-Width, Y-2,  lb.frameWidth, Height+4);
    }
    if (!Width) {
        lb.frameX  =superview.frameWidth-RX-lb.frameWidth;
    }
    return lb;
    
    
}
+(UILabel*)ClableY:(CGFloat )Y W:(CGFloat)Width Height:(CGFloat)Height  font:(CGFloat)font  superview:(UIView*)superview withColor:coler text:(NSString*)text{
    return [RHMethods ClableY:Y W:Width Height:Height font:font superview:superview withColor:coler text:text reuseId:nil];
}
+(UILabel*)ClableY:(CGFloat )Y W:(CGFloat)Width Height:(CGFloat)Height  font:(CGFloat)font  superview:(UIView*)superview withColor:coler text:(NSString*)text   reuseId:(NSString*)reuseID{
    if (coler==nil) {
        coler=RGBACOLOR(0x33, 0x33, 0x33, 1);
    }
    
    
    UILabel*lb=[RHMethods labelWithFrame:CGRectMake((superview.frameWidth-Width)/2, Y, Width, Height) font:Font(font) color:coler text:text textAlignment:NSTextAlignmentCenter supView:superview reuseId:reuseID];
    if (Height==font&&Height!=0) {
        [lb setAddValue:@"1" forKey:@"lablezhuanhuan"];
        lb.frame=CGRectMake((superview.frameWidth-Width)/2, Y-2,  lb.frameWidth, Height+4);
    }
    if (!Width) {
        lb.centerX  =superview.frameWidth*0.5;
    }
    return lb;
}


+(WSSizeButton*)buttonWithframe:(CGRect)frame backgroundColor:(UIColor*)coler text:(NSString*)text font:(float)font textColor:(UIColor*)textcoler radius:(float)radius superview:(UIView*)superview{
    
    
    
    return [RHMethods buttonWithframe:frame backgroundColor:coler text:text font:font textColor:textcoler radius:radius superview:superview reuseId:nil];
}
+(WSSizeButton*)buttonWithframe:(CGRect)frame backgroundColor:(UIColor*)coler text:(NSString*)text font:(float)font textColor:(UIColor*)textcoler radius:(float)radius superview:(UIView*)superview reuseId:(NSString*)reuseID{
    
    if ([superview getAddValueForKey:reuseID]) {
        //        if (textcoler==nil) {
        //            textcoler=rgbTitleColor;
        //        }
        
        WSSizeButton*btn=[superview getAddValueForKey:reuseID];
        btn.frame=frame;
        return btn;
    }else{
        if (textcoler==nil) {
            textcoler=rgbTitleColor;
        }
        
        WSSizeButton*btn=[[WSSizeButton alloc]initWithFrame:frame];
        [btn setBackgroundColor:coler];
        [btn setTitle:text forState:UIControlStateNormal];
        
        [btn setTitleColor:textcoler forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:font];
        
        btn.layer.cornerRadius=radius;
        btn.layer.masksToBounds=YES;
        if (superview) {
            
            [superview addSubview:btn];
            if (reuseID) {
                [superview setAddValue:btn forKey:reuseID];
            }
        }
        
        return btn;
    }
}


+(void)showMyDemo{
    
    UIScrollView * sc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    [UTILITY.currentViewController.view addSubview:sc];
    //label
    UILabel * label = [RHMethods labelWithFrame:CGRectMake(0, 0, kScreenWidth/2, 50) font:Font(15) color:[UIColor blackColor] text:@"创建label方法"];
    label.backgroundColor = [UIColor  redColor];
    [sc addSubview:label];
    //带 subview  label
    [RHMethods labelWithFrame:CGRectMake(XW(label), Y(label), kScreenWidth/2, 50) font:Font(15) color:[UIColor blackColor] text:@"创建带supView的label方法" supView:sc];
    //button
    UIButton * button = [RHMethods buttonWithFrame:CGRectMake(0, YH(label), kScreenWidth/2, 50) title:@"创建button方法" image:@"" bgimage:@""];
    button.backgroundColor = [UIColor yellowColor];
    [sc addSubview:button];
    //uiimage
    UIImageView * imageview = [RHMethods imageviewWithFrame:CGRectMake(0, YH(button), 50, 50) defaultimage:@"NONetwork"];
    [sc addSubview:imageview];
    //线
    UIView * line = [RHMethods lineViewWithFrame:CGRectMake(0, YH(imageview), kScreenWidth, 1)];
    [sc addSubview:line];
    
    
    
}


+(WSBeBigImageView*)BIGimageviewWithFrame:(CGRect)_frame defaultimage:(NSString*)_image supView:(UIView *)sView{
    WSBeBigImageView *imageview = nil;
    
    NSInteger _w=0;
    NSInteger _h=0;
    if(_image && [_image notEmptyOrNull]){
        if (_w&&_h) {
            UIImage *image = [UIImage imageNamed:_image];
            if (_w==-1) {
                _w = image.size.width/2;
            }
            if(_h==-1){
                _h = image.size.height/2;
            }
            imageview = [[WSBeBigImageView alloc] initWithImage:
                         [image stretchableImageWithLeftCapWidth:_w topCapHeight:_h]];
            imageview.contentMode=UIViewContentModeScaleToFill;
        }else{
            imageview = [[WSBeBigImageView alloc] initWithImage:[UIImage imageNamed:_image]];
            imageview.contentMode=UIViewContentModeScaleAspectFill;
        }
    }else{
        imageview = [[WSBeBigImageView alloc] init];
        imageview.contentMode=UIViewContentModeScaleAspectFill;
    }
    if (CGRectIsEmpty(_frame)) {
        [imageview setFrame:CGRectMake(_frame.origin.x,_frame.origin.y, imageview.image.size.width, imageview.image.size.height)];
    }else{
        [imageview setFrame:_frame];
    }
    imageview.clipsToBounds=YES;
    if (sView) {
        [sView addSubview:imageview];
    }
    
    return  imageview;// autorelease];
    
}

@end
