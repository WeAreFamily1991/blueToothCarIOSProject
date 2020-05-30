//
//  OrderMessageCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/3/1.
//  Copyright © 2019 55like. All rights reserved.
//

#import "OrderMessageCellView.h"

@implementation OrderMessageCellView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
        self.frameHeight=55;
    }
    self.backgroundColor=RGBACOLOR(0, 0, 0, 0);
    UILabel*lbTime=[RHMethods ClableY:15 W:135.5 Height:20 font:13 superview:self withColor:rgb(255, 255, 255) text:@"2018-05-20 13:00" reuseId:@"lbTime"];
    lbTime.backgroundColor=RGBACOLOR(204, 204, 204, 0.5);
    lbTime.layer.cornerRadius=2.5;
    UIView*viewContent=[UIView viewWithFrame:CGRectMake(15, lbTime.frameYH+20, kScreenWidth-30, 70) backgroundcolor:rgb(255, 255, 255) superView:self reuseId:@"viewContent"];
    viewContent.layer.cornerRadius=5;
    UILabel*lbTitle=[RHMethods lableX:11 Y:15.5 W:viewContent.frameWidth-11*2 Height:16 font:16 superview:viewContent withColor:rgb(51, 51, 51) text:@"訂單已取消" reuseId:@"lbTitle"];
    UILabel*lbContent=[RHMethods lableX:11 Y:lbTitle.frameYH+11 W:lbTitle.frameWidth Height:0 font:14 superview:viewContent withColor:rgb(153, 153, 153) text:@"用戶“飛翔的豬豬”已取消訂單“英菲尼迪 Q50 2.0T”" reuseId:@"lbContent"];
    viewContent.frameHeight=lbContent.frameYH+15.5;
    self.frameHeight=viewContent.frameYH+3;
    
    if (self.isfirstInit) {
        __weak __typeof(self) weakSelf = self;
        [self setAddUpdataBlock:^(id data, id weakme) {
            lbTime.text=[data ojsk:@"ctime_str"];
            lbTitle.text=[data ojsk:@"title"];
            lbContent.text=[data ojsk:@"content"];
            [weakSelf initOrReframeView];
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
