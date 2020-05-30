//
//  ApplicationForReservationCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/3/5.
//  Copyright © 2019 55like. All rights reserved.
//

#import "ApplicationForReservationCellView.h"

@implementation ApplicationForReservationCellView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
        self.frameHeight=110;
    }
    if (self.isfirstInit) {
        UIImageView*imgVPhoto=[RHMethods imageviewWithFrame:CGRectMake(15, 20, 94, 70) defaultimage:@"photo" supView:self];
        UILabel*lbName=[RHMethods lableX:imgVPhoto.frameXW+10 Y:30 W:0 Height:16 font:15 superview:self withColor:rgb(51, 51, 51) text:@"瑪莎拉蒂 Levante 进口"];
        UILabel*lbLable=[RHMethods lableX:lbName.frameXW+5 Y:0 W:0 Height:17 font:10 superview:self withColor:rgb(244,58,58) text:@"平台自营"];
        lbLable.frameWidth=lbLable.frameWidth+8;
        lbLable.textAlignment=NSTextAlignmentCenter;
        lbLable.backgroundColor=RGBACOLOR(244,58,58, 0.1);
        lbLable.centerY=lbName.centerY;
        UILabel*lbOtherInfo=[RHMethods lableX:lbName.frameX Y:lbName.frameYH+13 W:self.frameWidth-lbName.frameX-15 Height:12 font:12 superview:self withColor:rgb(102, 102, 102) text:@"三廂 | 1.5自助 | 乘坐5人"];
//
        [self setAddUpdataBlock:^(id data, id weakme) {
            [imgVPhoto imageWithURL:[data ojsk:@"path"]];
            lbLable.text=[data ojsk:@"type_str"];
            [lbLable changeLabelWidth];
            lbLable.frameWidth=lbLable.frameWidth+8;
            lbName.text=[data ojsk:@"title"];
            lbOtherInfo.text=[data ojsk:@"deploy_name"];
            [lbName changeLabelWidth];
            float fw=[lbName sizeThatFits:CGSizeMake(MAXFLOAT, 20)].width;
            if (fw>(kScreenWidth-W(lbLable)-20-X(lbName))) {
                lbName.frameWidth=kScreenWidth-W(lbLable)-20-X(lbName);
                lbName.frameHeight=40;
                lbName.numberOfLines=2;
                lbName.frameY=25;
                lbOtherInfo.frameY=YH(lbName)+10;
            }
            lbLable.frameX=XW(lbName)+5;
            if ([[data ojsk:@"type"] isEqualToString:@"1"]) {
                lbLable.textColor=rgb(13,112,161);
                lbLable.backgroundColor=RGBACOLOR(13,112,161, 0.1);
            }else{
                lbLable.textColor=rgb(244,58,58);
                lbLable.backgroundColor=RGBACOLOR(244,58,58, 0.1);
            }
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
