//
//  OrderHomeCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/2/20.
//  Copyright © 2019 55like. All rights reserved.
//

#import "OrderHomeCellView.h"
#import "OrderHomeSmallCellView.h"
#import "OrderBtnListCellView.h"
#import "OrderHomeSmallTimeCellView.h"
#import "PersonalHomeViewController.h"
@implementation OrderHomeCellView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
        self.frameHeight=55;
    }
    if (self.isfirstInit) {
        self.backgroundColor=rgb(255, 255, 255);
        UILabel*lbOrderNumber=[RHMethods lableX:15 Y:0 W:kScreenWidth*0.7 Height:44 font:15 superview:self withColor:rgb(119, 119, 119) text:@"訂單編號：546156846"];
        UILabel*lbStatus=[RHMethods RlableRX:15 Y:0 W:150 Height:44 font:14 superview:self withColor:rgb(13, 107, 154) text:@"待審核"];
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(0, lbStatus.frameYH, kScreenWidth, 1) backgroundcolor:rgb(238, 238, 238) superView:self];
        OrderHomeSmallCellView*viewCell=[OrderHomeSmallCellView viewWithFrame:CGRectMake(0, viewLine.frameYH, 0, 0) backgroundcolor:nil superView:self];
        
        OrderHomeSmallTimeCellView*viewCell2=[OrderHomeSmallTimeCellView viewWithFrame:CGRectMake(0, viewCell.frameYH, 0, 0) backgroundcolor:nil superView:self];
        OrderBtnListCellView*viewBtnList=[OrderBtnListCellView viewWithFrame:CGRectMake(0, viewCell2.frameYH+10, 0, 0) backgroundcolor:nil superView:self];
        
        
        self.frameHeight=viewBtnList.frameYH+15;
        UIImageView*imgVIcon=[RHMethods imageviewWithFrame:CGRectMake(15, 0, 30, 30) defaultimage:@"photo" supView:self];
        [imgVIcon beRound];
        UILabel*lbName=[RHMethods lableX:imgVIcon.frameXW+10 Y:0 W:0 Height:16 font:16 superview:self withColor:rgb(51, 51, 51) text:@"名称名称名称名"];
        [imgVIcon addViewTarget:self select:@selector(imageClick:)];
        
        lbName.centerY=  imgVIcon.centerY=viewBtnList.centerY;
        
        
        __weak __typeof(self) weakSelf = self;
        [self setAddUpdataBlock:^(id data, id weakme) {
            lbOrderNumber.text=[NSString stringWithFormat:kS(@"main_order", @"order_number"),[data ojsk:@"orderid"]];
            lbStatus.text=[data ojsk:@"statusname"];
            [viewCell upDataMeWithData:data];
            [viewCell2 upDataMeWithData:data];
            [viewBtnList upDataMeWithData:[data ojk:@"buttonlist"]];
            viewBtnList.statusLable.text=[data ojsk:@"buttonname"];
            [imgVIcon imageWithURL:[[data ojk:@"userinfo"] ojsk:@"icon"]];
            lbName.text=[[data ojk:@"userinfo"] ojsk:@"nickname"];
            if ([weakSelf.type isEqualToString:@"personalCenter"]) {
                imgVIcon.hidden=NO;
                lbName.hidden=NO;
            }else{
                imgVIcon.hidden=YES;
                lbName.hidden=YES;
            }
            
        }];
    }
    
}

-(void)imageClick:(UIButton*)btn{
    [UTILITY.currentViewController pushController:[PersonalHomeViewController class] withInfo:[self.data ojk:@"uid"] withTitle:@"" withOther:nil];
    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code 178a2ea19ada79fb12aee5&uid=6&language=cn
}
*/

@end
