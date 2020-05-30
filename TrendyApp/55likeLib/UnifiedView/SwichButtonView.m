//
//  SwichButtonView.m
//  TrendyApp
//
//  Created by 55like on 2019/3/21.
//  Copyright © 2019 55like. All rights reserved.
//

#import "SwichButtonView.h"

@implementation SwichButtonView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        float mywidth =  [kS(@"rentCarSwith", @"off") widthWithFont:12]+3;
        mywidth =  mywidth >[kS(@"rentCarSwith", @"on") widthWithFont:12]+3?mywidth:[kS(@"rentCarSwith", @"on") widthWithFont:12]+3;
        
        self.frameWidth= mywidth*2 > 70 ? mywidth*2 : 70;
        self.frameHeight=25;
        self.backgroundColor=RGBACOLOR(14,112,161,0.11);
        [self beRound];
        UIView *viewBG=[RHMethods viewWithFrame:CGRectMake(0, 0, W(self)/2, H(self)) backgroundcolor:rgbpublicColor superView:self];
        [viewBG beRound];
        
//        UILabel *lblLeft=[RHMethods labelWithFrame:CGRectMake(0, (H(self)-20)/2, W(viewBG), 20) font:fontSmallTxtContent color:rgbwhiteColor text:kS(@"rentCarSwith", @"off") textAlignment:NSTextAlignmentCenter supView:self];
//        UILabel *lblRight=[RHMethods labelWithFrame:CGRectMake(XW(lblLeft), (H(self)-20)/2, W(viewBG), 20) font:fontSmallTxtContent color:rgbpublicColor text:kS(@"rentCarSwith", @"on") textAlignment:NSTextAlignmentCenter supView:self];
        UILabel *lblLeft=[RHMethods labelWithFrame:CGRectMake(0, (H(self)-20)/2, W(viewBG), 20) font:fontSmallTxtContent color:rgbwhiteColor text:kS(@"rentCarSwith", @"off") textAlignment:NSTextAlignmentCenter supView:self];
        UILabel *lblRight=[RHMethods labelWithFrame:CGRectMake(XW(lblLeft), (H(self)-20)/2, W(viewBG), 20) font:fontSmallTxtContent color:rgbpublicColor text:kS(@"rentCarSwith", @"on") textAlignment:NSTextAlignmentCenter supView:self];
        __weak typeof(self) weakSelf=self;
        [self setAddUpdataBlock:^(id data, id weakme) {
            if (weakSelf.isOn) {
                [UIView animateWithDuration:0.3 animations:^{
                    viewBG.frameX=W(weakSelf)/2;
                }];
                lblLeft.textColor=rgbpublicColor;
                lblRight.textColor=rgbwhiteColor;
            }else{
                [UIView animateWithDuration:0.3 animations:^{
                    viewBG.frameX=0;
                }];
                
                lblLeft.textColor=rgbwhiteColor;
                lblRight.textColor=rgbpublicColor;
            }
        }];
        [self addViewClickBlock:^(UIView *view) {
            weakSelf.isOn=!weakSelf.isOn;
        }];
    }
    return self;
}
- (void)setIsOn:(BOOL)isOn{
    if (_isOn!=isOn) {
        _isOn=isOn;
        [self upDataMe];
        self.changeBlock?self.changeBlock(nil, 200, nil):nil;
    }
}
-(void)swichChangeValue:(AllcallBlock)aBlock{
    self.changeBlock=aBlock;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
