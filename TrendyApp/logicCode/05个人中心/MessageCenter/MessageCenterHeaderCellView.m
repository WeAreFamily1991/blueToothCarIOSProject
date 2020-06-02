//
//  MessageCenterHeaderCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/3/1.
//  Copyright © 2019 55like. All rights reserved.
//

#import "MessageCenterHeaderCellView.h"
@interface MessageCenterHeaderCellView()
{
    
}
@property(nonatomic,strong)UILabel*lbMessage;
@end
@implementation MessageCenterHeaderCellView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
        self.frameHeight=80;
    }
    if (self.isfirstInit) {
        self.backgroundColor=rgb(255, 255, 255);
        UIImageView*imgVNoticeType=[RHMethods imageviewWithFrame:CGRectMake(15, 15, 50, 50) defaultimage:@"photo" supView:self];
        [imgVNoticeType beRound];
        UILabel*lbMessageTypeLable=[RHMethods lableX:imgVNoticeType.frameXW+15 Y:32.5 W:200 Height:16 font:16 superview:self withColor:rgb(51, 51, 51) text:@"OrderMessage"];
        UIImageView*imgVRow=[RHMethods imageviewWithFrame:CGRectMake(0, 0, 6, 12) defaultimage:@"arrowr1" supView:self];
        imgVRow.frameRX=15;
        [imgVRow beCY];
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(15, 0, self.frameWidth-1, 1) backgroundcolor:rgb(238, 238, 238) superView:self];
        viewLine.frameBY=0;
        
        [self setAddUpdataBlock:^(id data, id weakme) {
            imgVNoticeType.image=[UIImage imageNamed:[data ojk:@"image"]];
            lbMessageTypeLable.text=[data ojsk:@"title"];
        }];
        {
            UILabel*lbMessage=[RHMethods lableX:0 Y:0 W:0 Height:15 font:15 superview:self withColor:rgbwhiteColor text:@"3"];
            lbMessage.backgroundColor=rgb(244,58,58);
            [lbMessage beRound];
            //          __weak __typeof(self) weakSelf = self;
            [lbMessage setAddUpdataBlock:^(id data, id weakme) {
                UILabel*lbMessage=weakme;
                if ([lbMessage.text notEmptyOrNull]&&lbMessage.text.integerValue>0) {
                    lbMessage.hidden=NO;
                    lbMessage.textAlignment=NSTextAlignmentCenter;
                    lbMessage.frameWidth=[lbMessage.text widthWithFont:lbMessage.font.pointSize]+10;
                    lbMessage.frameX=50;
                    lbMessage.frameY=10;
                }else{
                    lbMessage.hidden=YES;
                }
            }];
            [lbMessage upDataMe];
            _lbMessage=lbMessage;
        }
        
    }
    
}
-(NSString *)valueStr{
    
    return @"";
}
-(void)setValueStr:(NSString *)valueStr{
    self.lbMessage.text=valueStr;
    [self.lbMessage upDataMe];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
