//
//  OrderDetailViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/26.
//  Copyright © 2019 55like. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "MYRHTableView.h"
#import "OrderHomeSmallCellView.h"
#import "OrderHomeSmallTimeCellView.h"
#import "OrderBtnListCellView.h"
#import "ApplicationDetailsViewController.h"
@interface OrderDetailViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong) UIView*viewfoot;
@end

@implementation  OrderDetailViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDATA];
//    [self addView];
}
#pragma mark -   write UI
-(void)addView{
      __weak __typeof(self) weakSelf = self;
    [_mtableView removeFromSuperview];
    [_viewfoot removeFromSuperview];
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
//头像姓名
//    if ([[self.data ojsk:@"type"] isEqualToString:@"1"]) {
    {
        NSDictionary *dicUser=[self.data ojk:@"caruserinfo"];
        if ([self.otherInfo isEqualToString:@"userCenter"]) {
            dicUser=[self.data ojk:@"userinfo"];
        }
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 52) backgroundcolor:rgb(255, 255, 255) superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        
        UIImageView*imgVIcon=[RHMethods imageviewWithFrame:CGRectMake(15, 11, 30, 30) defaultimage:@"photo" supView:viewContent];
        [imgVIcon imageWithURL:[dicUser ojsk:@"icon"] useProgress:NO useActivity:NO defaultImage:nil];
        [imgVIcon beCY];
        [imgVIcon beRound];
        
        UILabel*lbName =[RHMethods lableX:imgVIcon.frameXW+11 Y:0 W:kScreenWidth*0.5 Height:viewContent.frameHeight font:16 superview:viewContent withColor:rgb(51, 51, 51) text:[dicUser ojsk:@"nickname"]];
        lbName.numberOfLines=1;
         WSSizeButton*btnContact=[RHMethods buttonWithframe:CGRectMake(0, 0, 99, 30) backgroundColor:nil text:kS(@"order_detail", @"ContactTA") font:14 textColor:rgb(13, 107, 153) radius:3 superview:viewContent];
        [btnContact setImageStr:@"noticeblue" SelectImageStr:nil];
        [btnContact setBtnImageViewFrame:CGRectMake(15, 7, 16, 16)];
        float width=[btnContact.currentTitle widthWithFont:14]+3;
        
        [btnContact setBtnLableFrame:CGRectMake(38, 0, width, btnContact.frameHeight)];
        btnContact.frameWidth=btnContact.lbframeXW+15;
        btnContact.layer.borderColor=rgb(13, 107, 153 ).CGColor;
        btnContact.layer.borderWidth=1;
        btnContact.frameRX=15;
        [btnContact beCY];
          __weak __typeof(self) weakSelf = self;
        [btnContact addViewClickBlock:^(UIView *view) {
            [kUtility_Login chatWithUser:weakSelf.data withCar:[weakSelf.otherInfo isEqualToString:@"userCenter"]];
        }];
        
        if ([[self.data ojsk:@"type"] isEqualToString:@"1"]) {
            imgVIcon.hidden=NO;
            lbName.hidden=NO;
        }else{
            lbName.hidden=NO;
            imgVIcon.hidden=NO;
        }
    }
//    車輛信息
    {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 100) backgroundcolor:rgbwhiteColor superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        
        OrderHomeSmallCellView*viewCell=[OrderHomeSmallCellView viewWithFrame:CGRectMake(0, 0, 0, 0) backgroundcolor:nil superView:viewContent];
        
        OrderHomeSmallTimeCellView*viewCell2=[OrderHomeSmallTimeCellView viewWithFrame:CGRectMake(0, viewCell.frameYH, 0, 0) backgroundcolor:nil superView:viewContent];
        
        viewContent.frameHeight=viewCell2.frameYH;
        UIView*viewLine=[UIView viewWithFrame:CGRectMake(15,viewContent.frameHeight, kScreenWidth-30, 1) backgroundcolor:rgb(238, 238, 238) superView:viewContent];
        viewLine.frameBY=0;
        [viewCell upDataMeWithData:self.data];
        [viewCell2 upDataMeWithData:self.data];
        
        
