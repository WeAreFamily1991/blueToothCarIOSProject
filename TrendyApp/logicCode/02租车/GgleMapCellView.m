//
//  GgleMapCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/3/28.
//  Copyright © 2019 55like. All rights reserved.
//

#import "GgleMapCellView.h"

@implementation GgleMapCellView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=270;
    }
    if (self.frameHeight==0) {
        self.frameHeight=90;
    }
    if (self.isfirstInit) {
        //        UIImageView*imgVBG=[RHMethods imageviewWithFrame:CGRectMake(0, 0, self.frameWidth, self.frameHeight) defaultimage:@"addressi3" supView:self];
        //        imgVBG.contentMode=UIViewContentModeScaleToFill;
        
        UIView*viewangle=[UIView viewWithFrame:CGRectMake(0, 0, 10, 10) backgroundcolor:rgbwhiteColor superView:self];
        
        
        viewangle.frameBY=1.5;
        [viewangle beCX];
        viewangle.transform= CGAffineTransformMakeRotation(M_PI_4);
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, self.frameWidth, 85) backgroundcolor:rgbwhiteColor superView:self];
        viewContent.layer.cornerRadius=4;
        //        viewangle.frameBY=0;
        //        [viewangle beCX];
        UIImageView*imgVIcon=[RHMethods imageviewWithFrame:CGRectMake(0, 0, 113, 85) defaultimage:@"photo" supView:viewContent];
        UILabel*lbName=[RHMethods lableX:imgVIcon.frameXW+15 Y:20 W:self.frameWidth-imgVIcon.frameXW-15-15-6-5 Height:17 font:17 superview:viewContent   withColor:rgb(51, 51, 51) text:@"aodiA41"];
        UILabel*lbPrice=[RHMethods lableX:lbName.frameX Y:lbName.frameYH+15 W:lbName.frameWidth Height:14 font:14 superview:viewContent withColor:rgb(244, 58, 58) text:@"￥299/天"];
        UIImageView*imgVRow=[RHMethods imageviewWithFrame:CGRectMake(0, 0, 6, 13) defaultimage:@"arrowr2" supView:viewContent];
        imgVRow.centerY=imgVIcon.centerY;
        imgVRow.frameRX=15;
          __weak __typeof(self) weakSelf = self;
        [weakSelf setAddUpdataBlock:^(id data, id weakme) {
            [imgVIcon imageWithURL:[data ojsk:@"path"]];
            lbName.text=[data ojsk:@"title"];
            lbPrice.text=[NSString stringWithFormat:@"￥%@/%@",[data ojsk:@"price"],kS(@"generalPage", @"day")];
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
