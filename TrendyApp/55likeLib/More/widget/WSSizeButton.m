//
//  WSSizeButton.m
//  HairDressing
//
//  Created by 55like on 22/03/2017.
//  Copyright © 2017 55like. All rights reserved.
//

#import "WSSizeButton.h"



@interface WSSizeButton ()



-(void)setImageviewsize:(ButtonSize)imageviewsize;

-(void)setLableviewSize:(ButtonSize)lableviewSize;


@end

@implementation WSSizeButton

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    
    
    //    return [super titleRectForContentRect:contentRect];
    
    if (_lableviewSize!=nil) {
        return _lableviewSize(self);
    }else{
        
        return [super titleRectForContentRect:contentRect];
    }
    
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    
    
    if (_imageviewsize!=nil) {
        return _imageviewsize(self);
    }else{
        
        return [super imageRectForContentRect:contentRect];
    }
}



-(void)setImageviewColor:(UIColor *)color forState:(UIControlState)state{
    
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    [self setImage:theImage forState:state];
    
    //    return theImage;
    
    
}
-(void)setBackGroundImageviewColor:(UIColor *)color forState:(UIControlState)state{
    
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self setBackgroundImage:theImage forState:state];
    
}

-(void)setImageStr:(NSString*)imageStr SelectImageStr:(NSString*)seletImagStr{
    if (imageStr) {
        [self setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    }
    if (seletImagStr) {
        [self setImage:[UIImage imageNamed:seletImagStr] forState:UIControlStateSelected];
    }
    
}

-(void)setBtnLableFrame:(CGRect)btnLableFrame{
    _btnLableFrame=btnLableFrame;
    
    __weak __typeof(self) weakSelf = self;
    if (self.lableviewSize==nil) {
        
        [ self setLableviewSize:^CGRect(WSSizeButton *btn) {
            return weakSelf.btnLableFrame;
        }];
    }
    [self layoutSubviews];
    
}


-(void)setBtnImageViewFrame:(CGRect)btnImageViewFrame{
    _btnImageViewFrame=btnImageViewFrame;
    
    __weak __typeof(self) weakSelf = self;
    
    if (self.imageviewsize==nil) {
        [self setImageviewsize:^CGRect(WSSizeButton *btn) {
            
            return weakSelf.btnImageViewFrame;
            
        }];
    }
    [self layoutSubviews];
    
}
+(void)showMyDemo{
    WSSizeButton*btn=[[WSSizeButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    
    [btn setImageviewColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.textAlignment=NSTextAlignmentCenter;
    btn.layer.borderColor=[[UIColor blackColor] CGColor];
    btn.layer.borderWidth=0.5;
    
    [btn setBtnLableFrame:CGRectMake(0, 80, btn.frameWidth, 20)];
    [btn setBtnImageViewFrame:CGRectMake(10, 10, btn.frameWidth-20, 80-20)];
    
    [UTILITY.currentViewController.view addSubview:btn];
    
    
}
//- (void)setFrameX:(CGFloat)x
//{
//    CGRect frame = self.frame;
//    frame.origin.x = x;
//    self.frame = frame;
//}

-(void)setLbframeX:(CGFloat)lbframeX{
    _btnLableFrame.origin.x=lbframeX;
    [self setBtnLableFrame:_btnLableFrame];
}
-(CGFloat)lbframeX{
    return _btnLableFrame.origin.x;
}
-(void)setLbframeY:(CGFloat)lbframeY{
    _btnLableFrame.origin.y=lbframeY;
    [self setBtnLableFrame:_btnLableFrame];
}
-(CGFloat)lbframeY{
    return _btnLableFrame.origin.y;
}
-(void)setLbframeWidth:(CGFloat)lbframeWidth{
    _btnLableFrame.size.width=lbframeWidth;
    [self setBtnLableFrame:_btnLableFrame];
}
-(CGFloat)lbframeWidth{
    return _btnLableFrame.size.width;
}
-(void)setLbframeHeight:(CGFloat)lbframeHeight{
    _btnLableFrame.size.height=lbframeHeight;
    [self setBtnLableFrame:_btnLableFrame];
}
-(CGFloat)lbframeHeight{
    return _btnLableFrame.size.height;
}
-(void)setLbframeSize:(CGSize)lbframeSize{
    _btnLableFrame.size=lbframeSize;
    [self setBtnLableFrame:_btnLableFrame];
}
-(CGSize)lbframeSize{
    return _btnLableFrame.size;
}
-(void)setLbframeOrigin:(CGPoint)lbframeOrigin{
    _btnLableFrame.origin=lbframeOrigin;
}
-(CGPoint)lbframeOrigin{
    return _btnLableFrame.origin;
}

-(void)setLbframeXW:(CGFloat)lbframeXW{
    _btnLableFrame.origin.x=lbframeXW-_btnLableFrame.size.width;
    [self setBtnLableFrame:_btnLableFrame];
}
-(CGFloat)lbframeXW{
    return _btnLableFrame.origin.x+_btnLableFrame.size.width;
}

-(void)setLbframeYH:(CGFloat)lbframeYH{
    _btnLableFrame.origin.y=lbframeYH-_btnLableFrame.size.height;
    [self setBtnLableFrame:_btnLableFrame];
}
-(CGFloat)lbframeYH{
    return   _btnLableFrame.origin.y+_btnLableFrame.size.height;
}
-(void)setLbframeRX:(CGFloat)lbframeRX{
    _btnLableFrame.origin.x=self.frameWidth-lbframeRX-_btnLableFrame.size.width;
    [self setBtnLableFrame:_btnLableFrame];
}
-(CGFloat)lbframeRX{
    return   self.frameWidth- _btnLableFrame.origin.x-_btnLableFrame.size.width;
}
-(void)setLbframeBY:(CGFloat)lbframeBY{
    _btnLableFrame.origin.y=self.frameHeight-lbframeBY-_btnLableFrame.size.height;
    [self setBtnLableFrame:_btnLableFrame];
}
-(CGFloat)lbframeBY{
    return self.frameHeight-_btnLableFrame.origin.y-_btnLableFrame.size.height;
}
-(void)lbbeCenter{
    _btnLableFrame.origin.x=(self.frameWidth-_btnLableFrame.size.width)*0.5;
    _btnLableFrame.origin.y=(self.frameHeight-_btnLableFrame.size.height)*0.5;
    [self setBtnLableFrame:_btnLableFrame];
}
-(void)lbbeCX{
    
    _btnLableFrame.origin.x=(self.frameWidth-_btnLableFrame.size.width)*0.5;
    [self setBtnLableFrame:_btnLableFrame];
}
-(void)lbbeCY{
    
    _btnLableFrame.origin.y=(self.frameHeight-_btnLableFrame.size.height)*0.5;
    [self setBtnLableFrame:_btnLableFrame];
}
-(void)lbbeRound{
    self.titleLabel.layer.cornerRadius=_btnLableFrame.size.height;
}

-(void)setImgframeX:(CGFloat)imgframeX{
    _btnImageViewFrame.origin.x=imgframeX;
    [self setBtnImageViewFrame:_btnImageViewFrame];
}
-(CGFloat)imgframeX{
    return _btnImageViewFrame.origin.x;
}
-(void)setImgframeY:(CGFloat)imgframeY{
    _btnImageViewFrame.origin.y=imgframeY;
    [self setBtnImageViewFrame:_btnImageViewFrame];
}
-(CGFloat)imgframeY{
    return _btnImageViewFrame.origin.y;
}
-(void)setImgframeWidth:(CGFloat)imgframeWidth{
    _btnImageViewFrame.size.width=imgframeWidth;
    [self setBtnImageViewFrame:_btnImageViewFrame];
}
-(CGFloat)imgframeWidth{
    return _btnImageViewFrame.size.width;
}
-(void)setImgframeHeight:(CGFloat)imgframeHeight{
    _btnImageViewFrame.size.height=imgframeHeight;
    [self setBtnImageViewFrame:_btnImageViewFrame];
}
-(CGFloat)imgframeHeight{
    return _btnImageViewFrame.size.height;
}
-(void)setImgframeSize:(CGSize)imgframeSize{
    _btnImageViewFrame.size=imgframeSize;
    [self setBtnImageViewFrame:_btnImageViewFrame];
}
-(CGSize)imgframeSize{
    return _btnImageViewFrame.size;
}
-(void)setImgframeOrigin:(CGPoint)imgframeOrigin{
    _btnImageViewFrame.origin=imgframeOrigin;
}
-(CGPoint)imgframeOrigin{
    return _btnImageViewFrame.origin;
}

-(void)setImgframeXW:(CGFloat)imgframeXW{
    _btnImageViewFrame.origin.x=imgframeXW-_btnImageViewFrame.size.width;
    [self setBtnImageViewFrame:_btnImageViewFrame];
}
-(CGFloat)imgframeXW{
    return _btnImageViewFrame.origin.x+_btnImageViewFrame.size.width;
}

-(void)setImgframeYH:(CGFloat)imgframeYH{
    _btnImageViewFrame.origin.y=imgframeYH-_btnImageViewFrame.size.height;
    [self setBtnImageViewFrame:_btnImageViewFrame];
}
-(CGFloat)imgframeYH{
    return   _btnImageViewFrame.origin.y+_btnImageViewFrame.size.height;
}
-(void)setImgframeRX:(CGFloat)imgframeRX{
    _btnImageViewFrame.origin.x=self.frameWidth-imgframeRX-_btnImageViewFrame.size.width;
    [self setBtnImageViewFrame:_btnImageViewFrame];
}
-(CGFloat)imgframeRX{
    return   self.frameWidth- _btnImageViewFrame.origin.x-_btnImageViewFrame.size.width;
}
-(void)setImgframeBY:(CGFloat)imgframeBY{
    _btnImageViewFrame.origin.y=self.frameHeight-imgframeBY-_btnImageViewFrame.size.height;
    [self setBtnImageViewFrame:_btnImageViewFrame];
}
-(CGFloat)imgframeBY{
    return self.frameHeight-_btnImageViewFrame.origin.y-_btnImageViewFrame.size.height;
}
-(void)imgbeCenter{
    _btnImageViewFrame.origin.x=(self.frameWidth-_btnImageViewFrame.size.width)*0.5;
    _btnImageViewFrame.origin.y=(self.frameHeight-_btnImageViewFrame.size.height)*0.5;
    [self setBtnImageViewFrame:_btnImageViewFrame];
}
-(void)imgbeCX{
    
    _btnImageViewFrame.origin.x=(self.frameWidth-_btnImageViewFrame.size.width)*0.5;
    [self setBtnImageViewFrame:_btnImageViewFrame];
}
-(void)imgbeCY{
    
    _btnImageViewFrame.origin.y=(self.frameHeight-_btnImageViewFrame.size.height)*0.5;
    [self setBtnImageViewFrame:_btnImageViewFrame];
}
-(void)imgbeRound{
    self.imageView.layer.cornerRadius=_btnImageViewFrame.size.height;
}

//- (void)setFrameY:(CGFloat)y
//{
//    CGRect frame = self.frame;
//
//    if ([self isKindOfClass:[UILabel class]]&&[self getAddValueForKey:@"lablezhuanhuan"]) {
//        y=y-2;
//    }
//
//
//    frame.origin.y = y;
//    self.frame = frame;
//}

@end

