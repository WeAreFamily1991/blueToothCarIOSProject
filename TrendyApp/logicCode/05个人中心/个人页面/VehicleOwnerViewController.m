//
//  VehicleOwnerViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/28.
//  Copyright © 2019 55like. All rights reserved.
//

#import "VehicleOwnerViewController.h"
#import "MyVehicleCellView.h"
#import "MYRHTableView.h"
#import "OrderHomeCellView.h"
#import "UploadVeicleViewController.h"
#import "CarListViewController.h"
#import "LJImageRollingView.h"
#import "PerconalAllOrderListViewController.h"
#import "OrderDetailViewController.h"
#import "OrderDetailViewController.h"
#import "VehicleDetailsViewController.h"
@interface VehicleOwnerViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)UIView*viewHeader;
@property(nonatomic,strong)UIView*viewContent;
@property(nonatomic,strong)SectionObj*orderObj;
@end

@implementation  VehicleOwnerViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
//    [self loadDATA];
    [self request];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([[UTILITY getAddValueForKey:@"updataCarInfo"] isEqualToString:@"1"]) {
        [UTILITY removeAddValueForkey:@"updataCarInfo"];
//        [self loadDATA];
        
        [self request];
    }
}
#pragma mark -   write UI
-(void)addView{
    __weak __typeof(self) weakSelf = self;
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
//    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
//        UIView*viewcell=[UIView viewWithFrame:CGRectMake(0, 0, 0, 0) backgroundcolor:nil superView:reuseView reuseId:@"viewcell"];
//        r⁄⁄⁄€eturn viewcell;
//    }];
    //顶部页面
    {
        UIView*viewHeader=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 258-150+(kScreenWidth-30)*150.0/(375-30.0)) backgroundcolor:rgb(255, 255, 255) superView:nil];
        _viewHeader=viewHeader;
        [self.mtableView.defaultSection.noReUseViewArray addObject:viewHeader];
        //        LJImageRollingView*imgVBanner=[LJImageRollingView imageviewWithFrame:CGRectMake(15, 0, kScreenWidth-30, 150) defaultimage:@"photo" supView:viewHeader];
        //        LJImageRollingView*imgVBanner=[LJImageRollingView viewWithFrame:CGRectMake(15, 0, kScreenWidth-30, 150) backgroundcolor:nil superView:viewHeader];
        
        UIImageView*imgVBanner=[RHMethods imageviewWithFrame:CGRectMake(15, 5, kScreenWidth-30,(kScreenWidth-30)*150.0/(375-30.0) ) defaultimage:@"photo" supView:viewHeader];
        imgVBanner.backgroundColor=RGBACOLOR(238, 238, 238, 0.6);
        imgVBanner.layer.cornerRadius=5;
        float width = kScreenWidth*0.3333333;
        [viewHeader setAddUpdataBlock:^(id data, id weakme) {
//            [imgVBanner imageWithURL:[weakSelf.data ojsk:@"path"]];
            [imgVBanner imageWithURL:[weakSelf.data ojsk:@"wappath"]];
            ////            NSArray*array=[[weakSelf.data ojsk:@"path"] componentsSeparatedByString:@","];
            //            NSArray*array=[NSArray arrayWithObject:[weakSelf.data ojsk:@"path"]];
            //            NSMutableArray*marray=[NSMutableArray new];
            //            for (int i=0; i<array.count; i++) {
            //                NSMutableDictionary*mdic=[NSMutableDictionary new];
            //                [mdic setObject:[NSString stringWithFormat:@"%d",i] forKey:@"id"];
            //                [mdic setObject:array[i] forKey:@"url"];
            //                [marray addObject:mdic];
            //            }
            //
            //            [imgVBanner reloadImageView:marray selectIndex:0];
            
            
            
        }];
        
        NSArray*arraytitle=@[kS(@"VehicleOwnerService", @"ConsiderableGains"),kS(@"VehicleOwnerService", @"HighInsurance"),kS(@"VehicleOwnerService", @"NoViolationOfRegulations"),];
        
        NSArray*arrayImage=@[@"servicei1",@"servicei2",@"servicei3",];
        
        for (int i=0; i<arrayImage.count; i++) {
            WSSizeButton*btnMenu=[RHMethods buttonWithframe:CGRectMake(i*width,imgVBanner.frameYH+0, width, viewHeader.frameHeight-imgVBanner.frameYH) backgroundColor:nil text:arraytitle[i] font:13 textColor:rgb(51, 51, 51) radius:0 superview:viewHeader];
            [btnMenu setImageStr:arrayImage[i] SelectImageStr:nil];
            [btnMenu setBtnImageViewFrame:CGRectMake(0, 20, 42, 42)];
            [btnMenu imgbeCX];
            [btnMenu setBtnLableFrame:CGRectMake(0, btnMenu.imgframeYH+13.5-4, btnMenu.frameWidth, 13+8)];
            btnMenu.titleLabel.textAlignment=NSTextAlignmentCenter;
        }