//        {
//
//            NSArray*arrayTitle=@[@"車齡租金",@"上門費用",@"平台保障費",@"手續費",@"保險費",@"積分抵扣"];
//
//            NSArray*arrayPrice=@[@"1500元",@"1340元",@"180元",@"50元",@"540元",@"-20元",];
//
//            NSArray*arraySubPrice=@[@"499元*3天",@"5~10公里",@"60元*3天",@"",@"60元*3人*3天",@""];
//            for (int i=0; i<arrayTitle.count; i++) {
//                UILabel*lbTitle=[RHMethods lableX:15 Y:viewLine.frameYH+15+i*24 W:0 Height:13 font:13 superview:viewContent withColor:rgb(153, 153, 153) text:arrayTitle[i]];
//                UILabel*lbPrice=[RHMethods RlableRX:15 Y:lbTitle.frameY W:0 Height:13 font:13 superview:viewContent withColor:rgb(51, 51, 51) text:arrayPrice[i]];
//                 UILabel*lbSubPrice=[RHMethods RlableRX:viewContent.frameWidth-lbPrice.frameX+10 Y:0 W:0 Height:13 font:13 superview:viewContent withColor:rgb(153, 153, 153) text:arraySubPrice[i]];
//                lbSubPrice.centerY=lbPrice.centerY=lbTitle.centerY;
//                if (i==arrayTitle.count-1) {
//                    viewContent.frameHeight=lbTitle.frameYH+15;
//                }
//            }
//        }
//         NSArray*arrayTitle=@[@"車齡租金",@"上門費用",@"平台保障費",@"手續費",@"保險費",@"積分抵扣"];
        NSArray*arraytitle=@[
                             @{
                                 @"name":kS(@"order_detail", @"price_item_car"),
                                 @"value":[self.data ojsk:@"rentprice"],
                                 @"unit":@"￥",
                                 },
                             @{
                                 @"name":kS(@"order_detail", @"price_item_door_price"),
                                 @"value":[self.data ojsk:@"doorprice"],
                                 @"unit":@"￥",
                                 },
                             @{
                                 @"name":kS(@"order_detail", @"price_item_guarantee_price"),
                                 @"value":[self.data ojsk:@"guaranteeprice"],
                                 @"unit":@"￥",
                                 },
                             @{
                                 @"name":kS(@"order_detail", @"price_item_procedures_price"),
                                 @"value":[self.data ojsk:@"proceduresprice"],
                                 @"unit":@"￥",
                                 },
                             @{
                                 @"name":kS(@"order_detail", @"price_item_insurer_price"),
                                 @"value":[self.data ojsk:@"insurerprice"],
                                 @"unit":@"￥",
                                 },
                             @{
                                 @"name":kS(@"order_detail", @"price_item_point_price"),
                                 @"value":[[self.data ojsk:@"pointprice"] notEmptyOrNull]?[NSString stringWithFormat:@"%@",[self.data ojsk:@"pointprice"]]:@"",
                                 @"unit":@"-￥",
                                 },
                             @{
                                 @"name":kS(@"order_detail", @"price_item_favorable_price"),
                                 @"value":[[self.data ojsk:@"preferentialprice"] notEmptyOrNull]?[NSString stringWithFormat:@"%@",[self.data ojsk:@"preferentialprice"]]:@"",
                                 @"unit":@"-￥",
                                 },
                             ];
        
        UIView*contentListView=[self loadRightListViewWithArray:[arraytitle toBeMutableObj]];
        contentListView.frameY=viewContent.frameHeight+10;
        [viewContent addSubview:contentListView];
        viewContent.frameHeight=contentListView.frameYH+5;
        
        UIView*viewLine2=[UIView viewWithFrame:CGRectMake(15, viewContent.frameHeight, kScreenWidth-30, 1) backgroundcolor:rgb(238, 238, 238) superView:viewContent];
         UILabel*lbfinalPrice=[RHMethods RlableRX:15 Y:viewLine2.frameYH W:kScreenWidth-30 Height:55 font:18 superview:viewContent withColor:rgb(244, 58, 58) text:[NSString stringWithFormat:@"%@￥%@",kS(@"order_detail", @"pay_really"),[self.data ojsk:@"payableprice"]]];
        [lbfinalPrice setColor:rgb(51, 51, 51) contenttext:kS(@"order_detail", @"pay_really")];
        viewContent.frameHeight=lbfinalPrice.frameYH+5;
        
    }
    //提前还车信息
    if ([[self.data ojsk:@"advance"] isEqualToString:@"1"]) {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 100) backgroundcolor:rgb(255, 255, 255) superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        UILabel*lbName=[RHMethods lableX:15 Y:15 W:0 Height:14 font:14 superview:viewContent withColor:rgb(51, 51, 51) text:kS(@"order_detail", @"advance_info")];//提前還車信息
        NSArray*arraytitle=@[
                             @{
                                 @"name":kS(@"order_detail", @"advance_item_time"),
                                 @"value":[self.data ojsk:@"advancetime_str"],
                                 },
                             
                             ];
        UIView*contentListView=[self loadRightListViewWithArray:[arraytitle toBeMutableObj]];
        contentListView.frameY=lbName.frameYH+13;
        [viewContent addSubview:contentListView];
        viewContent.frameHeight=contentListView.frameYH+5;
        [viewContent addViewClickBlock:^(UIView *view) {
            //                [weakSelf pushController:[ApplicationDetailsViewController class] withInfo:weakSelf.userInfo withTitle:@"申请详情"];
            [weakSelf pushController:[ApplicationDetailsViewController class] withInfo:weakSelf.userInfo withTitle:kST(@"apply_detail") withOther:@"advance"];//提前还车
        }];
  
    }
    //延长用车信息
    if ([[[self.data ojk:@"extendinfo"] ojsk:@"status"] notEmptyOrNull]) {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 100) backgroundcolor:rgb(255, 255, 255) superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        UILabel*lbName=[RHMethods lableX:15 Y:15 W:0 Height:14 font:14 superview:viewContent withColor:rgb(51, 51, 51) text:kS(@"order_detail", @"extend_info")];
        NSArray*arraytitle=@[
                             @{
                                 @"name":kS(@"order_detail", @"extend_item_time"),
                                 @"value":[self.data ojsk:@"extendtime_str"],
                                 },
                         
                             ];
        
        if([[[self.data ojk:@"extendinfo"] ojsk:@"status"] isEqualToString:@"2"]){
           NSMutableArray*marraytitle=  [NSMutableArray arrayWithArray:arraytitle];
            [marraytitle addObjectsFromArray:@[@{
                                                   @"name":kS(@"order_detail", @"price_item_car"),
                                                   @"value":[[self.data ojk:@"extendinfo"] ojsk:@"rentprice"],
                                                   @"unit":@"￥",
                                                   },
                                               @{
                                                   @"name":kS(@"order_detail", @"price_item_insurer_price"),
                                                   @"value":[[self.data ojk:@"extendinfo"] ojsk:@"insurerprice"],
                                                   @"unit":@"￥",
                                                   },
                                               @{
                                                   @"name":kS(@"order_detail", @"price_item_favorable_price"),
                                                   @"value":[[[self.data ojk:@"extendinfo"] ojsk:@"preferentialprice"] notEmptyOrNull]?[NSString stringWithFormat:@"%@",[[self.data ojk:@"extendinfo"] ojsk:@"preferentialprice"]]:@"",
                                                   @"unit":@"-￥",
                                                   },]];
            
            
            arraytitle=marraytitle;
        }else{
            [viewContent addViewClickBlock:^(UIView *view) {
//                [weakSelf pushController:[ApplicationDetailsViewController class] withInfo:weakSelf.userInfo withTitle:@"申请详情"];
                [weakSelf pushController:[ApplicationDetailsViewController class] withInfo:weakSelf.userInfo withTitle:kST(@"apply_detail") withOther:@"extend"];//延長還車
            }];
        }
        
        UIView*contentListView=[self loadRightListViewWithArray:[arraytitle toBeMutableObj]];
        contentListView.frameY=lbName.frameYH+13;
        [viewContent addSubview:contentListView];
        viewContent.frameHeight=contentListView.frameYH+5;
        
        if([[[self.data ojk:@"extendinfo"] ojsk:@"status"] isEqualToString:@"2"]){
            UIView*viewLine2=[UIView viewWithFrame:CGRectMake(15, viewContent.frameHeight, kScreenWidth-30, 1) backgroundcolor:rgb(238, 238, 238) superView:viewContent];
            UILabel*lbfinalPrice=[RHMethods RlableRX:15 Y:viewLine2.frameYH W:kScreenWidth-30 Height:55 font:18 superview:viewContent withColor:rgb(244, 58, 58) text:[NSString stringWithFormat:@"%@￥%@",kS(@"order_detail", @"pay_really"),[[self.data ojk:@"extendinfo"] ojsk:@"payableprice"]]];
            [lbfinalPrice setColor:rgb(51, 51, 51) contenttext:kS(@"order_detail", @"pay_really")];
            viewContent.frameHeight=lbfinalPrice.frameYH+5;
        }
    }
    //备注信息
    if ([[self.data ojk:@"remark"] notEmptyOrNull]) {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 100) backgroundcolor:rgb(255, 255, 255) superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        UILabel*lbName=[RHMethods lableX:15 Y:15 W:0 Height:14 font:14 superview:viewContent withColor:rgb(51, 51, 51) text:kS(@"order_detail", @"remark")];
        UILabel*lbRemark=[RHMethods lableX:15 Y:lbName.frameYH+13 W:kScreenWidth-30 Height:0 font:13 superview:viewContent withColor:rgb(153, 153, 153) text:[self.data ojk:@"remark"]];
        viewContent.frameHeight=lbRemark.frameYH+13;
    }
    
    //保险信息
    if ([[self.data ojk:@"mastername"] notEmptyOrNull]) {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 100) backgroundcolor:rgb(255, 255, 255) superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        UILabel*lbName=[RHMethods lableX:15 Y:15 W:0 Height:14 font:14 superview:viewContent withColor:rgb(51, 51, 51) text:kS(@"order_detail", @"insurance_info")];
        NSMutableArray*arraytitle=[
                                   @[
                                     @{
                                         @"name":kS(@"order_detail", @"insurance_person"),
                                         @"value":[self.data ojsk:@"mastername"],
                                         },
                                     @{
                                         @"name":kS(@"order_detail", @"append_insurance_person"),
                                         @"value":[self.data ojsk:@"appendname"],
                                         },
                                     @{
                                         @"name":kS(@"order_detail", @"insurance_person_number"),
                                         @"value":[self.data ojsk:@"masternumbers"],
                                         },
                                     @{
                                         @"name":kS(@"order_detail", @"append_insurance_person_number"),
                                         @"value":[self.data ojsk:@"appendnumbers"],
                                         },
                                     ] toBeMutableObj
                                   ];
        
        
        UIView*contentListView=[self loadRightListViewWithArray:[arraytitle toBeMutableObj]];
        contentListView.frameY=lbName.frameYH+13;
        [viewContent addSubview:contentListView];
        viewContent.frameHeight=contentListView.frameYH+5;
    }
    //追加保险信息
    if ([[self.data ojk:@"appendarr"] count]) {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 100) backgroundcolor:rgb(255, 255, 255) superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        UILabel*lbName=[RHMethods lableX:15 Y:15 W:0 Height:14 font:14 superview:viewContent withColor:rgb(51, 51, 51) text:kS(@"order_detail", @"append_insurance_info")];
        NSMutableArray*nameArray=[NSMutableArray new];
        NSMutableArray*numbersArray=[NSMutableArray new];
