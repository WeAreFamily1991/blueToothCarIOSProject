//
//  MessageCenterCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/3/1.
//  Copyright © 2019 55like. All rights reserved.
//

#import "MessageCenterCellView.h"

@implementation MessageCenterCellView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
        self.frameHeight=80;
    }
    if (self.isfirstInit) {
        self.backgroundColor=rgb(255, 255, 255);
        UIImageView*imgVIcon=[RHMethods imageviewWithFrame:CGRectMake(15, 15, 50, 50) defaultimage:@"photo" supView:self];
        [imgVIcon beRound];
        UILabel*lbChatterName=[RHMethods lableX:imgVIcon.frameXW+11.5 Y:imgVIcon.frameX+7 W:self.frameWidth*0.5 Height:16 font:16 superview:self withColor:rgb(51, 51, 51) text:@"梅西"];
        UILabel*lbDescribe=[RHMethods lableX:lbChatterName.frameX Y:lbChatterName.frameYH+9 W:kScreenWidth-lbChatterName.frameX-15 Height:14 font:14 superview:self withColor:rgb(153, 153, 153) text:@"Hello,what questions do you need to consult?"];
         UILabel*lbTime=[RHMethods RlableRX:15 Y:24 W:120 Height:12 font:12 superview:self withColor:rgb(153, 153, 153) text:@"5月14日"];
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(15, 0, self.frameWidth-15, 1) backgroundcolor:rgb(238, 238, 238) superView:self];
        viewLine.frameBY=0;
//        <![CDATA[请阅读并同意<font color="#0d6b9a">《隱私條款》</font>]]>
//        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithData:[@"请阅读并同意<font color=\"#0d6b9a\">《隱私條款》</font>" dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
//                                                           documentAttributes:nil error:nil];

        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithData:[@"请阅读并同意<font color=\"#0d6b9a\">《隱私條款》</font>" dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                                                           documentAttributes:nil error:nil];
        lbDescribe.numberOfLines = 0;
        [lbDescribe setAttributedText:attrStr];
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
