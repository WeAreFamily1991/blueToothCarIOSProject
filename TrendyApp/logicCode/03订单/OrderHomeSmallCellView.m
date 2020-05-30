//
//  OrderHomeSmallCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/2/20.
//  Copyright © 2019 55like. All rights reserved.
//

#import "OrderHomeSmallCellView.h"

@implementation OrderHomeSmallCellView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
        self.frameHeight=105;
    }
    if (self.isfirstInit) {
        self.backgroundColor=rgb(255, 255, 255);
        UIImageView*imgVIcon=[RHMethods imageviewWithFrame:CGRectMake(15, 16, 100, 75) defaultimage:@"proimg1" supView:self];
        UILabel*lbName=[RHMethods lableX:imgVIcon.frameXW+15 Y:imgVIcon.frameX+6 W:self.frameWidth-imgVIcon.frameXW-30 Height:17 font:17 superview:self withColor:rgb(51, 51, 51) text:@"瑪莎拉蒂 Levante 車..."];
        UILabel*lbDes=[RHMethods lableX:lbName.frameX Y:lbName.frameYH+10 W:lbName.frameWidth Height:12 font:12 superview:self withColor:rgb(102, 102, 102) text:@"滬B***25  三廂 | 1.5自助 | 乘坐5人"];
        
        UILabel*chezhuLable=nil;
        NSArray*arraytitle=@[@"個人車主",];
        float x=lbDes.frameX;
//        UILabel*lbLablex=nil;
        for (int i=0; i<arraytitle.count; i++) {
            UILabel*lbLable=[RHMethods lableX:x Y:lbDes.frameYH+10 W:0 Height:17 font:10 superview:self withColor:rgb(13, 112, 161) text:arraytitle[i]];
            chezhuLable=lbLable;
            
            lbLable.backgroundColor=RGBACOLOR(13, 112, 161, 0.1);
            lbLable.layer.cornerRadius=3;
            lbLable.textAlignment=NSTextAlignmentCenter;
            lbLable.frameWidth=lbLable.frameWidth+6;
            x=lbLable.frameXW+10;
            if (i==1) {
                lbLable.textColor=rgb(255, 255, 255);
                lbLable.backgroundColor=RGBACOLOR(255, 140, 79, 1);
            }
        }
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(15, 0, self.frameWidth-30, 1) backgroundcolor:rgb(238, 238, 238) superView:self];
        viewLine.frameBY=0;
         UILabel*lbPrice=[RHMethods RlableRX:15 Y:lbDes.frameYH+10 W:100 Height:12 font:12 superview:self withColor:rgbRedColor text:@""];
//        lbPrice.frameBY=15;
          __weak __typeof(self) weakSelf = self;
        [self setAddUpdataBlock:^(id data, id weakme) {
            [imgVIcon imageWithURL:[data ojsk:@"car_path"]];
            
            lbName.text=[data ojsk:@"title"];
            lbDes.text=[NSString stringWithFormat:@"%@ %@",[data ojsk:@"plate_number"],[[data ojk:@"car_deploy"] componentsJoinedByString:@" | "]];
            if ([data ojk:@"car_deploy"]==nil) {
                lbDes.text=[NSString stringWithFormat:@"%@ %@",[data ojsk:@"plate_number"],[[data ojk:@"deploy"] componentsJoinedByString:@" | "]];
            }
            
            chezhuLable.text=[data ojsk:@"car_type_str"];
            if (![[data ojsk:@"car_type_str"] notEmptyOrNull]) {
                chezhuLable.text=[data ojsk:@"type_str"];
            }
            if ([weakSelf.type isEqualToString:@"personalHome"]) {
                lbPrice.text=[NSString stringWithFormat:@"￥%@",[data ojsk:@"totalprice"]];
            }
            if ([[data ojsk:@"type"] isEqualToString:@"1"]) {
                chezhuLable.textColor=rgb(13,112,161);
                chezhuLable.backgroundColor=RGBACOLOR(13,112,161, 0.1);
            }else{
                chezhuLable.textColor=rgb(244,58,58);
                chezhuLable.backgroundColor=RGBACOLOR(244,58,58, 0.1);
            }
            chezhuLable.frameWidth=[chezhuLable.text widthWithFont:chezhuLable.font.pointSize]+6;
        }];
        
        
        
        
    }
    
}
/*
// Only override drawRect: if you perform custom drawing. VehicleOwnerViewController
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
