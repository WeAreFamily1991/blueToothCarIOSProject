//
//  IntegralDetailListCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/3/4.
//  Copyright © 2019 55like. All rights reserved.
//

#import "IntegralDetailListCellView.h"

@implementation IntegralDetailListCellView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
        self.frameHeight=65;
    }
    if (self.isfirstInit) {
        self.backgroundColor=rgb(255, 255, 255);

        UILabel*lbName=[RHMethods lableX:15 Y:15 W:kScreenWidth-30-80 Height:16 font:16 superview:self withColor:rgb(51, 51, 51) text:@"英菲尼迪Q5"];
         UILabel*lbIntegral=[RHMethods RlableRX:15 Y:15 W:80 Height:16 font:16 superview:self withColor:rgb(51, 51, 51) text:@"+1000"];
    UILabel*lbTime=[RHMethods lableX:15 Y:lbName.frameYH+9.5 W:kScreenWidth-30 Height:13 font:13 superview:self withColor:rgb(153, 153, 153) text:@"今天 14：50"];
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(15, 0, kScreenWidth-30, 1) backgroundcolor:rgb(238, 238, 238) superView:self];
        viewLine.frameBY=0;
        [self setAddUpdataBlock:^(id data, id weakme) {
            lbName.text=[data ojsk:@"descr"];
            lbTime.text=[data ojsk:@"ctime_str"];
            lbIntegral.text=[NSString stringWithFormat:@"%@%@",[[data ojsk:@"dotype"] isEqualToString:@"in"]?@"+":@"-",[data ojsk:@"amount"]];
        }];
    }
    
}
-(void)bendData:(id)data withType:(NSString *)type{
    [super bendData:data withType:type];
    [self upDataMeWithData:data];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
