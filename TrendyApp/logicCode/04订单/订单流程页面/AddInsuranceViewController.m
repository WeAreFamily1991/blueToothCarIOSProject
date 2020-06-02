//
//  AddInsuranceViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/26.
//  Copyright © 2019 55like. All rights reserved.
//
#import "AddInsuranceCenterCellView.h"
#import "AddInsuranceViewController.h"
#import "MYRHTableView.h"
#import "RUControllerBottomView.h"
#import "InsurerListViewController.h"
#import "ConfirmReservationInformationViewController.h"
#import "OrderDetailViewController.h"
@interface AddInsuranceViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;

/**
 追加保险人信息
 */
@property(nonatomic,strong)SectionObj*sobj;
@property(nonatomic,strong)SectionObj*sobjMaster;

@end

@implementation  AddInsuranceViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDATA];
}
#pragma mark -   write UI
-(void)addView{
      __weak __typeof(self) weakSelf = self;
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    
    //保險介紹
    {
        UIView*viewcontent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 0) backgroundcolor:rgbwhiteColor superView:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewcontent];
        UILabel*lbName=[RHMethods lableX:16 Y:16 W:0 Height:16 font:16 superview:viewcontent withColor:rgb(51, 51, 51) text:kS(@"fill_insurance_info", @"insurance_introduce")];
        UILabel*lbContent=[RHMethods lableX:16 Y:lbName.frameYH+15 W:viewcontent.frameWidth-30 Height:0 font:16 superview:viewcontent withColor:rgb(153, 153, 153) text:[self.data ojsk:@"rule_insurance"]];
        viewcontent.frameHeight=lbContent.frameYH+20;
        
    }
    //被保險人信息
    {
        SectionObj*sobj=[SectionObj new];
        [_mtableView.sectionArray addObject:sobj];
        {
            UIView*viewHedaerView=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 50) backgroundcolor:nil superView:nil];
            sobj.selctionHeaderView=viewHedaerView;
            UILabel*lbTitle=[RHMethods lableX:16 Y:0 W:0 Height:50 font:14 superview:viewHedaerView withColor:rgb(153, 153, 153) text:kS(@"fill_insurance_info", @"insurance_person_info")];
        }
        
        AddInsuranceCenterCellView*viewCell=[AddInsuranceCenterCellView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 0) backgroundcolor:nil superView:nil];
        //        [viewCell bendData:[self.data ojk:@"master"] withType:nil]
        if ([self.otherInfo isEqualToString:@"confirmOrder"]) {
            
        }else{
            [[self.data ojk:@"master"] setObject:@"noEdite" forKey:@"cellType"];
            
            [self navbarTitle:kS(@"fill_insurance_info", @"append_insurance")];
        }
        
        [viewCell upDataMeWithData:[self.data ojk:@"master"]];
        [sobj.noReUseViewArray addObject:viewCell];
        
        [viewCell setBaseViewEventBlock:^(MYViewBase *baseView) {
            if ([[baseView.eventView getAddValueForKey:@"actionType"] isEqualToString:@"delete"]) {
                [weakSelf.data removeObjectForKey:@"master"];
                [weakSelf.sobjMaster upDataMe];
            }
        }];
        
        
        WSSizeButton*btnAddInsurer=[RHMethods buttonWithframe:CGRectMake(0, 10, kScreenWidth, 49) backgroundColor:rgbwhiteColor text:[NSString stringWithFormat:@"  %@",kS(@"fill_insurance_info", @"insurance_person_add")] font:13 textColor:rgb(13, 112, 161) radius:0 superview:nil];
        [sobj.noReUseViewArray addObject:btnAddInsurer];
        [btnAddInsurer setImageStr:@"addi" SelectImageStr:nil];
        BtnCallBlock block=^(UIView *view) {
            
//            [mdic setObject:@"noEdite" forKey:@"cellType"]
            
            [weakSelf pushController:[InsurerListViewController class] withInfo:[weakSelf.data ojk:@"master"]? [NSMutableArray arrayWithObject:[weakSelf.data ojk:@"master"]]:nil  withTitle:kS(@"fill_insurance_info", @"insurance_person_add") withOther:@"master" withAllBlock:^(id data, int status, NSString *msg) {
                [weakSelf.data setObject:[data firstObject] forKey:@"master"];
                [weakSelf.sobjMaster upDataMe];
            }];
        };
        [btnAddInsurer addViewClickBlock:block];
        if (![[[weakSelf.data ojk:@"master"] ojk:@"cellType"] isEqualToString:@"noEdite"]) {
            [viewCell addViewClickBlock:block];
        }
        _sobjMaster=sobj;
        [sobj setAddUpdataBlock:^(id data, id weakme) {
            [weakSelf.sobjMaster.noReUseViewArray removeAllObjects];
            
            if(![[[weakSelf.data ojk:@"master"] ojsk:@"id"] notEmptyOrNull]) {
                [weakSelf.sobjMaster.noReUseViewArray addObject:btnAddInsurer];
            }else{
                [viewCell upDataMeWithData:[weakSelf.data ojk:@"master"]];
                [weakSelf.sobjMaster.noReUseViewArray addObject:viewCell];
            }
            
            [weakSelf.mtableView reloadData];
            
        }];
        [sobj upDataMe];
    }
    //追加保險人信息（最多追加2人）
    {
        SectionObj*sobj=[SectionObj new];
        [_mtableView.sectionArray addObject:sobj];
        {
            UIView*viewHedaerView=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 50) backgroundcolor:nil superView:nil];
            sobj.selctionHeaderView=viewHedaerView;
            UILabel*lbTitle=[RHMethods lableX:16 Y:0 W:0 Height:50 font:14 superview:viewHedaerView withColor:rgb(153, 153, 153) text:[NSString stringWithFormat:kS(@"fill_insurance_info", @"insurance_person_info_append"),[self.data ojsk:@"insurance_nums"].intValue]];
        }
        
        WSSizeButton*btnAddInsurer=[RHMethods buttonWithframe:CGRectMake(0, 10, kScreenWidth, 49) backgroundColor:rgbwhiteColor text:[NSString stringWithFormat:@"   %@",kS(@"fill_insurance_info", @"insurance_person_add_append")] font:13 textColor:rgb(13, 112, 161) radius:0 superview:nil];
        [sobj.noReUseViewArray addObject:btnAddInsurer];
        [btnAddInsurer setImageStr:@"addi" SelectImageStr:nil];
        
        [btnAddInsurer addViewClickBlock:^(UIView *view) {
          InsurerListViewController*controller=(id)[weakSelf pushController:[InsurerListViewController class] withInfo:[weakSelf.data ojk:@"append"] withTitle:kS(@"fill_insurance_info", @"insurance_person_add_append") withOther:@"append" withAllBlock:^(id data, int status, NSString *msg) {
                [weakSelf.data setObject:data forKey:@"append"];
                [weakSelf.sobj upDataMe];
            }];
            controller.masterDataDic=[weakSelf.data ojk:@"master"];
            controller.maxNmumber=[self.data ojsk:@"insurance_nums"].intValue;
        }];
        _sobj=sobj;
        [sobj setAddUpdataBlock:^(id data, id weakme) {
            [weakSelf.sobj.noReUseViewArray removeAllObjects];
            NSArray*listArray=[weakSelf.data ojk:@"append"];
            for (NSDictionary*mdic in listArray) {
                AddInsuranceCenterCellView*viewCell=[AddInsuranceCenterCellView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 0) backgroundcolor:nil superView:nil];
                [viewCell upDataMeWithData:mdic];
                [weakSelf.sobj.noReUseViewArray addObject:viewCell];
                [viewCell addBaseViewTarget:self select:@selector(cellAction:)];
            }
            if (listArray.count<[self.data ojsk:@"insurance_nums"].intValue) {
                [weakSelf.sobj.noReUseViewArray addObject:btnAddInsurer];
            }
            [weakSelf.mtableView reloadData];
        }];
    }
    
    _mtableView.frameHeight=_mtableView.frameHeight-60;
    RUControllerBottomView*viewBottom=[RUControllerBottomView viewWithFrame:CGRectMake(0, _mtableView.frameYH, 0, 0) backgroundcolor:nil superView:self.view];
