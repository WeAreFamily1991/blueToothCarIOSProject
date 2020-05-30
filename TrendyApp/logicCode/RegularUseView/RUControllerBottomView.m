//
//  RUControllerBottomView.m
//  TrendyApp
//
//  Created by 55like on 2019/2/26.
//  Copyright © 2019 55like. All rights reserved.
//

#import "RUControllerBottomView.h"

@implementation RUControllerBottomView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
        self.frameHeight=60;
    }
    if (self.isfirstInit) {
        self.backgroundColor=rgb(255, 255, 255);
         WSSizeButton*btnOK=[RHMethods buttonWithframe:CGRectMake(15, 9, self.frameWidth-30, 44) backgroundColor:rgb(13, 112, 161) text:@"确认" font:16 textColor:rgb(255, 255, 255) radius:5 superview:self];
        [self setEventBtn:btnOK];
        [self setAddUpdataBlock:^(id data, id weakme) {
            [btnOK setTitle:[data ojsk:@"btnTitle"] forState:UIControlStateNormal];
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
