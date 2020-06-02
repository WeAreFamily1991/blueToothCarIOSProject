//
//  MyCollectionCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/2/28.
//  Copyright © 2019 55like. All rights reserved.
//

/*


 
 */

#import "MyCollectionCellView.h"
#import "VehicleDetailsViewController.h"

@implementation MyCollectionCellView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
        self.frameHeight=144;
    }
    if (self.isfirstInit) {
        __weak typeof(self) weakSelf=self;
        self.backgroundColor=rgb(255, 255, 255);
        UIImageView*imgVCar=[RHMethods imageviewWithFrame:CGRectMake(15, 16, 150, 112) defaultimage:@"photo" supView:self];
        UIImageView *imageNew=[RHMethods imageviewWithFrame:CGRectMake(20, 20, 34, 17) defaultimage:@"newi" contentMode:UIViewContentModeScaleAspectFit supView:self];
        
        UILabel*lbName=[RHMethods lableX:imgVCar.frameXW+15.5 Y:22 W:self.frameWidth-imgVCar.frameXW-30 Height:17 font:17 superview:self withColor:rgb(51, 51, 51) text:@"奧迪 A4L"];
        UILabel*lbContent=[RHMethods lableX:lbName.frameX Y:lbName.frameYH+9.5 W:lbName.frameWidth Height:12 font:12 superview:self withColor:rgb(102, 102, 102) text:@"三廂|2.0自助|乘坐5人"];
        UILabel*lbLable=[RHMethods lableX:lbContent.frameX Y:lbContent.frameYH+15 W:0 Height:17 font:10 superview:self withColor:rgb(244,58,58) text:@"個人車主"];
        lbLable.frameWidth=lbLable.frameWidth+8;
        lbLable.textAlignment=NSTextAlignmentCenter;
        lbLable.backgroundColor=RGBACOLOR(244,58,58, 0.1);
        UILabel*lbCarNumber=[RHMethods lableX:lbLable.frameXW+10 Y:0 W:lbContent.frameXW-lbLable.frameXW-25 Height:12 font:12 superview:self withColor:rgb(153, 153, 153) text:@"滬B***25"];
        lbCarNumber.centerY=lbLable.centerY;
        UILabel*lbPrice=[RHMethods lableX:lbContent.frameX Y:0 W:lbName.frameWidth Height:18 font:18 superview:self withColor:rgb(244, 58, 58) text:@"￥299/天"];
        lbPrice.frameYH=imgVCar.frameYH-6;
        
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(15, 0, self.frameWidth-30, 1) backgroundcolor:rgb(238, 238, 238) superView:self];
        viewLine.frameBY=0;
        WSSizeButton*viewBtnCellection=[WSSizeButton viewWithFrame:CGRectMake(0, 0, 19+30, 19+22*2) backgroundcolor:nil superView:self];
        [viewBtnCellection setImageStr:@"ficon1" SelectImageStr:@"ficon1on"];
        self.collectionBtn=viewBtnCellection;
        viewBtnCellection.selected=YES;
        [self setEventBtn:viewBtnCellection];
        viewBtnCellection.frameBY=0;
        viewBtnCellection.frameRX=0;
//          __weak __typeof(self) weakSelf = self;
        [self setAddUpdataBlock:^(id data, id weakme) {
            [imgVCar imageWithURL:[data ojsk:@"path"]];
            imageNew.hidden=![[data ojsk:@"isnew"] isEqualToString:@"1"];
            lbName.text=[data ojsk:@"title"];
            lbContent.text=[data ojsk:@"deploy_name"];
            lbLable.text=[data ojsk:@"type_str"];
            lbCarNumber.text=[data ojsk:@"plate_number"];
            
            if ([weakSelf.type isEqualToString:@"collection"]) {
                lbContent.text=[[data ojk:@"deploy"] componentsJoinedByString:@"|"];
            }
            lbPrice.text=[NSString stringWithFormat:@"￥%@/%@",[data ojsk:@"price"],kS(@"main_order", @"day")];
            
            float fw=[lbLable sizeThatFits:CGSizeMake(MAXFLOAT, H(lbLable))].width;
            lbLable.frameWidth=fw+4;
            lbCarNumber.frameX=XW(lbLable)+5;
            lbCarNumber.frameWidth=W(weakSelf)-lbCarNumber.frameX-15;
            if ([[data ojsk:@"type"] isEqualToString:@"1"]) {
                lbLable.textColor=rgb(13,112,161);
                lbLable.backgroundColor=RGBACOLOR(13,112,161, 0.1);
            }else{
                lbLable.textColor=rgb(244,58,58);
                lbLable.backgroundColor=RGBACOLOR(244,58,58, 0.1);
            }
            
        }];
        
        [self addViewClickBlock:^(UIView *view) {
            if ([[weakSelf.data ojsk:@"mySelect"] isEqualToString:@"自助找车"]) {
                [UTILITY setAddValue:@"自助找车" forKey:@"mySelect"];
            }
            
            if ([weakSelf.type isEqualToString:@"ExpressCarRentViewController"]) {
                [kCarCenterService carcenter_checkUserwithBlock:^(id data, int status, NSString *msg) {
                    [UTILITY.currentViewController pushController:[VehicleDetailsViewController class] withInfo:[weakSelf.data ojsk:@"id"] withTitle:[weakSelf.data ojsk:@"title"] withOther:weakSelf.between_time];
                }];
            }else if ([weakSelf.type isEqualToString:@"collection"]) {
                [UTILITY.currentViewController pushController:[VehicleDetailsViewController class] withInfo:[weakSelf.data ojsk:@"objid"] withTitle:[weakSelf.data ojsk:@"title"]];
            }else{
                [UTILITY.currentViewController pushController:[VehicleDetailsViewController class] withInfo:[weakSelf.data ojsk:@"id"] withTitle:[weakSelf.data ojsk:@"title"] withOther:weakSelf.between_time];
            }
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
