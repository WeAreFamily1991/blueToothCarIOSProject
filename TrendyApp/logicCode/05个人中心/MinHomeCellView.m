//
//  MinHomeCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/2/20.
//  Copyright © 2019 55like. All rights reserved. 
//

#import "MinHomeCellView.h"

@implementation MinHomeCellView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
        self.frameHeight=56;
    }
    if (self.isfirstInit) {
        self.backgroundColor=rgb(255, 255, 255);
        UIImageView*imgVIcon=[RHMethods imageviewWithFrame:CGRectMake(5, 0, 15+20+15, self.frameHeight) defaultimage:@"" supView:self];
        imgVIcon.contentMode=UIViewContentModeCenter;
        UILabel*lbName=[RHMethods lableX:imgVIcon.frameXW Y:0 W:kScreenWidth*0.60 Height:self.frameHeight font:16 superview:self withColor:rgb(51, 51, 51) text:@"名称"];
        UIImageView*imgVRow=[RHMethods imageviewWithFrame:CGRectMake(0, 20, 8, 15) defaultimage:@"arrowr2" supView:self];
        imgVRow.frameRX=15;
//        UIView*viewLine=[UIView viewWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>) backgroundcolor:<#(UIColor *)#> superView:(UIView *)];
        
        [self setAddUpdataBlock:^(id data, id weakme) {
            imgVIcon.image=[UIImage imageNamed:[data ojsk:@"icon"]];
            lbName.text=[data ojsk:@"title"];
            
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