//        NSMutableArray*priceArray=[NSMutableArray new];
        float price=0.0;
        
        for (NSMutableDictionary*mdic in [self.data ojk:@"appendarr"]) {
            if ([[mdic ojk:@"name"] notEmptyOrNull]) {
                [nameArray addObject:[mdic ojk:@"name"]];
            } if ([[mdic ojk:@"numbers"] notEmptyOrNull]) {
                [numbersArray addObject:[mdic ojk:@"numbers"]];
            } if ([[mdic ojsk:@"price"] notEmptyOrNull]) {
                price+=[mdic ojsk:@"price"].noformPriceStr.floatValue;
//                [priceArray addObject:[mdic ojk:@"price"]];
            }
            
        }
//        NSMutableDictionary*mdic=[[self.data ojk:@"appendarr"] firstObject];
        
        NSString*strPrice=[NSString stringWithFormat:@"%.0f",price];
        NSMutableArray*arraytitle=[
                                   @[
                                     @{
                                         @"name":kS(@"order_detail", @"append_insurance_person"),
                                         @"value":[nameArray componentsJoinedByString:@","],
                                         },
                                     @{
                                         @"name":kS(@"order_detail", @"insurance_person_number"),
                                         @"value":[numbersArray componentsJoinedByString:@","],
                                         },
                                     @{
                                         @"name":kS(@"order_detail", @"price_item_insurer_price"),
//                                         @"value":[NSString stringWithFormat:@"￥%.2f",price],
                                         @"value":[NSString stringWithFormat:@"￥%@",strPrice.formPriceStr],
                                         },
                                     ] toBeMutableObj
                                   ];

        UIView*contentListView=[self loadRightListViewWithArray:[arraytitle toBeMutableObj]];
        contentListView.frameY=lbName.frameYH+5;
        [viewContent addSubview:contentListView];
        viewContent.frameHeight=contentListView.frameYH+5;
    }

    
    
