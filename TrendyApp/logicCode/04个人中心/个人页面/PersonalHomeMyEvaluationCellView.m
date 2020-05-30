//
//  PersonalHomeMyEvaluationCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/2/27.
//  Copyright © 2019 55like. All rights reserved. 178a2ea19ada79fb12aee5&uid=6&language=cn
//

#import "PersonalHomeMyEvaluationCellView.h"
#import "OrderHomeSmallCellView.h"
#import "XHStarRateView.h"
#import "OrderHomeSmallTimeCellView.h"
#import "CommentOrderSmallTimeCellView.h"
@implementation PersonalHomeMyEvaluationCellView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
        self.frameHeight=55;
    }
    self.backgroundColor=rgb(255, 255, 255);
    UIImageView*imgVIcon=[RHMethods imageviewWithFrame:CGRectMake(15, 20, 40, 40) defaultimage:@"photo" supView:self reuseId:@"imgVIcon"];
    [imgVIcon beRound];
    UILabel*lbName=[RHMethods lableX:imgVIcon.frameXW+17 Y:22 W:kScreenWidth-imgVIcon.frameXW-17-15 Height:18 font:18 superview:self withColor:rgb(0, 0, 0) text:@"Trengy官方客服" reuseId:@"lbName"];
    UILabel*lbTime=[RHMethods lableX:lbName.frameX Y:lbName.frameYH+4.5 W:lbName.frameWidth Height:13 font:13 superview:self withColor:rgb(153, 153, 153) text:@"2018.09.10 08:30" reuseId:@"lbTime"];
    
//    NSArray*arraytitle=@[@"車輛狀況",@"服務態度",];
    NSArray*arraytitle=@[kS(@"carOwnerMessage", @"VehicleCondition"),kS(@"carOwnerMessage", @"ServiceAttitude"),];
    
    
    for(int i=0;i<arraytitle.count;i++){
        UILabel*lbItemName=[RHMethods lableX:15 Y:imgVIcon.frameYH+16+i*21 W:0 Height:12 font:12 superview:self withColor:rgb(153, 153, 153) text:arraytitle[i]];
        XHStarRateView*viewStar=[XHStarRateView viewWithFrame:CGRectMake(lbItemName.frameXW+15, 0, 92+15, 15) backgroundcolor:nil superView:self  reuseId:[NSString stringWithFormat:@"viewStar%d",i]];
        viewStar.userInteractionEnabled=NO;
        //            [viewStar beCY];
        //            viewStar.frameRX=56;
        UILabel*lbScore=[RHMethods lableX:viewStar.frameXW+10 Y:0 W:50 Height:13 font:13 superview:self withColor:rgb(244, 58, 58) text:@"5.0分"  reuseId:[NSString stringWithFormat:@"lbScore%d",i]];
        lbScore.centerY=viewStar.centerY=lbItemName.centerY;
        [viewStar setComplete:^(CGFloat currentScore) {
            lbScore.text=[NSString stringWithFormat:@"%.1f%@",currentScore,kS(@"carOwnerMessage", @"branch")];
        }];
        
        self.frameHeight=lbScore.frameYH;
    }
    
    
    UILabel*lbDescribe=[RHMethods lableX:15 Y:self.frameHeight+15 W:kScreenWidth-30 Height:0 font:14 superview:self withColor:rgb(102, 102, 102) text:@"車子準時歸還，歸還後車子已然乾淨整潔車子準時歸還，歸還後車子已然乾淨整潔車子準時歸還，歸還後車子已然乾淨整潔車子準時歸還，歸還後車子已然乾淨整潔"  reuseId:@"lbDescribe"];
  
    self.frameHeight=lbDescribe.frameYH+20;
    NSArray*arrayImageArray=[self.data ojk:@"pics"];
    for (UIView*subView in self.subviews) {
        if (subView.tag==1009) {
            subView.hidden=YES;
        }
    }
    float width=(kScreenWidth-30-6)/3.0;
    for (int i=0; i<arrayImageArray.count; i++) {
        UIImageView*imgVPic=[self getAddValueForKey:[NSString stringWithFormat:@"imgVPic%d",i]];
        if (imgVPic==nil) {
            imgVPic=[RHMethods BIGimageviewWithFrame:CGRectMake(15+i%3*(width+3), lbDescribe.frameYH+20+i/3*(width+10), width, width) defaultimage:@"photo" supView:self];
            [self setAddValue:imgVPic forKey:[NSString stringWithFormat:@"imgVPic%d",i]];
        }
        
        
        [imgVPic imageWithURL:arrayImageArray[i]];
        imgVPic.tag=1009;
        imgVPic.hidden=NO;
        if (i==arrayImageArray.count-1) {
            self.frameHeight=imgVPic.frameYH;
        }
    }
    

    
    UIView*viewCarInfo=[UIView viewWithFrame:CGRectMake(15, self.frameHeight+15, kScreenWidth-30, 0) backgroundcolor:rgbwhiteColor superView:self  reuseId:@"viewCarInfo"];
    viewCarInfo.layer.borderColor=rgb(238, 238, 238).CGColor;
    viewCarInfo.layer.borderWidth=1;
    viewCarInfo.layer.cornerRadius=5;
    
    XHStarRateView*viewStar1=[self getAddValueForKey:@"viewStar0"];
    XHStarRateView*viewStar2=[self getAddValueForKey:@"viewStar1"];
    OrderHomeSmallCellView*viewCellCar=[OrderHomeSmallCellView viewWithFrame:CGRectMake(0, 0, viewCarInfo.frameWidth, 0) backgroundcolor:nil superView:viewCarInfo  reuseId:@"OrderHomeSmallCellView"];
    viewCellCar.type=@"personalHome";
    CommentOrderSmallTimeCellView*viewCellTime=[CommentOrderSmallTimeCellView viewWithFrame:CGRectMake(0, viewCellCar.frameYH, viewCarInfo.frameWidth, 0) backgroundcolor:nil superView:viewCarInfo reuseId:@"CommentOrderSmallTimeCellView"];
    viewCarInfo.frameHeight=viewCellTime.frameYH;
    self.frameHeight=viewCarInfo.frameYH+20;
    UIView*viewLine=[UIView viewWithFrame:CGRectMake(15, 0, kScreenWidth-30, 1) backgroundcolor:rgb(238, 238, 238) superView:self reuseId:@"viewLine"];
    viewLine.frameBY=0;
    
    if (self.isfirstInit) {
        __weak __typeof(self) weakSelf = self;
        [self setAddUpdataBlock:^(id data, id weakme) {
            [imgVIcon imageWithURL:[[data ojk:@"userinfo"] ojsk:@"path"]];
            lbName.text=[[data ojk:@"userinfo"] ojsk:@"nickname"];
            lbTime.text=[[data ojk:@"userinfo"] ojsk:@"ctime_str"];
            lbDescribe.text=[data ojsk:@"content"];
            [viewCellCar upDataMeWithData:[data ojk:@"order"]];
            [viewCellTime upDataMeWithData:data];
            [weakSelf initOrReframeView];
            viewStar1.currentScore=[data ojsk:@"car_point"].floatValue;
            viewStar2.currentScore=[data ojsk:@"service_point"].floatValue;
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
