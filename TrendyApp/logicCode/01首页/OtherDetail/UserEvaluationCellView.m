//
//  UserEvaluationCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/3/5.
//  Copyright © 2019 55like. All rights reserved.
//

#import "UserEvaluationCellView.h"
#import "XHStarRateView.h"
#import "XHImageUrlViewer.h"

@implementation UserEvaluationCellView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
        self.frameHeight=55;
    }
    if (self.isfirstInit) {
        self.backgroundColor=rgb(255, 255, 255);
        UIImageView*imgVIcon=[RHMethods imageviewWithFrame:CGRectMake(15, 20, 40, 40) defaultimage:nil supView:self];
        [imgVIcon beRound];
        UILabel*lbName=[RHMethods lableX:imgVIcon.frameXW+10 Y:22 W:0 Height:15 font:15 superview:self withColor:rgb(0, 0, 0) text:@"Trengy官方客服"];
        XHStarRateView*viewStar=[XHStarRateView viewWithFrame:CGRectMake(lbName.frameXW+10, 0, 67, 10) backgroundcolor:nil superView:self];
        viewStar.centerY=lbName.centerY;
        viewStar.userInteractionEnabled=NO;
        
        UILabel*lbTime=[RHMethods lableX:lbName.frameX Y:lbName.frameYH+4.5+3 W:kScreenWidth-imgVIcon.frameXW-17-15 Height:13 font:13 superview:self withColor:rgb(153, 153, 153) text:@"2018.09.10 08:30"];
        UILabel*lbDescribe=[RHMethods lableX:15 Y:imgVIcon.frameYH+15 W:kScreenWidth-30 Height:0 font:14 superview:self withColor:rgb(102, 102, 102) text:@"車子準時歸還，歸還後車子已然乾淨整潔車子準時歸還，歸還後車子已然乾淨整潔車子準時歸還，歸還後車子已然乾淨整潔車子準時歸還，歸還後車子已然乾淨整潔"];
        
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(15, 0, kScreenWidth-30, 0.5) backgroundcolor:rgbLineColor superView:self];
        viewLine.autoresizingMask=UIViewAutoresizingFlexibleTopMargin;
        viewLine.frameBY=0;
        
        __weak typeof(self) weakSelf=self;
        [self setAddUpdataBlock:^(id data, id weakme) {
            [imgVIcon imageWithURL:[[data ojk:@"userinfo"] ojsk:@"path"]];
            lbName.text=[[data ojk:@"userinfo"] ojsk:@"nickname"];
            [lbName changeLabelWidth];
            if (XW(lbName)>kScreenWidth-W(viewStar)-25) {
                lbName.frameWidth=kScreenWidth-W(viewStar)-35-XW(imgVIcon);
            }
            viewStar.frameX=XW(lbName)+10;
            [viewStar setCurrentScore:[[data ojk:@"car_point"] floatValue]];
            lbTime.text=[[data ojk:@"userinfo"] ojsk:@"ctime_str"];
            lbDescribe.text=[data ojsk:@"content"];
            [lbDescribe setAllTextLineSpacing:4];
            [lbDescribe changeLabelHeight];
            
            NSArray*arrayImageArray=[data ojk:@"pics"];
            for (UIView *v in [weakSelf subviews]) {
                if (v.tag>=1000) {
                    v.hidden=YES;
                }
            }
            float width=(kScreenWidth-30-6)/3.0;
            float fy=lbDescribe.frameYH+15;
            float fx=15;
            for (int i=0; i<arrayImageArray.count; i++) {
                if (i%3==0 && i!=0) {
                    fx=15;
                    fy+=width+3;
                }
                UIImageView *imgVPic=[RHMethods imageviewWithFrame:CGRectMake(fx,fy , width, width) defaultimage:nil supView:weakSelf reuseId:[NSString stringWithFormat:@"imgVPic%d",i]];
                imgVPic.tag=1000+i;
                imgVPic.hidden=NO;
                fx+=(width+3);
                [imgVPic addViewTarget:weakme select:@selector(showImages:)];
                [imgVPic imageWithURL:arrayImageArray[i]];
            }
            if (arrayImageArray.count>0) {
                fy+=width+20;
            }
            weakSelf.frameHeight=fy;
        }];
        
//        self.frameHeight=viewCarInfo.frameYH+20;
    }
    
    
    
}

-(void)showImages:(UIView *)view{
    NSMutableArray *array=[[NSMutableArray alloc] init];
    for (NSString *strUrl in [self.data ojk:@"pics"]) {
        [array addObject:@{@"url":strUrl,}];
    }
    XHImageUrlViewer *xhView=[self getAddValueForKey:@"ImageUrlViewer"];
    if (!xhView) {
        xhView=[[XHImageUrlViewer alloc] init];
        [self setAddValue:xhView forKey:@"ImageUrlViewer"];
    }
    [xhView showWithImageDatas:array selectedIndex:view.tag-1000];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
