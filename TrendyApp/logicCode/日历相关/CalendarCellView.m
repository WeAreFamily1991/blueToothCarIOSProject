//
//  CalendarCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/3/7.
//  Copyright © 2019 55like. All rights reserved.
//

#import "CalendarCellView.h"
#import "CalendarSmallCellView.h"
@implementation CalendarCellView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
        self.frameHeight=55;
    }
    
    UILabel*lbMonthName=[RHMethods lableX:16 Y:16 W:self.frameWidth-30 Height:18 font:18 superview:self withColor:rgb(51,51,51) text:@"1月"];
    if (self.isfirstInit) {
        self.backgroundColor=rgbwhiteColor;
          __weak __typeof(self) weakSelf = self;
        [self setAddUpdataBlock:^(id data, id weakme) {
            for (UIView*subView in weakSelf.subviews) {
                if (subView.tag==1999) {
                    subView.hidden=YES;
                }
            }
            lbMonthName.text=[NSString stringWithFormat:@"%@月",[data ojsk:@"monthStr"]];
            NSMutableArray *marray=[data ojk:@"dayArray"];
            float width=(kScreenWidth-10)/7;
            for (int i=0; i<marray.count; i++) {
                NSDictionary*dataDic=marray[i];
                MYViewBase *viewContentCell=[weakSelf getAddValueForKey:[NSString stringWithFormat:@"viewContentCell%d",i]];
                if (viewContentCell==nil) {
                    viewContentCell= [CalendarSmallCellView viewWithFrame:CGRectMake(5+i%7*width, lbMonthName.frameYH+20+i/7*width*86.0/51.0, 0, 0) backgroundcolor:nil superView:weakSelf reuseId:[NSString stringWithFormat:@"viewContentCell%d",i]];
                    viewContentCell.tag=1999;
//                    viewContentCell.frameX=0;
//                    viewContentCell.frameY=0;
//                    viewContentCell.tag=1999;
//                    UILabel*lbTitle=[RHMethods ClableY:0 W:40 Height:40 font:15 superview:viewContentCell withColor:rgb(51, 51, 51) text:@"名称"];
//                    lbTitle.backgroundColor=rgb(238,238,238);
//                    [lbTitle beRound];
//                    [viewContentCell setAddUpdataBlock:^(id data, id weakme) {
//                        lbTitle.text=[data ojsk:@"showStr"];
//                    }];
                }
                viewContentCell.type=weakSelf.type;
                [viewContentCell upDataMeWithData:dataDic];
                viewContentCell.hidden=![[dataDic ojsk:@"monthType"] isEqualToString:@"current"];                
                weakSelf.frameHeight=viewContentCell.frameYH+10;
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
