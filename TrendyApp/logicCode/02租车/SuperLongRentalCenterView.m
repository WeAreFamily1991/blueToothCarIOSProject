//
//  SuperLongRentalCenterView.m
//  TrendyApp
//
//  Created by 55like on 2019/2/21.
//  Copyright © 2019 55like. All rights reserved.
//

#import "SuperLongRentalCenterView.h"
@interface SuperLongRentalCenterView()
{
    
}
@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbDes;
@property (weak, nonatomic) IBOutlet UILabel *lblMoney;
@property (weak, nonatomic) IBOutlet UILabel *lblOld;
@property (weak, nonatomic) IBOutlet UIView *viewLine;

@end
@implementation SuperLongRentalCenterView
- (instancetype)initWithFrame:(CGRect)frame
{
    /*
     "id" : "4",
     "😁___apiStr" : "rental/index >data>list[]",
     "wappath" : "https://h5.trendycarshare.jp/upload/2019-05-17/small_1558070748.jpg",
     "descr" : "賓士AMG GT",
     "ctime_str" : "2019-03-26",
     "mktprice" : "150,000",
     "price" : "120,000",
     "title" : "跑車",
     "isopen" : "1",
     "ctime" : "1553585848",
     "path" : "https://h5.trendycarshare.jp/upload/2019-05-17/small_1558070744.jpg",
     "sort" : "1",
     */
    self = [super initWithFrame:frame];
    if (self) {
        __weak typeof(self) weakSelf=self;
        [self setAddUpdataBlock:^(id data, id weakme) {
            if ([weakSelf getAddValueForKey:@"lblTitle"] == nil) {
                [weakSelf.imageIcon removeFromSuperview];
                [weakSelf.lblTitle removeFromSuperview];
//                [weakSelf.lbDes removeFromSuperview];
                [weakSelf.lblMoney removeFromSuperview];
                [weakSelf.lblOld removeFromSuperview];
                [weakSelf.viewLine removeFromSuperview];
                UIImageView*imgV1=[RHMethods imageviewWithFrame:CGRectMake(55, 20, weakSelf.frameWidth - 110, (kScreenWidth - 110)*151.0/285.0) defaultimage:@"me" supView:weakSelf reuseId:@"imageIcon"];
                UILabel*lbTitle=[RHMethods lableX:20 Y:imgV1.frameYH+10 W:kScreenWidth - 40 Height:20 font:16 superview:weakSelf withColor:rgb(0, 0, 0) text:@"名称" reuseId:@"lblTitle"];
                lbTitle.textAlignment = NSTextAlignmentCenter;
                UILabel*lbDes=[RHMethods lableX:15 Y:0 W:100 Height:25 font:14 superview:weakSelf withColor:rgb(153, 153, 153) text:@"名称" reuseId:@"lblOld"];
                UILabel*lbPrice=[RHMethods lableX:0 Y:0 W:(CGFloat)100 Height:25 font:19 superview:weakSelf withColor:rgbRedColor text:@"名称" reuseId:@"lblMoney"];
                UIView*viewLine=[UIView viewWithFrame:CGRectMake(15, 15, 100, 1) backgroundcolor:rgb(153, 153, 153) superView:weakSelf reuseId:@"viewLine"];
                weakSelf.imageIcon = imgV1;
                weakSelf.lblTitle = lbTitle;
                weakSelf.lblOld = lbDes;
                weakSelf.lblMoney = lbPrice;
                weakSelf.viewLine = viewLine;
            }
            
            [weakSelf.imageIcon imageWithURL:[data ojsk:@"wappath"]];
//            weakSelf.lblTitle.text=[data ojsk:@"descr"];
            weakSelf.lblTitle.text=[NSString stringWithFormat:@"%@",[data ojsk:@"descr"]];
            weakSelf.lblTitle.frameWidth = self.frameWidth - 60;
            weakSelf.lblTitle.numberOfLines = 0;
            weakSelf.lblTitle.frameHeight = [weakSelf.lblTitle.text HEIGHTwF:weakSelf.lblTitle.font.pointSize W:weakSelf.lblTitle.frameWidth];
            [weakSelf.lblTitle beCX];
            
            weakSelf.lblMoney.frameY = weakSelf.lblTitle.frameYH + 10;
            weakSelf.lblOld.centerY = weakSelf.lblMoney.centerY;
            weakSelf.frameHeight = weakSelf.lblMoney.frameYH + 15;
            weakSelf.viewLine.centerY = weakSelf.lblOld.centerY;
            NSString *strOld=[NSString stringWithFormat:kS(@"longRental", @"ioslongRentalTip1"),[data ojsk:@"mktprice"]];
            float ftW=0;
            if ([[data ojsk:@"mktprice"] notEmptyOrNull]) {
                weakSelf.lblOld.text=strOld;
                weakSelf.lblOld.hidden=NO;
                weakSelf.viewLine.hidden=NO;
                [weakSelf.lblOld changeLabelWidth];
                ftW+=weakSelf.lblOld.frameWidth+15;
            }else{
                weakSelf.lblOld.hidden=YES;
                weakSelf.viewLine.hidden=YES;
            }
            NSString *strNew=[NSString stringWithFormat:kS(@"longRental", @"ioslongRentalTip1"),[data ojsk:@"price"]];
            weakSelf.lblMoney.text=strNew;
            [weakSelf.lblMoney changeLabelWidth];
            ftW+=weakSelf.lblMoney.frameWidth;
            if ([[data ojsk:@"mktprice"] notEmptyOrNull]) {
                weakSelf.lblOld.frameX=(W(weakSelf)-ftW)/2;
                weakSelf.viewLine.frame=CGRectMake(X(weakSelf.lblOld), Y(weakSelf.viewLine), W(weakSelf.lblOld), 1);
                weakSelf.lblMoney.frameX=XW(weakSelf.lblOld)+15;
            }else{
                weakSelf.lblMoney.frameX=(W(weakSelf)-ftW)/2;
            }
            
            
        }];
        [self upDataMeWithData:@{}];
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
