//
//  GSettingCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/3/1.
//  Copyright © 2019 55like. All rights reserved.
//

#import "GSettingCellView.h"

@implementation GSettingCellView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
        self.frameHeight=55;
    }
    if (self.isfirstInit) {
        self.backgroundColor=rgbwhiteColor;
        UILabel*lbNameLabel=[RHMethods lableX:15 Y:0 W:kScreenWidth*0.5 Height:self.frameHeight font:16 superview:self withColor:rgb(51, 51, 51) text:@"切换语言"];
        
        UIImageView*imgVRow=[RHMethods imageviewWithFrame:CGRectMake(0, 20, 8, 15) defaultimage:@"arrowr2" supView:self];
        imgVRow.frameRX=15;
        [imgVRow beCY];
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(15, 0, self.frameWidth-15, 1) backgroundcolor:rgb(238, 238, 238) superView:self];
        viewLine.frameBY=0;
        
         UILabel*lbDes=[RHMethods RlableRX:33 Y:0 W:kScreenWidth*0.4 Height:self.frameHeight font:14 superview:self withColor:rgb(153, 153, 153) text:@"6.6M"];
        lbDes.text=@"";
        [self setAddUpdataBlock:^(id data, id weakme) {
            lbNameLabel.text=[data ojsk:@"name"];
            lbDes.text=[data ojsk:@"describe"];
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
