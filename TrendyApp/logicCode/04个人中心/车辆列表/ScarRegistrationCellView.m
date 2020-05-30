//
//  ScarRegistrationCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/4/4.
//  Copyright © 2019 55like. All rights reserved.
//

#import "ScarRegistrationCellView.h"

@implementation ScarRegistrationCellView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
        self.frameHeight=154;
    }
    if (self.isfirstInit) {
        self.backgroundColor=rgbwhiteColor;
        UILabel*lbName=[RHMethods lableX:15 Y:20 W:0 Height:16 font:16 superview:self withColor:rgb(51, 51, 51) text:kS(@"WoundRecord", @"ScarContent")];
         UILabel*lbTime=[RHMethods RlableRX:15 Y:0 W:150 Height:12 font:12 superview:self withColor:rgb(153, 153, 153) text:@"2015/01/21"];
        lbTime.centerY=lbName.centerY;
        float x=15;
        float width=(kScreenWidth-30-10*3)/4;
        for (int i=0; i<4; i++) {
            UIImageView*imgVIcon=[RHMethods imageviewWithFrame:CGRectMake(x, lbName.frameYH+19, width, width) defaultimage:@"photo" supView:self reuseId:[NSString stringWithFormat:@"imgVIcon%d",i]];
            imgVIcon.hidden=YES;
            imgVIcon.tag=1001;
            x=imgVIcon.frameXW+10;
            if (i==0) {
                self.frameHeight=imgVIcon.frameYH+15;
            }
        }
          __weak __typeof(self) weakSelf = self;
        [self setAddUpdataBlock:^(id data, id weakme) {
            
            lbTime.text=[data ojsk:@"ctime_str"];
            for (UIView*subView in weakSelf.subviews) {
                if (subView.tag==1001) {
                    subView.hidden=YES;
                }
            }
            
            for (int i=0; i<[[data ojk:@"pics"] count]; i++) {
                UIImageView*imgVIcon=[weakSelf getAddValueForKey:[NSString stringWithFormat:@"imgVIcon%d",i]];
                imgVIcon.hidden=NO;
                [imgVIcon imageWithURL:[data ojk:@"pics"][i]];
            }
            
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