//    //訂單信息
//    {
//        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 100) backgroundcolor:rgb(255, 255, 255) superView:nil];
//        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
//
//        UILabel*lbName=[RHMethods lableX:15 Y:15 W:0 Height:14 font:14 superview:viewContent withColor:rgb(51, 51, 51) text:@"訂單信息"];
//
//        NSArray*arrayTitle=@[@"訂單編號",@"申請時間",@"預定時間",@"付款時間",@"付款方式",@"完成時間",];
//
//        NSArray*arraySubTitle=@[@"201809120021",@"2018.09.12 17:12:02",@"2018.09.12 17:12:02",@"2018.09.12 17:12:55",@"微信支付",@"2018.09.12 17:12:55"];
//
//
//        for (int i=0; i<arrayTitle.count; i++) {
//            UILabel*lbTitle=[RHMethods lableX:15 Y:lbName.frameYH+15+i*24 W:0 Height:13 font:13 superview:viewContent withColor:rgb(51, 51, 51) text:[NSString stringWithFormat:@"%@:%@",arrayTitle[i],arraySubTitle[i]]];
//            [lbTitle setColor:rgb(153, 153, 153) contenttext:[NSString stringWithFormat:@"%@:",arrayTitle[i]]];
//            if (i==arrayTitle.count-1) {
//                viewContent.frameHeight=lbTitle.frameYH+15;
//            }
//        }
//    }
    
    //訂單信息
   {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 100) backgroundcolor:rgb(255, 255, 255) superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        UILabel*lbName=[RHMethods lableX:15 Y:15 W:0 Height:14 font:14 superview:viewContent withColor:rgb(51, 51, 51) text:kS(@"order_detail", @"order_info")];
        NSMutableArray*arraytitle=[
                                   @[
                                     @{
                                         @"name":kS(@"order_detail", @"order_number"),
                                         @"value":[self.data ojsk:@"orderid"],
                                         },
                                     @{
                                         @"name":kS(@"order_detail", @"apply_time"),
                                         @"value":[self.data ojsk:@"time_str"],
                                         },
                                     @{
                                         @"name":kS(@"order_detail", @"booking_time"),
                                         @"value":[self.data ojsk:@"starttime_strs"],
                                         },
                                     @{
                                         @"name":kS(@"order_detail", @"pay_time"),
                                         @"value":[self.data ojsk:@"paytime_str"],
                                         },
                                     @{
                                         @"name":kS(@"order_detail", @"pay_way"),
                                         @"value":[self.data ojsk:@"paytype_str"],
                                         },
                                     ] toBeMutableObj
                                   ];
        
        
        UIView*contentListView=[self loadLeftListViewWithArray:[arraytitle toBeMutableObj]];
        contentListView.frameY=lbName.frameYH+10;
        [viewContent addSubview:contentListView];
        viewContent.frameHeight=contentListView.frameYH+5;
    }
    
    {
        _mtableView.frameHeight=_mtableView.frameHeight-49-kIphoneXBottom;
        UIView*viewfoot=[UIView viewWithFrame:CGRectMake(0, _mtableView.frameYH, kScreenWidth, 49) backgroundcolor:rgbwhiteColor superView:self.view];
        _viewfoot=viewfoot;
        /*UIView*viewLine=*/[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 1) backgroundcolor:RGBACOLOR(238, 238, 238, 0.8) superView:viewfoot];
        UILabel*lbStatus=[RHMethods lableX:15 Y:0 W:150 Height:viewfoot.frameHeight font:14 superview:viewfoot withColor:rgb(13, 107, 154) text:[self.data ojsk:@"statusname"]];
         OrderBtnListCellView*viewBtnList=[OrderBtnListCellView viewWithFrame:CGRectMake(0, 10, 0, 0) backgroundcolor:nil superView:viewfoot];
        [viewBtnList upDataMeWithData:[self.data ojsk:@"buttonlist"]];
        viewBtnList.statusLable.text=[self.data ojsk:@"buttonname"];
        [viewBtnList addBaseViewTarget:self select:@selector(cellBtnClick:)];
        viewfoot.frameHeight+=kIphoneXBottom;
        
    }
    
    
    
}
-(void)cellBtnClick:(OrderBtnListCellView*)viewcell{
    __weak __typeof(self) weakSelf = self;
    
    if ([self.otherInfo isEqualToString:@"userCenter"]) {
        [kUserCenterService orderActionWithOrderData:self.data WithActionType:[[viewcell.eventView data] ojsk:@"action"] withBlock:^(id data, int status, NSString *msg) {
            [weakSelf loadDATA];
            if (status==200) {
                weakSelf.allcallBlock?weakSelf.allcallBlock(nil,200,nil):nil;
            }
        }];
    }else{
        [kOrderService orderActionWithOrderData:self.data WithActionType:[[viewcell.eventView data] ojsk:@"action"] withBlock:^(id data, int status, NSString *msg) {
            [weakSelf loadDATA];
            if (status==200) {
                weakSelf.allcallBlock?weakSelf.allcallBlock(nil,200,nil):nil;
            }
        }];
    }
}
-(UIView*)loadRightListViewWithArray:(NSMutableArray*)arrayTitle{
    UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 0) backgroundcolor:rgb(255, 255, 255) superView:nil];
    //    [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
    float my_y=3.0;
    
    for (int i=0; i<arrayTitle.count; i++) {
        NSMutableDictionary*dic=arrayTitle[i];
        //        [dic setObject:@"dfadf" forKey:@"value"];
        if (![[dic ojsk:@"value"] notEmptyOrNull]||([[dic ojsk:@"value"] floatValue]==0&&[dic ojsk:@"value"].length==1)) {
            continue;
        }
        if (![[dic ojsk:@"value"] notEmptyOrNull]) {
            continue;
        }
        NSString*valueStr=[dic ojsk:@"value"];
        if ([[dic ojsk:@"unit"] notEmptyOrNull]) {
            valueStr=[NSString stringWithFormat:@"%@%@",[dic ojsk:@"unit"],valueStr];
        }
        UILabel*lbTitle=[RHMethods lableX:15 Y:my_y W:0 Height:13 font:13 superview:viewContent withColor:rgb(153, 153, 153) text:[dic ojsk:@"name"]];
        UILabel*lbPrice=[RHMethods RlableRX:15 Y:lbTitle.frameY W:0 Height:13 font:13 superview:viewContent withColor:rgb(51, 51, 51) text:valueStr];
        lbPrice.centerY=lbTitle.centerY;
        my_y=my_y+24;
    }
    viewContent.frameHeight=my_y;
    return viewContent;
}

