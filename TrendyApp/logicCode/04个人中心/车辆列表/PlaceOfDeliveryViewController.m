//
//  InsurerListViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/26.
//  Copyright © 2019 55like. All rights reserved.
//

#import "PlaceOfDeliveryViewController.h"
#import "MYRHTableView.h"
#import "PlaceOfDeliveryCellView.h"
#import "RUControllerBottomView.h"
#import "AddPlaceOfDeliveryViewController.h"
@interface PlaceOfDeliveryViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)NSMutableArray*selectArray;
@end

@implementation  PlaceOfDeliveryViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    _selectArray=[[NSMutableArray alloc] initWithArray:[self.userInfo componentsSeparatedByString:@","]];
    
    for (int i=_selectArray.count; i>0; i--) {
        NSString*str=_selectArray[i-1];
        if (![str notEmptyOrNull]) {
            [_selectArray removeObjectAtIndex:i-1];
        }
    }

    [self addView];
    [self request];
    
    
}
-(void)convertToSelectCellDataDic:(NSMutableDictionary*)cellDic{
//    for (int i=0; i<self.selectArray.count; i++) {
//        NSMutableDictionary*dic=self.selectArray[i];
        [cellDic setObject:@"0" forKey:@"isSelected"];
    if ([_selectArray containsObject:[cellDic ojk:@"id"]]) {
        [cellDic setObject:@"1" forKey:@"isSelected"];
//        return;
    }
//        if ([self.userInfo isEqualToString:[cellDic ojk:@"id"]]) {
//            [cellDic setObject:@"1" forKey:@"isSelected"];
////            [cellDic setObject:[dic ojsk:@"cellType"] forKey:@"cellType"];
////            [self.selectArray removeObjectAtIndex:i];
////            [self.selectArray insertObject:cellDic atIndex:i];
//            return;
//        }
//    }


}
#pragma mark -   write UI
-(void)addView{
    [self rightButton:kS(@"PlaceOfDelivery", @"complete") image:nil sel:@selector(rightButtonClicekd)];
    __weak __typeof(self) weakSelf = self;
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    //    _mtableView.defaultSection.dataArray=kfAry(3);
    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
        PlaceOfDeliveryCellView*viewcell=[PlaceOfDeliveryCellView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 0) backgroundcolor:nil superView:reuseView reuseId:@"PlaceOfDeliveryCellView"];
        [weakSelf convertToSelectCellDataDic:Datadic];
        viewcell.type=self.otherInfo;
        [viewcell upDataMeWithData:Datadic];
        //        [viewcell addViewTarget:self select:@selector(cellEditeBtnClick:)];
        [viewcell addBaseViewTarget:self select:@selector(cellEditeBtnClick:)];
        return viewcell;
    }];
    
    
    {
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 20+34+20) backgroundcolor:nil superView:nil];
        SectionObj*obj=[SectionObj new];
        [_mtableView.sectionArray addObject:obj];
        
        WSSizeButton*btnAdd=[RHMethods buttonWithframe:CGRectMake(0, 20, 140, 34) backgroundColor:nil text:kS(@"PlaceOfDelivery", @"AdditionalTrafficDeliveryPlaces") font:13 textColor:rgb(13, 112, 161) radius:5 superview:viewContent];
        [obj.noReUseViewArray addObject:btnAdd];
        btnAdd.layer.borderWidth=1;
        [btnAdd beCX];
        btnAdd.layer.borderColor=rgb(13, 112, 161).CGColor;
        [btnAdd addViewClickBlock:^(UIView *view) {
            [weakSelf pushController:[AddPlaceOfDeliveryViewController class] withInfo:nil withTitle:kS(@"EditDeliveryPlace", @"AddDeliveryPlaces") withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
                [weakSelf request];
            }];
        }];
    }
    

    
}
-(void)commitBtnClick{
    if (self.allcallBlock) {
        if (_selectArray.count) {
            
            self.allcallBlock(_selectArray, 200, nil);
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showImage:nil status:kS(@"fill_insurance_info", @"pleselectInsurance")];
        }
    }
}
-(void)rightButtonClicekd{
    __weak __typeof(self) weakSelf = self;
    NSString* str=self.userInfo;
    self.userInfo=[_selectArray componentsJoinedByString:@","];

    NSMutableDictionary*mdic=[NSMutableDictionary new];
    [mdic setObject:self.otherInfo forKey:@"carid"];
    [mdic setObject:self.userInfo forKey:@"addressid"];
    [kCarCenterService carcenter_updatecaraddress:mdic withBlock:^(id data, int status, NSString *msg) {
        
        if (status==200) {
            weakSelf.allcallBlock?weakSelf.allcallBlock(nil,200,nil):nil;
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            weakSelf.userInfo=str;
            [weakSelf.mtableView reloadData];
        }
        
    }];
}
-(void)cellEditeBtnClick:(MYViewBase*)cellView{
    __weak __typeof(self) weakSelf = self;
    if ([[cellView.eventView getAddValueForKey:@"actionType"] isEqualToString:@"cellSelect"]) {
        if ([_selectArray containsObject:[cellView.data ojsk:@"id"]]) {
            [_selectArray removeObject:[cellView.data ojsk:@"id"]];
        }else{
            [_selectArray addObject:[cellView.data ojsk:@"id"]];
        }
        [self.mtableView reloadData];
        
        
//        if ([[cellView.data ojsk:@"isSelected"] isEqualToString:@"1"]) {
//            if ([[cellView.data ojsk:@"cellType"] isEqualToString:@"noEdite"]) {
//                return;
//            }
//            for (NSMutableDictionary*dic in self.selectArray) {
//                if ([[dic ojk:@"id"] isEqualToString:[cellView.data ojk:@"id"]]) {
//                    //                    return;
//                    [cellView.data setObject:@"0" forKey:@"isSelected"];
//                    [self.selectArray removeObject:dic];
//                    break;
//                }
//            }
//        }else{
//            if ([self.otherInfo isEqualToString:@"master"]) {
//                [_selectArray removeAllObjects];
//            }
//            //            [cellView.data setObject:@"1" forKey:@"isSeleced"];
//
//            if (_selectArray.count<2) {
//                [_selectArray addObject:cellView.data];
//            }
//        }
//
//        [self.mtableView reloadData];
    }else{
        [self pushController:[AddPlaceOfDeliveryViewController class] withInfo:cellView.data withTitle:kST(@"EditDeliveryPlace") withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
            [weakSelf request];
        }];
    }

}
#pragma mark  request data from the server use tableview
-(void)request{
    //    krequestParam
    //
    //    [dictparam setObject:@"%@" forKey:@"page"];
    //    [dictparam setObject:@"12" forKey:@"limit"];
    [_mtableView showRefresh:YES LoadMore:YES];
      __weak __typeof(self) weakSelf = self;
    [_mtableView setLoadDataBlock:^(NSMutableDictionary *pageOrPageSizeData, AllcallBlock dataCallBack) {
//        [pageOrPageSizeData setObject:weakSelf.userInfo forKey:@""];
        [kCarCenterService carcenter_getaddressWithParam:pageOrPageSizeData withBlock:dataCallBack];
    }];
    [_mtableView refresh];
}
#pragma mark - request data from the server
-(void)loadDATA{
    
    
}
#pragma mark - event listener function


#pragma mark - delegate function


@end
