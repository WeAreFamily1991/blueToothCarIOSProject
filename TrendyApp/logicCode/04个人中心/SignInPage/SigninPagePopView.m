//
//  SigninPagePopView.m
//  TrendyApp
//
//  Created by 55like on 2019/3/19.
//  Copyright © 2019 55like. All rights reserved.
//

#import "SigninPagePopView.h"

@implementation SigninPagePopView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
        self.frameHeight=kScreenHeight;
    }
    if (self.isfirstInit) {
        self.backgroundColor=RGBACOLOR(0, 0, 0, 0.3);
        UIImageView*imgVBg=[RHMethods imageviewWithFrame:CGRectMake(0, 0, 301, 247) defaultimage:@"signcomplete" supView:self];
        [imgVBg beCenter];
        imgVBg.frameY=imgVBg.frameY-50;
        UILabel*lbContentTitle=[RHMethods ClableY:155 W:imgVBg.frameWidth Height:16 font:16 superview:imgVBg withColor:rgb(102, 102, 102) text:kS(@"SignInStr", @"CongratulationsSuccess")];
        UILabel*lbJfen=[RHMethods ClableY:lbContentTitle.frameYH+16 W:lbContentTitle.frameWidth Height:20 font:20 superview:imgVBg withColor:rgb(255,166,0) text:@"+10 積分"];
        WSSizeButton*viewBtnClose=[WSSizeButton viewWithFrame:CGRectMake(0, imgVBg.frameYH+30, 37, 37) backgroundcolor:nil superView:self];
        [viewBtnClose setBackgroundImage:[UIImage imageNamed:@"closei4"] forState:UIControlStateNormal];
        [viewBtnClose beCX];
          __weak __typeof(self) weakSelf = self;
        [viewBtnClose addViewClickBlock:^(UIView *view) {
            weakSelf.hidden=YES;
        }];
        [self setAddUpdataBlock:^(id data, id weakme) {
            lbJfen.text=[NSString stringWithFormat:@"+%@ %@",[data ojsk:@"sign_point"],kS(@"SignInStr", @"Integral")];
        }];
        
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
