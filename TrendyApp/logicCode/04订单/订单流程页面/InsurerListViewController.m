//
//  InsurerListViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/26.
//  Copyright © 2019 55like. All rights reserved.
//

#import "InsurerListViewController.h"
#import "MYRHTableView.h"
#import "InsurerListCellView.h"
#import "RUControllerBottomView.h"
#import "AddInsurerInformationViewController.h"
@interface InsurerListViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)NSMutableArray*selectArray;
@end

@implementation  InsurerListViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    _selectArray=self.userInfo;
    if (_selectArray==nil) {
        _selectArray=[NSMutableArray new];
    }
    [self addView];
    [self request];
    [self navbarTitle:kST(@"insurerInfo")];
    
}
-(void)convertToSelectCellDataDic:(NSMutableDictionary*)cellDic{
    for (int i=0; i<self.selectArray.count; i++) {
        NSMutableDictionary*dic=self.selectArray[i];
        [cellDic setObject:@"0" forKey:@"isSelected"];
        if ([[dic ojk:@"id"] isEqualToString:[cellDic ojk:@"id"]]) {
            [cellDic setObject:@"1" forKey:@"isSelected"];
            [cellDic setObject:[dic ojsk:@"cellType"] forKey:@"cellType"];
            [self.selectArray removeObjectAtIndex:i];
            [self.selectArray insertObject:cellDic atIndex:i];
            return;
        }
    }
    
    
}
#pragma mark -   write UI
-(void)addView{
      __weak __typeof(self) weakSelf = self;
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
//    _mtableView.defaultSection.dataArray=kfAry(3);
    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
        InsurerListCellView*viewcell=[InsurerListCellView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 0) backgroundcolor:nil superView:reuseView reuseId:@"InsurerListCellView"];
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
        
        WSSizeButton*btnAdd=[RHMethods buttonWithframe:CGRectMake(WScale(30), WScale(20), WScale(142.5), WScale(35)) backgroundColor:nil text:kS(@"insurerInfo", @"add_insurer") font:13 textColor:rgb(13, 112, 161) radius:5 superview:viewContent];
        [obj.noReUseViewArray addObject:btnAdd];
        btnAdd.layer.borderWidth=1;
//        [btnAdd beCX];
        btnAdd.layer.borderColor=rgb(13, 112, 161).CGColor;
        [btnAdd addViewClickBlock:^(UIView *view) {
            [weakSelf pushController:[AddInsurerInformationViewController class] withInfo:nil withTitle:kST(@"addInsurerInfo") withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
                [weakSelf request];
            }];
        }];
        WSSizeButton*btnCancel=[RHMethods buttonWithframe:CGRectMake(WScale(212.5), WScale(20), WScale(142.5), WScale(35)) backgroundColor:nil text:kS(@"insurerInfo", @"add_insurer") font:13 textColor:REDCOLOR radius:5 superview:viewContent];
        [obj.noReUseViewArray addObject:btnCancel];
        btnCancel.layer.borderWidth=1;
//        [btnCancel beCX];
        btnCancel.layer.borderColor=REDCOLOR.CGColor;
        [btnCancel addViewClickBlock:^(UIView *view) {
            [weakSelf pushController:[AddInsurerInformationViewController class] withInfo:nil withTitle:kST(@"addInsurerInfo") withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
                [weakSelf request];
            }];
        }];
    }
    
    if ([self.otherInfo isEqualToString:@"userCenter"]) {
    }else{
        _mtableView.frameHeight=_mtableView.frameHeight-60-kIphoneXBottom;
        RUControllerBottomView*viewBottom=[RUControllerBottomView viewWithFrame:CGRectMake(0, _mtableView.frameYH, 0, 60+kIphoneXBottom) backgroundcolor:nil superView:self.view];
        [viewBottom upDataMeWithData:@{@"btnTitle":kS(@"insurerInfo", @"confirm")}];
        [viewBottom addBaseViewTarget:self select:@selector(commitBtnClick)];
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

-(void)cellEditeBtnClick:(MYViewBase*)cellView{
      __weak __typeof(self) weakSelf = self;
    if ([[cellView.eventView getAddValueForKey:@"actionType"] isEqualToString:@"cellSelect"]) {
        if ([[cellView.data ojsk:@"id"] isEqualToString:[self.masterDataDic ojsk:@"id"]]) {
            return;
        }
        if ([[cellView.data ojsk:@"isSelected"] isEqualToString:@"1"]) {
            if ([[cellView.data ojsk:@"cellType"] isEqualToString:@"noEdite"]) {
                return;
            }
            for (NSMutableDictionary*dic in self.selectArray) {
                if ([[dic ojk:@"id"] isEqualToString:[cellView.data ojk:@"id"]]) {
                    //                    return;
                    [cellView.data setObject:@"0" forKey:@"isSelected"];
                    [self.selectArray removeObject:dic];
                    break;
                }
            }
        }else{
            if ([self.otherInfo isEqualToString:@"master"]) {
                [_selectArray removeAllObjects];
                [_selectArray addObject:cellView.data];
            }else{
                if (_selectArray.count<self.maxNmumber) {
                    [_selectArray addObject:cellView.data];
                }
            }
            //            [cellView.data setObject:@"1" forKey:@"isSeleced"];
            
         
        }
        
        [self.mtableView reloadData];
    }else{
        [self pushController:[AddInsurerInformationViewController class] withInfo:[cellView.data ojsk:@"id"] withTitle:kST(@"addInsurerInfo") withOther:nil withAllBlock:^(id data, int status, NSString *msg) {
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
    [_mtableView setLoadDataBlock:^(NSMutableDictionary *pageOrPageSizeData, AllcallBlock dataCallBack) {
        [kUserCenterService ucenterInsurerdWithParam:pageOrPageSizeData withBlock:dataCallBack];
    }];
    [_mtableView refresh];
}
#pragma mark - request data from the server
-(void)loadDATA{

    
}
#pragma mark - event listener function


#pragma mark - delegate function


@end
