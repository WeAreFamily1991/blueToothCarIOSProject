//
//  CustomerServiceCenterCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/3/4.
//  Copyright © 2019 55like. All rights reserved.
//

#import "CustomerServiceCenterCellView.h"
#import "SelectWebUrlViewController.h"

@implementation CustomerServiceCenterCellView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
        self.frameHeight=55;
    }
    if (self.isfirstInit) {
        self.backgroundColor=rgbwhiteColor;
        UIImageView*imgVIcon=[RHMethods imageviewWithFrame:CGRectMake(15, 17.5, 20, 20) defaultimage:@"questioni1" supView:self];
        UILabel*lbTitle=[RHMethods lableX:41.5 Y:19 W:self.frameWidth-41.5-46.1 Height:0 font:16 superview:self withColor:rgb(51, 51, 51) text:@"在線購買已經顯示成功，為什麼我的訂單顯示還是待確認"];
        self.frameHeight=lbTitle.frameYH+20;
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(15, 0, self.frameWidth-15, 0.5) backgroundcolor:rgbLineColor superView:self];
        viewLine.frameBY=0;
        viewLine.autoresizingMask=UIViewAutoresizingFlexibleTopMargin;
        UIImageView*imgVRow=[RHMethods imageviewWithFrame:CGRectMake(0, 0, 6, 12) defaultimage:@"arrowr2" supView:self];
        imgVRow.frameRX=15;
        imgVRow.centerY=imgVIcon.centerY;
        
        __weak typeof(self) weakSelf=self;
        [self setAddUpdataBlock:^(id data, id weakme) {
            lbTitle.text=[data ojsk:@"title"];
            lbTitle.frameWidth=W(weakSelf)-90;
            [lbTitle changeLineSpaceForLabelWithSpace:4];
            if (H(lbTitle)<20) {
                lbTitle.frameHeight=20;
            }
            weakSelf.frameHeight=YH(lbTitle)+15;
        }];
        [self addViewClickBlock:^(UIView *view) {
            krequestParam
            [dictparam setObject:[weakSelf.data ojsk:@"id"] forKey:@"id"];
            [dictparam setObject:@"app" forKey:@"apptype"];
            [dictparam removeObjectForKey:@"uid"];
            [dictparam removeObjectForKey:@"token"];
            
            [UTILITY.currentViewController pushController:[SelectWebUrlViewController class] withInfo:nil withTitle:@"" withOther:[NSString stringWithFormat:@"http://h5.trendycarshare.jp/home/question/details%@",dictparam.wgetParamStr]];
        }];
    }
    
}
-(void)bendData:(id)data withType:(NSString *)type{
    [super bendData:data withType:type];
    [self upDataMeWithData:data];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