//        UILabel*lbname=[RHMethods lableX:80 Y:187 W:kScreenWidth Height:15.5 font:15.5 superview:viewHeader withColor:rgb(51,51,51) text:@"系統消息"];
        
    }
        //my car VehicleOwnerViewController
        {
            UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 188) backgroundcolor:rgbwhiteColor superView:nil];
        _viewContent=viewContent;
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        UILabel*lbMyCar=[RHMethods lableX:15 Y:25 W:0 Height:19 font:19 superview:viewContent withColor:rgb(0, 0, 0) text:kS(@"VehicleOwnerService", @"MyVehicle")];
        WSSizeButton*btnMoreCar=[RHMethods buttonWithframe:CGRectMake(0, 0, kScreenWidth*0.5, 68.5) backgroundColor:nil text:kS(@"VehicleOwnerService", @"AllVehicles") font:14 textColor:rgb(102, 102, 102) radius:0 superview:viewContent];
        
        [btnMoreCar setImageStr:@"arrowr1" SelectImageStr:nil];
        [btnMoreCar setBtnImageViewFrame:CGRectMake(0, 26, 8, 15)];
        btnMoreCar.imgframeRX=15;
        btnMoreCar.frameRX=0;
        [btnMoreCar setBtnLableFrame:CGRectMake(0, 27.5-4, btnMoreCar.frameWidth-33.5, 13+8)];
        btnMoreCar.titleLabel.textAlignment=NSTextAlignmentRight;
        [btnMoreCar addViewClickBlock:^(UIView *view) {
            [weakSelf pushController:[CarListViewController class] withInfo:nil withTitle:kST(@"CarList") withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
                [weakSelf loadDATA];
            }];
        }];
        
        
        
        UIView*viewBtnContent=[UIView viewWithFrame:CGRectMake(0, 67, kScreenWidth, 188-67) backgroundcolor:nil superView:viewContent];
        {
          WSSizeButton*btnUploadCar=[RHMethods buttonWithframe:CGRectMake(0, 0, 280, 44) backgroundColor:rgb(13, 107, 154) text:kS(@"VehicleOwnerService", @"AddVehicles") font:16 textColor:rgb(255, 255, 255) radius:5 superview:viewBtnContent];
            [btnUploadCar beCX];
            [btnUploadCar beCY ];
            [btnUploadCar addViewClickBlock:^(UIView *view) {
                [weakSelf pushController:[UploadVeicleViewController class] withInfo:nil withTitle:kST(@"AddVehicles")];
            }];
        }
        [viewContent setAddUpdataBlock:^(id data, id weakme) {
            UIView*viewContent=weakme;
            viewContent.frameHeight=88;
            for (UIView*subview in viewContent.subviews) {
                if (subview.tag==10003) {
                    subview.hidden=YES;
                }
            }
            
            NSArray*carlistArray=[weakSelf.data ojsk:@"carlist"];
            for (int i=0; i<carlistArray.count; i++) {
                NSDictionary*dic=carlistArray[i];
                UIView*viewCellContent= [viewContent getAddValueForKey:[NSString stringWithFormat:@"viewCellContent%d",i]];
                if (viewCellContent==nil) {
                    MyVehicleCellView*viewMyvehicle=[MyVehicleCellView viewWithFrame:CGRectMake(15, 88+i*(105+10), kScreenWidth-30, 0) backgroundcolor:rgb(255, 255, 255) superView:viewContent reuseId:[NSString stringWithFormat:@"viewCellContent%d",i]];
                    viewCellContent=viewMyvehicle;
                    viewMyvehicle.layer.borderWidth=1;
                    viewMyvehicle.layer.borderColor=rgb(238, 238, 238).CGColor;
                    viewMyvehicle.tag=10003;
                    [viewCellContent addViewClickBlock:^(UIView *view) {
                        
//                        if ([[view.data ojsk:@"audit"] isEqualToString:@"1"]) {
//                              [UTILITY.currentViewController pushController:[VehicleDetailsViewController class] withInfo:[view.data ojsk:@"id"] withTitle:[view.data ojsk:@"title"]];
//                        }else{
                            [weakSelf pushController:[UploadVeicleViewController class] withInfo:[view.data ojsk:@"id"] withTitle:@"" withOther:[view.data ojsk:@"audit"] withAllBlock:^(id data, int status, NSString *msg) {
                                [weakSelf loadDATA];
                            }];
//                        }
                    
                    }];
                
                }
                viewCellContent.hidden=NO;
                [viewCellContent upDataMeWithData:dic];
                viewContent.frameHeight=viewCellContent.frameYH+10;
                
                
            }
            if(carlistArray.count){
                viewBtnContent.hidden=YES;
//                viewBtnContent.frameY=viewContent.frameHeight;
//                viewContent.frameHeight=viewBtnContent.frameYH;
            }else{
                viewBtnContent.hidden=NO;
                viewBtnContent.frameY=viewContent.frameHeight;
                viewContent.frameHeight=viewBtnContent.frameYH;
            }
            
        }];
    
        
    }
    //my order VehicleOwnerViewController
    {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 67) backgroundcolor:rgbwhiteColor superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
        UILabel*lbMyCar=[RHMethods lableX:15 Y:25 W:0 Height:19 font:19 superview:viewContent withColor:rgb(0, 0, 0) text:kS(@"VehicleOwnerService", @"MyOrder")];
        WSSizeButton*btnMoreCar=[RHMethods buttonWithframe:CGRectMake(0, 0, kScreenWidth*0.5, 68.5) backgroundColor:nil text:kS(@"VehicleOwnerService", @"AllOrder") font:14 textColor:rgb(102, 102, 102) radius:0 superview:viewContent];
        [btnMoreCar setImageStr:@"arrowr1" SelectImageStr:nil];
        [btnMoreCar setBtnImageViewFrame:CGRectMake(0, 26, 8, 15)];
        btnMoreCar.imgframeRX=15;
        btnMoreCar.frameRX=0;
        [btnMoreCar setBtnLableFrame:CGRectMake(0, 27.5-4, btnMoreCar.frameWidth-33.5, 13+8)];
        btnMoreCar.titleLabel.textAlignment=NSTextAlignmentRight;
        
        
        [btnMoreCar addViewClickBlock:^(UIView *view) {
            [weakSelf pushController:[PerconalAllOrderListViewController class] withInfo:nil withTitle:@"我的订单"];
        }];
        
        SectionObj*orderObj=[SectionObj new];
        _orderObj=orderObj;
