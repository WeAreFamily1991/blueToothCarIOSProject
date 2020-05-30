//
//  TopToggletabView.m
//  XinKaiFa55like
//
//  Created by junseek on 2017/3/24.
//  Copyright © 2017年 55like lj. All rights reserved.
//

#import "TopToggletabView.h"

@interface TopToggletabView(){
    NSArray *arrayTempTitles;
    NSInteger selectTempIndex;
}

@property(nonatomic,strong)UIScrollView *scrollBG;
@property(nonatomic,strong)UIView *viewLine;
@end

@implementation TopToggletabView
-(instancetype)initWithFrame:(CGRect)frame{
    self= [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        self.scrollBG=[[UIScrollView alloc] initWithFrame:CGRectMakeXY(0, 0, frame.size)];
        self.scrollBG.showsVerticalScrollIndicator = FALSE;
        self.scrollBG.showsHorizontalScrollIndicator = FALSE;
        [self addSubview:self.scrollBG];
        _selectTitleColor=rgbpublicColor;
        _defaultTitleColor=RGBCOLOR(102, 0, 1);
    }
    return self;
}


-(void)setTiltelArray:(NSArray*)titleArray toggleTab:(TopToggletabBlock)aToggleTab{
    [self setTiltelArray:titleArray toggleTab:aToggleTab selectIndex:0];
}
-(void)setTiltelArray:(NSArray*)titleArray toggleTab:(TopToggletabBlock)aToggleTab selectIndex:(NSInteger)sIndex{
    self.toggleTab=aToggleTab;
    if ([arrayTempTitles isEqualToArray:titleArray]) {
        UIButton *btn;
        for (UIView *view in self.scrollBG.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton *btnT=(UIButton *)view;
                if (btnT.tag==sIndex+100) {
                    btnT.selected=YES;
                    btn=btnT;
                }else{
                    btnT.selected=NO;
                }
                
            }
        }
        if (btn) {
            btn.selected=YES;
            self.viewLine.hidden=NO;
            [UIView animateWithDuration:0.3 animations:^{
                //                self.viewLine.frameX=btn.frameX;
                self.viewLine.centerX=btn.centerX;
            } completion:^(BOOL finished) {
                
            }];
            self.toggleTab?self.toggleTab(arrayTempTitles[btn.tag-100]):nil;
        }else  if (sIndex==-1) {
            self.toggleTab?self.toggleTab(@{}):nil;
            self.viewLine.hidden=YES;
        }
        return;
    }
    arrayTempTitles=titleArray;
    UIView *lineV=[self getAddValueForKey:@"lineV"];
    if (!lineV) {
        lineV=[RHMethods lineViewWithFrame:CGRectMake(0, H(self)-0.5, W(self),0.5) supView:self];
        [self setAddValue:lineV forKey:@"lineV"];
    }
    lineV.hidden=_boolHiddenLine;
    
    float fw=50;//W(self)/[titleArray count];
    if (_toggleTabType==TopToggletabTypeShowAll) {
        fw=W(self)/[titleArray count];
    }
    if (!self.viewLine) {
        self.viewLine=[RHMethods lineViewWithFrame:CGRectMake(0, H(self)-3, 16, 2)];
        [self.scrollBG addSubview:self.viewLine];
    }
    [self.viewLine setBackgroundColor:_selectTitleColor];
    
    for (UIView *view in self.scrollBG.subviews) {
        //        [view removeFromSuperview];
        view.hidden=YES;
    }
    float fx=0;
    for (int i=0; i<titleArray.count; i++) {
        NSDictionary *dicT=titleArray[i];
        UIButton*btn=[self getAddValueForKey:[NSString stringWithFormat:@"btn__%d",i]];
        if (!btn) {
            btn=[[UIButton alloc] initWithFrame:CGRectMake(fx, 0, fw, H(self))];
            btn.titleLabel.font=Font(15);
            [btn addTarget:self action:@selector(toggleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollBG addSubview:btn];
            [self setAddValue:btn  forKey:[NSString stringWithFormat:@"btn__%d",i]];
        }
        btn.frame=CGRectMake(fx, 0, fw, H(self));
        btn.hidden=NO;
        [btn setTitle:[[dicT valueForJSONStrKey:@"title"] notEmptyOrNull]?[dicT valueForJSONStrKey:@"title"]:[dicT valueForJSONStrKey:@"name"] forState:UIControlStateNormal];
        if (_toggleTabType!=TopToggletabTypeShowAll) {
            float ftempw=[btn.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, 20)].width+30;
            if (fw<ftempw) {
                btn.frameWidth=ftempw;
            }
        }
        fx+=W(btn);
        btn.tag=i+100;
        [btn setTitleColor:_defaultTitleColor forState:UIControlStateNormal];
        [btn setTitleColor:_selectTitleColor forState:UIControlStateSelected];
        btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        if (i==sIndex) {
            [self toggleButtonClicked:btn];
        }
    }
    [self.scrollBG setContentSize:CGSizeMake(fx, H(self.scrollBG))];
    if (sIndex==-1) {
        self.toggleTab?self.toggleTab(@{}):nil;
        self.viewLine.hidden=YES;
    }
}
///更改选中下标
-(void)updateSelectIndex:(NSInteger)sIndex{
    if (sIndex<0) {
        sIndex=0;
    }else if (sIndex>=[arrayTempTitles count]){
        sIndex=0;
    }
    if (selectTempIndex==sIndex) {
        return;
    }
    UIButton *btn=(UIButton *)[self.scrollBG viewWithTag:sIndex+100];
    [self toggleButtonClicked:btn];
}
#pragma mark button
-(void)toggleButtonClicked:(UIButton *)btn{
    for (UIView *view in self.scrollBG.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btnT=(UIButton *)view;
            btnT.selected=NO;
        }
    }
    btn.selected=YES;
    selectTempIndex=btn.tag-100;
    //    self.viewLine.frameWidth=16;//W(btn);
    
    float fw=[btn.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, 20)].width;
    self.viewLine.frameWidth=fw+10;
    self.viewLine.hidden=NO;
    [UIView animateWithDuration:0.3 animations:^{
        //        self.viewLine.frameX=btn.frameX;
        self.viewLine.centerX=btn.centerX;
    } completion:^(BOOL finished) {
        float ftemp_off_x=btn.center.x-W(self.scrollBG)/2;
        if (self.scrollBG.contentSize.width<W(self.scrollBG)) {
            //不做任何处理
            ftemp_off_x=0;
        }else{
            //在左
            ftemp_off_x=ftemp_off_x<0?0:ftemp_off_x;
            //在右边
            ftemp_off_x=ftemp_off_x>(self.scrollBG.contentSize.width-W(self.scrollBG))?self.scrollBG.contentSize.width-W(self.scrollBG):ftemp_off_x;
        }
        [self.scrollBG setContentOffset:CGPointMake(ftemp_off_x, 0)];
    }];
    self.toggleTab?self.toggleTab(arrayTempTitles[btn.tag-100]):nil;
    
}


-(void)dealloc{
    self.toggleTab=nil;
}


@end


