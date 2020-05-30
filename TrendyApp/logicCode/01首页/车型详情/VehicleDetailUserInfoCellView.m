//
//  VehicleDetailUserInfoCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/4/4.
//  Copyright © 2019 55like. All rights reserved.
//

#import "VehicleDetailUserInfoCellView.h"

#import "XHStarRateView.h"

@implementation VehicleDetailUserInfoCellView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
        self.frameHeight=93;
    }
    if (self.isfirstInit) {
        UIImageView*imgVIcon=[RHMethods imageviewWithFrame:CGRectMake(15, 26, 40, 40) defaultimage:@"photo" supView:self];
        [imgVIcon beRound];
        UILabel*lbName=[RHMethods lableX:imgVIcon.frameXW+7 Y:29 W:0 Height:13 font:13 superview:self withColor:rgb(51, 51, 51) text:@"张先生张先张先先"];
        XHStarRateView*viewStar=[XHStarRateView viewWithFrame:CGRectMake(lbName.frameX, lbName.frameYH+7, 74, 12) backgroundcolor:nil superView:self];
        viewStar.userInteractionEnabled=NO;
        
        NSArray*arraytitle=@[@"承認率",@"返答時間",@"返答率",];
//        NSArray*arraytitle2=@[@"承認率",@"返答時間",@"返答率",];
        
        NSArray*arraySubTitle=@[kS(@"carDetails", @"confirmRate"),kS(@"carDetails", @"answerTime"),kS(@"carDetails", @"answerRate"),];
        float rx=15+8;
        for (int i=0; i<arraytitle.count; i++) {
            NSString*titleStr=arraytitle[i];
            UILabel*lbItem=[RHMethods lableX:0 Y:49 W:0 Height:11 font:11 superview:self withColor:rgb(102, 102, 102) text:titleStr reuseId:[NSString stringWithFormat:@"lbItem%d",i]];
            lbItem.frameWidth=lbItem.frameWidth+32;
            lbItem.frameRX=rx;
            lbItem.textAlignment=NSTextAlignmentCenter;
            rx=lbItem.frameWidth+lbItem.frameRX;
            lbItem.text=arraySubTitle[i];
            UIView*viewLine=[UIView viewWithFrame:CGRectMake(0, 27, 1, 35) backgroundcolor:rgb(224, 224, 224) superView:self];
            viewLine.frameRX=rx;
            UILabel*lbTitle=[RHMethods lableX:lbItem.frameX Y:30 W:lbItem.frameWidth Height:14 font:14 superview:self withColor:rgb(51, 51, 51) text:@"90%" reuseId:[NSString stringWithFormat:@"lbTitle%d",i]];
            lbTitle.textAlignment=NSTextAlignmentCenter;
            if (i==arraytitle.count-1) {
                viewLine.hidden=YES;
            }
        }
        UIImageView*imgVRow=[RHMethods imageviewWithFrame:CGRectMake(0, 20, 8, 15) defaultimage:@"arrowr2" supView:self];
        imgVRow.frameRX=15;
        [imgVRow beCY];
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(15, 1, kScreenWidth-30, 1) backgroundcolor:rgb(238, 238, 238) superView:self];
        viewLine.frameBY=0;
          __weak __typeof(self) weakSelf = self;
        [self setAddUpdataBlock:^(id data, id weakme) {
            
            [imgVIcon imageWithURL:[data ojsk:@"path"]];
            lbName.text=[data ojsk:@"nickname"];
            viewStar.currentScore=[data ojsk:@"star"].floatValue;
            [[weakSelf getAddValueForKey:@"lbTitle0"] setText:[data ojsk:@"confirm_rate"]];
            [[weakSelf getAddValueForKey:@"lbTitle1"] setText:[data ojsk:@"answer_time"]];
            [[weakSelf getAddValueForKey:@"lbTitle2"] setText:[data ojsk:@"answer_rate"]];
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
