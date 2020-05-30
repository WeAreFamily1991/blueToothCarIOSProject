//
//  OrderHomeSmallTimeCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/2/26.
//  Copyright © 2019 55like. All rights reserved.
//

#import "OrderHomeSmallTimeCellView.h"

@implementation OrderHomeSmallTimeCellView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
        self.frameHeight=55;
    }
    if (self.isfirstInit) {
        
        
        UILabel*lbDate=[RHMethods lableX:15 Y:0+20 W:100 Height:16 font:16 superview:self withColor:rgb(51, 51, 51) text:@"11月14日"];
        UILabel*lbTime=[RHMethods lableX:lbDate.frameX Y:lbDate.frameYH+10 W:lbDate.frameWidth Height:13 font:13 superview:self withColor:rgb(102, 102, 102) text:@"今天 14：00"];
        UILabel*lbRDate=[RHMethods RlableRX:15 Y:0+20 W:100 Height:16 font:16 superview:self withColor:rgb(51, 51, 51) text:@"11月16日"];
        UILabel*lbRTime=[RHMethods RlableRX:15 Y:lbRDate.frameYH+10 W:lbDate.frameWidth Height:13 font:13 superview:self withColor:rgb(102, 102, 102) text:@"週五 14：00"];
        UIImageView*imgVLine=[RHMethods imageviewWithFrame:CGRectMake(0, 0+37, 91, 4) defaultimage:@"timei" supView:self];
        [imgVLine beCX];
        UILabel*lbCenterTime=[RHMethods ClableY:0 W:100 Height:13 font:13 superview:self withColor:rgb(153, 153, 153) text:@"2天"];
        lbCenterTime.frameYH=imgVLine.frameY-4;
        
        UIImageView*imgVBluedot=[RHMethods imageviewWithFrame:CGRectMake(15, lbTime.frameYH+22, 9, 9) defaultimage:@"botblue1" supView:self];
        imgVBluedot.backgroundColor=rgb(255, 255, 255);
        UIView*viewVline=[UIView viewWithFrame:CGRectMake(imgVBluedot.centerX, imgVBluedot.frameYH, 2, 2) backgroundcolor:rgb(238,238,238) superView:self];
        UILabel*lbStartAddress=[RHMethods lableX:34 Y:0 W:self.frameWidth-34-15 Height:14 font:14 superview:self withColor:rgb(102, 102, 102) text:@"取車點  上海市浦東新區耀華路532號"];
        lbStartAddress.centerY=imgVBluedot.centerY;
        viewVline.centerX=imgVBluedot.centerX;
        [lbStartAddress setColor:rgb(0, 0, 0) contenttext:@"取車點"];
        
        UILabel*lbEndAddress=[RHMethods lableX:34 Y:lbStartAddress.frameYH+20 W:lbStartAddress.frameWidth Height:14 font:14 superview:self withColor:rgb(102, 102, 102) text:@"還車點  上海市浦東新區耀華路532號"];
        [lbEndAddress setColor:rgb(0, 0, 0) contenttext:@"還車點"];
        
        UIImageView*imgVReddot=[RHMethods imageviewWithFrame:CGRectMake(15, 0, 9, 9) defaultimage:@"dotred1" supView:self];
        imgVReddot.backgroundColor=rgb(255, 255, 255);
        imgVReddot.centerY=lbEndAddress.centerY;
        
        viewVline.frameHeight=imgVReddot.frameY-viewVline.frameY;
        
        self.frameHeight=lbEndAddress.frameYH+10;
        [self setAddUpdataBlock:^(id data, id weakme) {
            lbDate.text=[[data ojk:@"starttime_str"] firstObject];
            lbTime.text=[[data ojk:@"starttime_str"] lastObject];
            lbRDate.text=[[data ojk:@"endtime_str"] firstObject];
            lbRTime.text=[[data ojk:@"endtime_str"] lastObject];
            lbStartAddress.text=[NSString stringWithFormat:@"%@  %@",kS(@"main_order", @"pick_up"),[data ojsk:@"pickup_address"]];
            [lbStartAddress setColor:rgb(0, 0, 0) contenttext:kS(@"main_order", @"pick_up")];
            lbEndAddress.text=[NSString stringWithFormat:@"%@  %@",kS(@"main_order", @"drop_off"),[data ojsk:@"dropoff_address"]];
            [lbEndAddress setColor:rgb(0, 0, 0) contenttext:kS(@"main_order", @"drop_off")];
//            day
            lbCenterTime.text=[NSString stringWithFormat:@"%@  %@",[data ojsk:@"day"],kS(@"main_order", @"day")];
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