-(UIView*)loadLeftListViewWithArray:(NSMutableArray*)arrayTitle{
    UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 0) backgroundcolor:rgb(255, 255, 255) superView:nil];
    //    [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
    float my_y=3.0;
    for (int i=0; i<arrayTitle.count; i++) {
        NSMutableDictionary*dic=arrayTitle[i];
        //        [dic setObject:@"dfadf" forKey:@"value"];
        //        if (![[dic ojsk:@"value"] notEmptyOrNull]||([[dic ojsk:@"value"] floatValue]==0&&[[dic ojsk:@"value"] rangeOfString:@"0"].length)) {
        if (![[dic ojsk:@"value"] notEmptyOrNull]) {
            continue;
        }
        UILabel*lbTitle=[RHMethods lableX:15 Y:my_y W:0 Height:13 font:13 superview:viewContent withColor:rgb(153, 153, 153) text:[dic ojsk:@"name"]];
        UILabel*lbPrice=[RHMethods lableX:lbTitle.frameXW+4 Y:lbTitle.frameY W:0 Height:13 font:13 superview:viewContent withColor:rgb(51, 51, 51) text:[dic ojsk:@"value"]];
        lbPrice.centerY=lbTitle.centerY;
        my_y=my_y+24;
    }
    viewContent.frameHeight=my_y;
    return viewContent;
}
#pragma mark  request data from the server use tableview

#pragma mark - request data from the server
-(void)loadDATA{
    NSMutableDictionary*mdic=[NSMutableDictionary new];
    [mdic setObject:self.userInfo forKey:@"orderid"];
      __weak __typeof(self) weakSelf = self;
    if ([self.otherInfo isEqualToString:@"userCenter"]) {
        [kCarCenterService order_orderdetails:mdic withBlock:^(id data, int status, NSString *msg) {
            weakSelf.data=data;
            [weakSelf addView];
        }];
    }else{
        [kOrderService order_details:mdic withBlock:^(id data, int status, NSString *msg) {
            weakSelf.data=data;
            [weakSelf addView];
        }];
    }
    

    
}
#pragma mark - event listener function


#pragma mark - delegate function


@end
