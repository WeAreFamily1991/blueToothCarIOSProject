//
//  VehicleDetailInfoCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/2/28.
//  Copyright © 2019 55like. All rights reserved. 178a2ea19ada79fb12aee5&uid=6&language=cn
//

#import "VehicleDetailInfoCellView.h"

@implementation VehicleDetailInfoCellView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
        self.frameHeight=55;
    }
    if (self.isfirstInit) {
        UILabel*lbTitle=[RHMethods lableX:15 Y:20 W:kScreenWidth-30 Height:16 font:16 superview:self withColor:rgb(51, 51, 51) text:@"样式"];
          __weak __typeof(self) weakSelf = self;
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(15, 0, kScreenWidth-15, 1) backgroundcolor:rgb(238, 238, 238) superView:self];
        self.backgroundColor=rgbwhiteColor;
        [self setAddUpdataBlock:^(id data, id weakme) {
            lbTitle.text=[data ojsk:@"title"];
            float width=(weakSelf.frameWidth-30-20)/3.0;
            NSArray*itmeArray=[data ojk:@"son"];
            for (UIView*btnItemView in weakSelf.subviews) {
                if (btnItemView.tag==2019) {
                    btnItemView.hidden=YES;
                }
            }
            
            for (int i= 0; i<itmeArray.count; i++) {
                WSSizeButton*btnItem= [weakSelf getAddValueForKey:[NSString stringWithFormat:@"btnItem%d",i]];
                if (btnItem==nil) {
                    btnItem=[RHMethods buttonWithframe:CGRectMake(15+i%3*(width+10), 55 + i/3*(44), width, 34) backgroundColor:nil text:@"提交" font:13 textColor:rgb(102, 102, 102) radius:3 superview:weakSelf reuseId:[NSString stringWithFormat:@"btnItem%d",i]];
                    btnItem.layer.borderColor=rgb(204, 204, 204).CGColor;
                    btnItem.layer.borderWidth=1;
                    [btnItem setTitleColor:rgb(255, 255, 255) forState:UIControlStateSelected];
                    [btnItem addViewTarget:weakSelf select:@selector(btnItemClick:)];
                    [btnItem setBackGroundImageviewColor:rgb(255, 255, 255) forState:UIControlStateNormal];
                    [btnItem setBackGroundImageviewColor:rgb(25, 84, 140) forState:UIControlStateSelected];
                    [btnItem setAddUpdataBlock:^(id data, id weakme) {
                        WSSizeButton*btnItem=weakme;
                        [btnItem setTitle:[data ojk:@"title"] forState:UIControlStateNormal];
                        btnItem.selected=[[data ojsk:@"selected"] isEqualToString:@"1"];
                        btnItem.layer.borderWidth=btnItem.selected?0:1;
                    }];
                }
                btnItem.hidden=NO;
                btnItem.tag=2019;
                [btnItem upDataMeWithData:itmeArray[i]];
                if (i==itmeArray.count-1) {
                    weakSelf.frameHeight=btnItem.frameYH+15;
                }
            }
            viewLine.frameBY=0;
        }];
        
    }
    
}
-(void)btnItemClick:(UIButton*)btn{ 
    
    if ([[self.data ojsk:@"ismulti"] isEqualToString:@"1"]) {
        
        [btn.data setObject:[[btn.data ojsk:@"selected"] isEqualToString:@"1"]?@"0":@"1" forKey:@"selected"];
        [btn upDataMe];
        
    }else{
    for (WSSizeButton*btnItemView in self.subviews) {
            if (btnItemView.tag==2019&&btnItemView!=btn) {
                [btnItemView.data setObject:@"0" forKey:@"selected"];
                if (btnItemView.selected) {
                    [btnItemView upDataMe];
                }
            }
        }
        [btn.data setObject:[[btn.data ojsk:@"selected"] isEqualToString:@"1"]?@"0":@"1" forKey:@"selected"];
        [btn upDataMe];
    }
}
/*
// Only override drawRect: if you perform custom drawing. 178a2ea19ada79fb12aee5&uid=6&language=cn
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