//    generalPage OK
    if ([weakSelf.otherInfo isEqualToString:@"confirmOrder"]) {
        [viewBottom upDataMeWithData:@{@"btnTitle":kS(@"generalPage", @"OK")}];
    }else{
        [viewBottom upDataMeWithData:@{@"btnTitle":kS(@"fill_insurance_info", @"insurance_next_step")}];
    }
    [viewBottom addBaseViewTarget:self select:@selector(okBtnClick)];
}
-(void)okBtnClick{
    if (![[[self.data ojk:@"master"] ojsk:@"id"] notEmptyOrNull]) {
        [SVProgressHUD showImage:nil status:kS(@"fill_insurance_info", @"pleselectInsurance")];
        return;
    }
      __weak __typeof(self) weakSelf = self;
    if ([weakSelf.otherInfo isEqualToString:@"confirmOrder"]) {
        self.allcallBlock ?self.allcallBlock(self.data, 200, nil):nil;
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
//    [mdic setObject:[[self.data ojk:@"master"] ojsk:@"id"] forKey:@"masterid"];
//    [mdic setObject:[[self.data ojk:@"master"] ojsk:@"id"] forKey:@"masterid"];
    NSMutableDictionary*mdic=[NSMutableDictionary new];
    
    [mdic setObject:self.userInfo forKey:@"orderid"];
    if ([[[self.data ojk:@"master"] ojsk:@"id"] notEmptyOrNull]&&![[[self.data ojk:@"master"] ojsk:@"cellType"] isEqualToString:@"noEdite"]) {
        [mdic setObject:[[self.data ojk:@"master"] ojsk:@"id"] forKey:@"masterid"];
    }
    NSMutableArray*marray=[NSMutableArray new];
    
    NSMutableArray*listArray=[self.data ojk:@"append"];
    for (NSMutableDictionary*mdic in listArray) {
        if (![[mdic ojsk:@"cellType"] isEqualToString:@"noEdite"]) {
            [marray addObject:[mdic ojsk:@"id"]];
        }
    }
    if ([marray count]) {
        [mdic setObject:[marray componentsJoinedByString:@","] forKey:@"appendid"];
    }
    
    kOrderService.apiUrl(@"order/orderinsureradd").paraDic(mdic).success(^(id data, NSString *msg) {
        if ([weakSelf.otherInfo isEqualToString:@"apply"]) {
            [SVProgressHUD showSuccessWithStatus:msg];
//            [weakSelf pushController:[ConfirmReservationInformationViewController class] withInfo:weakSelf.userInfo withTitle:@"確認預定信息"];
            [weakSelf pushController:[ConfirmReservationInformationViewController class] withInfo:weakSelf.userInfo withTitle:kST(@"confirm_booking_info")];
        }else  if ([weakSelf.otherInfo isEqualToString:@"insurance"]){
            [weakSelf pushController:[OrderDetailViewController class] withInfo:self.userInfo withTitle:kST(@"order_detail")];
        }
        
        
    }).startload();
}

-(void)cellAction:(MYViewBase*)cellView{
    if ([[cellView.eventView getAddValueForKey:@"actionType"] isEqualToString:@"delete"]) {
        [[self.data ojk:@"append"] removeObject:cellView.data];
        [self.sobj upDataMe];
//        order/orderinsureradd
    }
    
    
    
}
#pragma mark  request data from the server use tableview

#pragma mark - request data from the server
-(void)loadDATA{
    __weak __typeof(self) weakSelf = self;

    NSMutableDictionary*mdic=[NSMutableDictionary new];
    if ([weakSelf.otherInfo isEqualToString:@"confirmOrder"]) {
        [mdic setObject:@"" forKey:@"orderid"];
    }else{
        [mdic setObject:self.userInfo forKey:@"orderid"];
    }
    
    kOrderService.apiUrl(@"order/orderinsurer").paraDic(mdic).success(^(id data, NSString *msg) {
        weakSelf.data=data;
        NSArray*listArray=[weakSelf.data ojk:@"append"];
        if ([weakSelf.otherInfo isEqualToString:@"confirmOrder"]) {
            if ([weakSelf.userInfo ojk:@"master"]) {
                [weakSelf.data setObject:[weakSelf.userInfo ojk:@"master"] forKey:@"master"];
                //                [[weakSelf.userInfo ojk:@"master"] setObject:@"noEdite" forKey:@"cellType"];
            }
            if ([weakSelf.userInfo ojk:@"append"]) {
                [weakSelf.data setObject:[weakSelf.userInfo ojk:@"append"] forKey:@"append"];
            }
        }else{
            for (NSMutableDictionary*mdic in listArray) {
                [mdic setObject:@"noEdite" forKey:@"cellType"];
            }
            if(![[[weakSelf.data ojk:@"master"] ojsk:@"id"] notEmptyOrNull]) {
                [weakSelf.data removeObjectForKey:@"master"];
            }
        }
        [weakSelf addView];
        [weakSelf.sobj upDataMe];
    }).startload();
    
    
}
#pragma mark - event listener function


#pragma mark - delegate function


@end