//        orderObj.dataArray=kfAry(13);
        [_mtableView.sectionArray addObject:orderObj];
        [orderObj setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
            OrderHomeCellView*viewcell=[OrderHomeCellView viewWithFrame:CGRectMake(0, 10, 0, 0) backgroundcolor:nil superView:reuseView reuseId:@"viewcell"];
            viewcell.type=@"personalCenter";
            [viewcell upDataMeWithData:Datadic];
            [viewcell addBaseViewTarget:weakSelf select:@selector(cellBtnClick:)];
            return viewcell;
        }];
        [orderObj setSectionIndexClickBlock:^(id Datadic, NSInteger row) {
            [weakSelf pushController:[OrderDetailViewController class] withInfo:[Datadic ojsk:@"orderid"] withTitle:kST(@"order_detail") withOther:@"userCenter" withAllBlock:^(id data, int status, NSString *msg) {
                [weakSelf loadDATA];
            }];
        }];
        
    }
    
}
#pragma mark  request data from the server use tableview
-(void)request{
//    krequestParam
    [_mtableView showRefresh:YES LoadMore:NO];
//    _mtableView.urlString=[NSString stringWithFormat:@"carcenter/index%@",dictparam.wgetParamStr];
//    [_mtableView refresh];
    
    __weak __typeof(self) weakSelf = self;
    [_mtableView setLoadDataBlock:^(NSMutableDictionary *pageOrPageSizeData, AllcallBlock dataCallBack) {
        
        krequestParam
        [kUserCenterService carcenter_index:dictparam withBlock:^(id data, int status, NSString *msg) {
            weakSelf.data=data;
            [weakSelf.viewHeader upDataMe];
            [weakSelf.viewContent upDataMe];
            weakSelf.orderObj.dataArray=[data ojsk:@"orderlist"];
//            [weakSelf.mtableView reloadData];
            [data setObject:[data ojsk:@"orderlist"] forKey:@"list"];
            dataCallBack(data,200,nil);
        }];
        
    }];
    [_mtableView refresh];
}
#pragma mark - request data from the server
-(void)loadDATA{
      __weak __typeof(self) weakSelf = self;
    krequestParam
    [kUserCenterService carcenter_index:dictparam withBlock:^(id data, int status, NSString *msg) {
        weakSelf.data=data;
        [weakSelf.viewHeader upDataMe];
        [weakSelf.viewContent upDataMe];
        weakSelf.orderObj.dataArray=[data ojsk:@"orderlist"];
        [weakSelf.mtableView reloadData];
    }];
    
}
#pragma mark - event listener function

-(void)cellBtnClick:(OrderHomeCellView*)viewcell{
    __weak __typeof(self) weakSelf = self;
    [kUserCenterService orderActionWithOrderData:viewcell.data WithActionType:[[viewcell.eventView data] ojsk:@"action"] withBlock:^(id data, int status, NSString *msg) {
//        [weakSelf loadDATA];
        [weakSelf request];
    }];
    
}
//[kOrderService orderActionWithOrderData:viewcell.data WithActionType:[[viewcell.eventView data] ojsk:@"action"] withBlock:^(id data, int status, NSString *msg) {
//    [weakSelf request];
//}];

#pragma mark - delegate function


@end
