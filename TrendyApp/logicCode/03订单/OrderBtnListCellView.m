//
//  OrderBtnListCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/2/20.
//  Copyright © 2019 55like. All rights reserved.
//

#import "OrderBtnListCellView.h"

@implementation OrderBtnListCellView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
        self.frameHeight=30;
    }
    if (self.isfirstInit) {
          __weak __typeof(self) weakSelf = self;
         UILabel*lbStatus=[RHMethods RlableRX:25 Y:0 W:150 Height:30 font:15 superview:self withColor:rgb(153, 153, 153) text:@"        "];
        _statusLable =lbStatus;
        
        [self setAddUpdataBlock:^(id data, id weakme) {
            //            NSArray*arraytitle=@[
            //                                 @{
            //                                     @"title":@"重新申請",
            //                                     //                                     @"backcolor":
            //                                     },
            //                                 @{
            //                                     @"title":@"刪除訂單",
            //                                     //                                     @"backcolor":
            //                                     },
            //                                 ];
            
            NSArray*arraytitle=[[data reverseObjectEnumerator] allObjects];
            for (UIView*sview in weakSelf.subviews) {
                if (sview.tag==1009) {
                    sview.hidden=YES;
                }
            }
            float rx=15;
            for (int i=0; i<arraytitle.count; i++) {
                NSMutableDictionary*dic=arraytitle[i];
                WSSizeButton*btnIcon=[RHMethods buttonWithframe:CGRectMake(0, 0, 80, 30) backgroundColor:rgbwhiteColor text:@"重新申請" font:14 textColor:rgb(0, 0, 0) radius:3 superview:weakSelf reuseId:[NSString stringWithFormat:@"btnIcon%d",i]];
                [weakSelf setEventBtn:btnIcon];
                btnIcon.frameWidth=80;
                float with=[[dic ojsk:@"name"] widthWithFont:14]+20;
//                if (with>80) {
                    btnIcon.frameWidth=with;
//                }
                
                btnIcon.data=dic;
                btnIcon.tag=1009;
                btnIcon.hidden=NO;
                btnIcon.frameRX=rx;
                rx=weakSelf.frameWidth-btnIcon.frameX+10;
                btnIcon.layer.borderWidth=1;
                btnIcon.layer.cornerRadius=3;
                btnIcon.layer.borderColor=rgbHexColor([dic ojsk:@"color"]).CGColor;
                [btnIcon setBackgroundColor:rgbHexColor([dic ojsk:@"background"])];
                [btnIcon setTitleColor:rgbHexColor([dic ojsk:@"color"]) forState:UIControlStateNormal];
                [btnIcon setTitle:[dic ojsk:@"name"] forState:UIControlStateNormal];
            }
            lbStatus.frameRX=rx;
        }];
        
        [self upDataMe];
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
