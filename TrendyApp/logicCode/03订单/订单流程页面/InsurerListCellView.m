//
//  InsurerListCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/2/26.
//  Copyright © 2019 55like. All rights reserved.
//

#import "InsurerListCellView.h"

@implementation InsurerListCellView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
        self.frameHeight=55;
    }
    if (self.isfirstInit) {
        self.backgroundColor=rgb(255, 255, 255);
        UILabel*lbName=[RHMethods lableX:15 Y:20 W:self.frameWidth-30 Height:16 font:16 superview:self withColor:rgb(51, 51, 51) text:@"菠蘿"];
        UILabel*lbAddress=[RHMethods lableX:15 Y:50 W:self.frameWidth-15-77+27 Height:14 font:14 superview:self withColor:rgb(153, 153, 153) text:@"地址：上海市徐匯區康健新村街道滬閔路86..."];
        UILabel*lbMoble=[RHMethods lableX:lbAddress.frameX Y:lbAddress.frameYH+7 W:lbAddress.frameWidth Height:14 font:14 superview:self withColor:rgb(153, 153, 153) text:@"電話：15921162018"];
        self.frameHeight=lbMoble.frameYH+20;
        WSSizeButton*viewBtn=[WSSizeButton viewWithFrame:CGRectMake(0, 0, 15+17*2, 15+17*2) backgroundcolor:nil superView:self];
        [viewBtn setImageStr:@"writei1" SelectImageStr:nil];
        viewBtn.frameRX=0;
        [viewBtn beCY];
        
        [self setEventBtn:viewBtn];
        
        WSSizeButton*btnDel=[WSSizeButton viewWithFrame:CGRectMake(0, 0, 20+15*2, 20+15*2) backgroundcolor:nil superView:self];
        [btnDel setImageStr:@"checkedoff" SelectImageStr:@"checkedon"];
        [btnDel setAddValue:@"cellSelect" forKey:@"actionType"];
        [self setEventBtn:btnDel];
        btnDel.hidden=YES;
        [btnDel beCY];
        lbMoble.frameX= lbAddress.frameX=lbName.frameX=btnDel.frameXW;
        btnDel.hidden=NO;
          __weak __typeof(self) weakSelf = self;
        [self setAddUpdataBlock:^(id data, id weakme) {
            lbName.text=[data ojsk:@"name"];
            lbAddress.text=[NSString stringWithFormat:@"%@:%@",kS(@"insurerInfo", @"address"),[data ojsk:@"address"]];
            lbMoble.text=[NSString stringWithFormat:@"%@:%@",kS(@"insurerInfo", @"mobile"),[data ojsk:@"mobile"]];
            btnDel.selected=[[data ojsk:@"isSelected"] isEqualToString:@"1"];
            
            if ([weakSelf.type isEqualToString:@"userCenter"]) {
                 btnDel.hidden=YES;
                 lbMoble.frameX= lbAddress.frameX=lbName.frameX=15;
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
