//
//  PanTextCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/4/1.
//  Copyright © 2019 55like. All rights reserved.
//

#import "PanTextCellView.h"

@implementation PanTextCellView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
        self.frameHeight=50;
    }
    if (self.isfirstInit) {
        UILabel*lbName=[RHMethods lableX:15 Y:0 W:self.frameWidth-30 Height:self.frameHeight font:14 superview:self withColor:rgb(153, 153, 153) text:@"共同使用條件"];
        [self setAddUpdataBlock:^(id data, id weakme) {
            lbName.text=[data ojsk:@"name"];
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
