//
//  CarListCellView.m
//  TrendyApp
//
//  Created by 55like on 2019/2/22.
//  Copyright © 2019 55like. All rights reserved.
//

#import "CarListCellView.h"
#import "CarlistOrderSettingViewController.h"
#import "CostSettingViewController.h"
#import "ScarRegistrationListViewController.h"
#import "UnRentableTimeViewController.h"
#import "PlaceOfDeliveryViewController.h"
#import "UserEvaluationViewController.h"
@interface CarListCellView()
{
    
}
@property (weak, nonatomic) IBOutlet UIImageView *mainphoto;
@property (weak, nonatomic) IBOutlet UILabel *auditStatusLable;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *describeLable;
@property (weak, nonatomic) IBOutlet UILabel *collectionLable;
@property (weak, nonatomic) IBOutlet UILabel *seeLable;

@property (weak, nonatomic) IBOutlet UILabel *timeLable;

@property (weak, nonatomic) IBOutlet UILabel *item1Lable;
@property (weak, nonatomic) IBOutlet UILabel *item2Lable;
@property (weak, nonatomic) IBOutlet UILabel *item3Lable;
@property (weak, nonatomic) IBOutlet UILabel *item4Lable;
@property (weak, nonatomic) IBOutlet UIView *item1View;
@property (weak, nonatomic) IBOutlet UIView *item2View;
@property (weak, nonatomic) IBOutlet UIView *item3View;
@property (weak, nonatomic) IBOutlet UIView *item4View;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (weak, nonatomic) IBOutlet UILabel *priceDiscribeLable;
@property (weak, nonatomic) IBOutlet UILabel *commentLable;
@property (weak, nonatomic) IBOutlet UILabel *commentDiscribeLable;
@property (weak, nonatomic) IBOutlet UIView *ContentView;
@end
@implementation CarListCellView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.item1Lable.text=kS(@"CarList", @"PlaceOfDelivery");
        self.item2Lable.text=kS(@"CarList", @"NonRentableTime");
        self.item3Lable.text=kS(@"CarList", @"ScarRegistration");
        self.item4Lable.text=kS(@"CarList", @"OrderSetting");
        self.priceDiscribeLable.text=kS(@"CarList", @"AccumulatedIncomeYuan");
        self.commentDiscribeLable.text=kS(@"CarList", @"EvaluationArticle");
        
        [self.item4View addViewTarget:self select:@selector(baseOrderSetting)];
        [self.item2View addViewTarget:self select:@selector(costSetting)];
        [self.item3View addViewTarget:self select:@selector(ScarRegist)];
        [self.item1View addViewTarget:self select:@selector(PlaceOfDelivery)];
        
        [self.ContentView addViewClickBlock:^(UIView *view) {
            
        }];
          __weak __typeof(self) weakSelf = self;
        [self setAddUpdataBlock:^(id data, id weakme) {
            [weakSelf.mainphoto imageWithURL:[data ojsk:@"path"]];
            weakSelf.titleLable.text=[data ojsk:@"title"];
            weakSelf.auditStatusLable.text=[data ojsk:@"status_name"];
            weakSelf.seeLable.text=[data ojsk:@"hits"];
            weakSelf.collectionLable.text=[data ojsk:@"favnum"];
            
            weakSelf.auditStatusLable.backgroundColor=rgbHexColor([data ojsk:@"status_color"]) ;
            weakSelf.describeLable.text=[data ojsk:@"plate_number"];
            weakSelf.timeLable.text=[NSString stringWithFormat:@"%@:￥%@      %@:￥%@",kS(@"CarList", @"Weekdays"),[data ojsk:@"price"],kS(@"CarList", @"Festivals"),[data ojsk:@"price_holiday"]];
            [weakSelf.timeLable setColor:rgb(153, 153, 153) contenttext:[NSString stringWithFormat:@"%@:",kS(@"CarList", @"Weekdays")]];
            [weakSelf.timeLable setColor:rgb(153, 153, 153) contenttext:[NSString stringWithFormat:@"%@:",kS(@"CarList", @"Festivals")]];
            
            weakSelf.priceLable.text=[NSString stringWithFormat:@"￥%@",[data ojsk:@"orderprice"]];
            weakSelf.commentLable.text=[NSString stringWithFormat:@"%@",[data ojsk:@"commentnum"]];
        }];
       
    }
    return self;
}
-(void)costSetting{
      __weak __typeof(self) weakSelf = self;
    
    
    //kS(@"CarList", @"NonRentableTime")
    [UTILITY.currentViewController pushController:[UnRentableTimeViewController class] withInfo:[self.data ojsk:@"id"] withTitle:kST(@"cant_rent_time") withOther:self.data withAllBlock:^(id data, int status, NSString *msg) {
        [weakSelf baseViewButtonClick:weakSelf];//
    }];
//    [UTILITY.currentViewController pushController:[CostSettingViewController class] withInfo:self.data withTitle:kST(@"CostSetting") withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
//        [weakSelf baseViewButtonClick:weakSelf];
//    }];
    
}
-(void)baseOrderSetting{
    
    [UTILITY.currentViewController pushController:[CarlistOrderSettingViewController class] withInfo:[self.data ojsk:@"id"] withTitle:kST(@"OrderSetting") withOther:nil];
    
}
-(void)ScarRegist{
    
    [UTILITY.currentViewController pushController:[ScarRegistrationListViewController class] withInfo:[self.data ojsk:@"id"] withTitle:kST(@"WoundRecord") withOther:nil];
    
    
}
-(void)PlaceOfDelivery{
      __weak __typeof(self) weakSelf = self;
    [UTILITY.currentViewController pushController:[PlaceOfDeliveryViewController class] withInfo:[self.data ojsk:@"drop_off_id"] withTitle:kST(@"PlaceOfDelivery") withOther:[self.data ojsk:@"id"] withAllBlock:^(id data, int status, NSString *msg) {
         [weakSelf baseViewButtonClick:weakSelf];
    }];
    
    
}
- (IBAction)CommentClickAction:(UIButton *)sender {
//    __weak __typeof(self) weakSelf = self;
    [UTILITY.currentViewController pushController:[UserEvaluationViewController class] withInfo:[self.data ojsk:@"id"] withTitle:kS(@"userComment", @"CommentTitle") withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
//        [weakSelf baseViewButtonClick:weakSelf];
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
