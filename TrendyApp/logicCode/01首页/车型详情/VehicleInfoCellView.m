//
//  VehicleInfoCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/2/25.
//  Copyright © 2019 55like. All rights reserved.
//

#import "VehicleInfoCellView.h"
@interface VehicleInfoCellView()
@property (weak, nonatomic) IBOutlet UILabel *lblMoney1;
@property (weak, nonatomic) IBOutlet UILabel *lblMoneyTip1;
@property (weak, nonatomic) IBOutlet UILabel *lblMoney2;
@property (weak, nonatomic) IBOutlet UILabel *lblMoneyTip2;
@property (weak, nonatomic) IBOutlet UILabel *lblMoney3;
@property (weak, nonatomic) IBOutlet UILabel *lblMoneyTip3;
@property (weak, nonatomic) IBOutlet UIView *viewLine;

@property (weak, nonatomic) IBOutlet UIView *viewBG;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblType;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblJL;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewJL;


@end
@implementation VehicleInfoCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _viewLine.backgroundColor=rgbLineColor;
        _viewLine.frame=CGRectMake(15, H(_viewBG)-0.5, kScreenWidth-30, 0.5);
        __weak typeof(self) weakSelf=self;
        [self setAddUpdataBlock:^(id data, id weakme) {
            
            weakSelf.lblMoney1.text=[NSString stringWithFormat:@"￥%@",[data ojsk:@"price_holiday"]];
            weakSelf.lblMoney2.text=[NSString stringWithFormat:@"￥%@",[data ojsk:@"price"]];
            weakSelf.lblMoney3.text=[NSString stringWithFormat:@"-￥%@",[data ojsk:@"price_discounts"]];
            
            weakSelf.lblMoneyTip1.text=kS(@"carDetails", @"priceHoliday");
            weakSelf.lblMoneyTip2.text=kS(@"carDetails", @"priceNormal");
            weakSelf.lblMoneyTip3.text=kS(@"carDetails", @"priceDiscounts");
            if ([[data ojsk:@"discounts_status"] isEqualToString:@"1"]) {//discounts_status    字符串    是否设置2日后优惠 1 设置 未设置
                float fw=(kScreenWidth-40)/3;
                weakSelf.lblMoney3.hidden=NO;
                weakSelf.lblMoneyTip3.hidden=NO;
                weakSelf.lblMoney1.frame=CGRectMake(10, Y(weakSelf.lblMoney1), fw, H(weakSelf.lblMoney1));
                weakSelf.lblMoney2.frame=CGRectMake(fw+20, Y(weakSelf.lblMoney1), fw, H(weakSelf.lblMoney1));
                weakSelf.lblMoney3.frame=CGRectMake(fw*2+30, Y(weakSelf.lblMoney1), fw, H(weakSelf.lblMoney1));
                weakSelf.lblMoneyTip1.frame=CGRectMake(10, Y(weakSelf.lblMoneyTip1), fw, H(weakSelf.lblMoneyTip1));
                weakSelf.lblMoneyTip2.frame=CGRectMake(fw+20, Y(weakSelf.lblMoneyTip1), fw, H(weakSelf.lblMoneyTip1));
                weakSelf.lblMoneyTip3.frame=CGRectMake(fw*2+30, Y(weakSelf.lblMoneyTip1), fw, H(weakSelf.lblMoneyTip1));
            }else{
                float fw=(kScreenWidth-30)/2;
                weakSelf.lblMoney3.hidden=YES;
                weakSelf.lblMoneyTip3.hidden=YES;
                
                weakSelf.lblMoney1.frame=CGRectMake(10, Y(weakSelf.lblMoney1), fw, H(weakSelf.lblMoney1));
                weakSelf.lblMoney2.frame=CGRectMake(fw+20, Y(weakSelf.lblMoney1), fw, H(weakSelf.lblMoney1));
                weakSelf.lblMoneyTip1.frame=CGRectMake(10, Y(weakSelf.lblMoneyTip1), fw, H(weakSelf.lblMoneyTip1));
                weakSelf.lblMoneyTip2.frame=CGRectMake(fw+20, Y(weakSelf.lblMoneyTip1), fw, H(weakSelf.lblMoneyTip1));
            }
            //
            weakSelf.lblType.text=[data ojsk:@"type_str"];
            float fw=[weakSelf.lblType sizeThatFits:CGSizeMake(MAXFLOAT, H(weakSelf.lblType))].width;
            weakSelf.lblType.frameWidth=fw+4;
            
            weakSelf.lblTitle.text=[data ojsk:@"title"];
            float fw_Title=[weakSelf.lblTitle sizeThatFits:CGSizeMake(MAXFLOAT, 20)].width;
            if (fw_Title>kScreenWidth-40-W(weakSelf.lblType)) {
                weakSelf.lblType.frameRX=15;
                weakSelf.lblTitle.frameWidth=X(weakSelf.lblType)-25;
                [weakSelf.lblTitle changeLabelHeight];
            }else{
                weakSelf.lblTitle.frameHeight=20;
                [weakSelf.lblTitle changeLabelWidth];
                weakSelf.lblType.frameX=10+XW(weakSelf.lblTitle);
            }
            weakSelf.lblContent.frameY=YH(weakSelf.lblTitle)+10;
            weakSelf.lblContent.text=[NSString stringWithFormat:@"%@    %@%@km    %@",[data ojsk:@"plate_number"],kS(@"carDetails", @"average"),[data ojsk:@"distance"],[data ojsk:@"deploy_name"]];
            [weakSelf.lblContent changeLabelHeight];
            weakSelf.lblAddress.frameY=YH(weakSelf.lblContent)+10;
            weakSelf.lblJL.frameY=Y(weakSelf.lblAddress);
            weakSelf.imageViewJL.frameY=Y(weakSelf.lblAddress);
            if ([[data ojsk:@"juli"] integerValue]>0) {
//                weakSelf.lblJL.text=[NSString stringWithFormat:@"%@%.2fkm",kS(@"carDetails", @"awayFromYou"),[[data ojsk:@"juli"] floatValue]/1000.0];
                weakSelf.lblJL.text=[NSString stringWithFormat:@"%@%.2fkm",kS(@"carDetails", @"awayFromYou"),[[data ojsk:@"juli"] floatValue]/1000.0];
                [weakSelf.lblJL changeLabelWidth];
                weakSelf.lblJL.frameRX=15;
                weakSelf.imageViewJL.frameRX=W(weakSelf.lblJL)+20;
                weakSelf.lblJL.hidden=NO;
                weakSelf.imageViewJL.hidden=NO;
                weakSelf.lblAddress.frameWidth=X(weakSelf.imageViewJL)-25;
            }else{
                weakSelf.lblJL.hidden=YES;
                weakSelf.imageViewJL.hidden=YES;
                weakSelf.lblAddress.frameWidth=kScreenWidth-30;
            }
//            weakSelf.lblAddress.text=[data ojsk:@"mapaddr"];
            weakSelf.lblAddress.text=[data ojsk:@"user_address"];
            [weakSelf.lblAddress changeLabelHeight];
            weakSelf.viewBG.frameHeight=YH(weakSelf.lblAddress)+15;
            weakSelf.frameHeight=YH(weakSelf.viewBG);
            
            if ([[data ojsk:@"type"] isEqualToString:@"1"]) {
                weakSelf.lblType.textColor=rgb(13,112,161);
                weakSelf.lblType.backgroundColor=RGBACOLOR(13,112,161, 0.1);
            }else{
                weakSelf.lblType.textColor=rgb(244,58,58);
                weakSelf.lblType.backgroundColor=RGBACOLOR(244,58,58, 0.1);
            }
        }];
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
