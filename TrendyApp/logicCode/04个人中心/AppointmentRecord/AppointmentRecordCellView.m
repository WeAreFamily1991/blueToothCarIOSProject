//
//  AppointmentRecordCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/3/21.
//  Copyright © 2019 55like. All rights reserved.
//

#import "AppointmentRecordCellView.h"

@implementation AppointmentRecordCellView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
        self.frameHeight=111+51;
    }
    if (self.isfirstInit) {
        self.backgroundColor=rgbwhiteColor;
        UIImageView*imgVIcon=[RHMethods imageviewWithFrame:CGRectMake(15, 21, 94, 70) defaultimage:@"photo" supView:self];
        UILabel*lbName=[RHMethods lableX:imgVIcon.frameXW+9.5 Y:27.5 W:self.frameWidth-imgVIcon.frameXW-9.5-15 Height:15 font:15 superview:self withColor:rgb(51, 51, 51) text:@"经济型"];
        UILabel*lbContent=[RHMethods lableX:lbName.frameX Y:lbName.frameYH+7 W:lbName.frameWidth Height:12 font:12 superview:self withColor:rgb(102, 102, 102) text:@"福特，別克，凱越，三菱，豐田"];
        UILabel*lbPrice=[RHMethods lableX:lbContent.frameX Y:lbContent.frameYH+10 W:lbContent.frameWidth Height:17 font:17 superview:self withColor:rgb(244, 58, 58) text:@"4200元/月 5400元/月"];
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(15, imgVIcon.frameYH+20, self.frameWidth-15, 1) backgroundcolor:rgb(238, 238, 238) superView:self];
        UILabel*lbTime=[RHMethods lableX:15 Y:viewLine.frameYH+20 W:viewLine.frameWidth Height:12 font:12 superview:self withColor:rgb(153, 153, 153) text:@"2018年12月19日 13：20"];
        WSSizeButton*btnAppointmentInfoBt=[RHMethods buttonWithframe:CGRectMake(0, 0, 80, 25) backgroundColor:rgb(255, 255, 255) text:kS(@"booking_record", @"booking_info") font:12 textColor:rgb(0, 0, 0) radius:2.5 superview:self];
        btnAppointmentInfoBt.frameRX=15;
        btnAppointmentInfoBt.centerY=lbTime.centerY;
        btnAppointmentInfoBt.layer.borderWidth=1;
        [btnAppointmentInfoBt addViewTarget:self select:@selector(appointBtnClick:)];
        btnAppointmentInfoBt.layer.borderColor=rgb(204, 204, 204).CGColor;
        [self setAddUpdataBlock:^(id data, id weakme) {
            [imgVIcon imageWithURL:[data ojsk:@"wappath"]];
            lbName.text=[data ojsk:@"title"];
            lbContent.text=[data ojsk:@"descr"];
            lbPrice.text=[NSString stringWithFormat:@"%@%@ %@%@",[data ojsk:@"price"],kS(@"booking_record", @"per_month"),[data ojsk:@"mktprice"],kS(@"booking_record", @"per_month")];
            [lbPrice setColor:rgb(153, 153, 153) font:Font(12) contenttext:[NSString stringWithFormat:@"%@%@",[data ojsk:@"mktprice"],kS(@"booking_record", @"per_month")]];
            lbTime.text=[data ojsk:@"ctime_str"];
        }];
    }
    
    
    
}
-(void)appointBtnClick:(UIButton*)btn{
    
    UIAlertController*alertcv=[UIAlertController alertControllerWithTitle:kS(@"booking_record", @"booking_info") message:
                               [NSString stringWithFormat:@"%@：%@\n%@:%@\n%@：%@\n%@:%@\n",
                                kS(@"booking_record", @"use_in_city"),[self.data ojsk:@"city"],
                                kS(@"booking_record", @"mobile"),[self.data ojsk:@"mobile"],
                                kS(@"booking_record", @"name"),[self.data ojsk:@"name"],
                                kS(@"booking_record", @"cate"),[self.data ojsk:@"catename"]] preferredStyle:UIAlertControllerStyleAlert];
    //[NSString stringWithFormat:@"用車城市：%@\n手機號碼:%@\n姓名：%@\n租車用途:%@\n",[self.data ojsk:@"city"],[self.data ojsk:@"mobile"],[self.data ojsk:@"name"],[self.data ojsk:@"catename"]]
 
    [alertcv addAction:[UIAlertAction actionWithTitle:kS(@"setting_take_and_return_time", @"confirm") style:UIAlertActionStyleCancel handler:nil]];
    [UTILITY.currentViewController presentViewController:alertcv animated:YES completion:^{
        
    }];
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
