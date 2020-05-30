//
//  AddInsurerInformationViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/2/27.
//  Copyright © 2019 55like. All rights reserved. 178a2ea19ada79fb12aee5&uid=6&language=cn
//

#import "UploadVeicleViewController.h"
#import "MYRHTableView.h"
#import "VehicleBaseInfoViewController.h"
#import "VehicleDetailInfoViewController.h"
#import "VeicleOwnorInfoViewController.h"
#import "AutomobileBrandContentView.h" 
@interface UploadVeicleViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)WSSizeButton*btnConfirm;
@end
@implementation  UploadVeicleViewController
#pragma mark  bigen
- (void)viewDidLoad {
//    [self rightButton:kS(@"AddVehicles", @"Submit") image:nil sel:@selector(submitBtnClick:)];
    [super viewDidLoad];
    if (self.userInfo) {
        [self loadDATA];
    }
    [self addView];
    [self updateTjiaoBtn];
}

-(void)updateTjiaoBtn{
      __weak __typeof(self) weakSelf = self;
    NSMutableDictionary*dicData_VehicleBaseInfoViewController=[weakSelf getAddValueForKey:@"VehicleBaseInfoViewController"];
    NSMutableDictionary*dicData_VehicleDetailInfoViewController=[weakSelf getAddValueForKey:@"VehicleDetailInfoViewController"];
    NSMutableDictionary*dicData_VeicleOwnorInfoViewController=[weakSelf getAddValueForKey:@"VeicleOwnorInfoViewController"];
    
    if (dicData_VehicleBaseInfoViewController&&dicData_VehicleDetailInfoViewController&&dicData_VeicleOwnorInfoViewController) {
        _btnConfirm.userInteractionEnabled=YES;
        [_btnConfirm setBackgroundColor:rgb(13, 107, 154)];
    }else{
        _btnConfirm.userInteractionEnabled=NO;
        [_btnConfirm setBackgroundColor:RGBACOLOR(13, 107, 154, 0.5)];
        
    }
    
}

-(void)submitBtnClick:(UIButton*)btn{
      __weak __typeof(self) weakSelf = self;
    [kFormCellService getRequestDictionaryWithformCellViewArray:_mtableView.defaultSection.noReUseViewArray withBlock:^(id data, int status, NSString *msg) {
        if (status==200) {
                NSMutableDictionary*mdic=[NSMutableDictionary new];
                NSMutableDictionary*dicData_VehicleBaseInfoViewController=[weakSelf getAddValueForKey:@"VehicleBaseInfoViewController"];
                NSMutableDictionary*dicData_VehicleDetailInfoViewController=[weakSelf getAddValueForKey:@"VehicleDetailInfoViewController"];
                NSMutableDictionary*dicData_VeicleOwnorInfoViewController=[weakSelf getAddValueForKey:@"VeicleOwnorInfoViewController"];
            [mdic addEntriesFromDictionary:dicData_VehicleBaseInfoViewController];
            [mdic addEntriesFromDictionary:dicData_VehicleDetailInfoViewController];
            [mdic addEntriesFromDictionary:dicData_VeicleOwnorInfoViewController];
            [UTILITY setAddValue:@"1" forKey:@"updataCarInfo"];
            if (weakSelf.userInfo) {
                [mdic setObject:weakSelf.userInfo forKey:@"carid"];
            }
            
            [kCarCenterService carcenter_addcar:mdic withBlock:^(id data, int status, NSString *msg) {
                if (weakSelf.allcallBlock) {
                    weakSelf.allcallBlock(data, 200, nil);
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            }];
        }
    }];
    
    
    
}
#pragma mark -   write UI
-(void)addView{
    if (_mtableView==nil) {
        _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
        _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mtableView];
    }
    
    NSString*valuestr=self.userInfo?kS(@"AddVehicles", @"Uploaded"):@"";
    NSMutableArray*arraytitle=[@[
                                 @{
                                     @"name":@"vijewlin",
                                     @"classStr":@"FCLineCellView",
                                     },
                                 @{
                                     @"name":kS(@"AddVehicles", @"BasicVehicleInformation"),
                                     @"classStr":@"FCSelectCellView",
                                     @"actionType":@"baseInfoOfCar",
                                     @"requestkey":@"BasicVehicleInformation",
                                     @"placeholder":kS(@"AddVehicles", @"PleaseUpload"),
                                     @"frameHeight":@"55",
                                     @"valueStr":valuestr,
//                                     @"isMust":@"1",
                                     },
                                 @{
                                     @"name":kS(@"AddVehicles", @"VehicleDetailsInfo"),
                                     @"classStr":@"FCSelectCellView",
                                     @"actionType":@"detailInfoOfCar",
                                     @"requestkey":@"VehicleDetailsInfo",
                                     @"placeholder":kS(@"AddVehicles", @"PleaseUpload"),
                                     @"frameHeight":@"55",
                                     @"valueStr":valuestr,
                                     @"unit":@"",
//                                     @"isMust":@"1",
                                     },
                                 @{
                                     @"name":kS(@"AddVehicles", @"OwnerInformation"),
                                     @"classStr":@"FCSelectCellView",
                                     @"actionType":@"ownorInfoOfCar",
                                     @"requestkey":@"OwnerInformation",
                                     @"placeholder":kS(@"AddVehicles", @"PleaseUpload"),
                                     @"frameHeight":@"55",
                                     @"valueStr":valuestr,
                                     @"unit":@"",
//                                     @"isMust":@"1",
                                     },
                                 ] toBeMutableObj];
    arraytitle=[arraytitle toBeMutableObj];
    [_mtableView.defaultSection.noReUseViewArray removeAllObjects];
    for (int i=0; i<arraytitle.count; i++) {
        NSMutableDictionary*dic=arraytitle[i];
        BaseFormCellView*viewCell=[UIView getViewWithConfigData:dic];
        [_mtableView.defaultSection.noReUseViewArray addObject:viewCell];
        if ([[dic ojsk:@"actionType"] isEqualToString:@"baseInfoOfCar"]) {
            [viewCell addViewTarget:self select:@selector(baseInfoOfCar:)];
            viewCell.defaultTextfield.textColor=rgb(13, 107, 154);
        }else if ([[dic ojsk:@"actionType"] isEqualToString:@"detailInfoOfCar"]) {
            [viewCell addViewTarget:self select:@selector(detailInfoOfCar:)];
            viewCell.defaultTextfield.textColor=rgb(13, 107, 154);
        }else if ([[dic ojsk:@"actionType"] isEqualToString:@"ownorInfoOfCar"]) {
            [viewCell addViewTarget:self select:@selector(ownorInfoOfCar:)];
            viewCell.defaultTextfield.textColor=rgb(13, 107, 154);
        }
        
    }
    if (!self.otherInfo || ![self.otherInfo isEqualToString:@"1"]) {
        WSSizeButton*btnConfirm=[RHMethods buttonWithframe:CGRectMake(15, 40, kScreenWidth-30, 44) backgroundColor:rgb(13, 107, 154) text:kS(@"AddVehicles", @"Submit") font:16 textColor:rgb(255, 255, 255) radius:5 superview:nil];
        [_mtableView.defaultSection.noReUseViewArray addObject:btnConfirm];
        [btnConfirm addViewTarget:self select:@selector(submitBtnClick:)];
        _btnConfirm=btnConfirm;
    }
    [_mtableView reloadData];
}
#pragma mark  request data from the server use tableview
-(void)baseInfoOfCar:(BaseFormCellView*)viewCell{
      __weak __typeof(self) weakSelf = self;
    [self pushController:[VehicleBaseInfoViewController class] withInfo:[weakSelf getAddValueForKey:@"VehicleBaseInfoViewController"] withTitle:kST(@"AddBasicVehicleInformation") withOther:self.otherInfo withAllBlock:^(id data, int status, NSString *msg) {
        [weakSelf setAddValue:data forKey:@"VehicleBaseInfoViewController"];
        viewCell.defaultTextfield.text=kS(@"AddVehicles", @"Uploaded");
        [weakSelf updateTjiaoBtn];
    }];
}
-(void)detailInfoOfCar:(BaseFormCellView*)viewCell{
    __weak __typeof(self) weakSelf = self;
    [self pushController:[VehicleDetailInfoViewController class] withInfo:[weakSelf getAddValueForKey:@"VehicleDetailInfoViewController"] withTitle:kST(@"VehicleDetailsInfo") withOther:self.otherInfo withAllBlock:^(id data, int status, NSString *msg) {
        [weakSelf setAddValue:data forKey:@"VehicleDetailInfoViewController"];
        viewCell.defaultTextfield.text=kS(@"AddVehicles", @"Uploaded");
        [weakSelf updateTjiaoBtn];
    }];
}
-(void)ownorInfoOfCar:(BaseFormCellView*)viewCell{
      __weak __typeof(self) weakSelf = self;
    [self pushController:[VeicleOwnorInfoViewController class] withInfo:[weakSelf getAddValueForKey:@"VeicleOwnorInfoViewController"] withTitle:kST(@"OwnerInformation") withOther:self.otherInfo withAllBlock:^(id data, int status, NSString *msg) {
        [weakSelf setAddValue:data forKey:@"VeicleOwnorInfoViewController"];
        viewCell.defaultTextfield.text=kS(@"AddVehicles", @"Uploaded");
        [weakSelf updateTjiaoBtn];
    }];
}
#pragma mark - request data from the server
-(void)loadDATA{
      __weak __typeof(self) weakSelf = self;
    [kCarCenterService carcenter_cardatail:@{@"carid":self.userInfo} withBlock:^(id data, int status, NSString *msg) {
        weakSelf.data=data;
        {
            NSMutableDictionary*dicVehicleBaseInfoViewController=[NSMutableDictionary new];
            [dicVehicleBaseInfoViewController setObject:[weakSelf.data ojsk:@"title"] forKey:@"title"];
            [dicVehicleBaseInfoViewController setObject:[weakSelf.data ojsk:@"fid_sid"] forKey:@"fid_sid"];
            [dicVehicleBaseInfoViewController setObject:[weakSelf.data ojsk:@"year"] forKey:@"year"];
            [dicVehicleBaseInfoViewController setObject:[weakSelf.data ojsk:@"city_area"] forKey:@"city_area"];
            
            [dicVehicleBaseInfoViewController setObject:[weakSelf.data ojsk:@"user_address"] forKey:@"user_address"];
            [dicVehicleBaseInfoViewController setObject:[weakSelf.data ojsk:@"path"] forKey:@"path"];
            
            [weakSelf setAddValue:dicVehicleBaseInfoViewController forKey:@"VehicleBaseInfoViewController"];
            //        [dicVehicleBaseInfoViewController setObject:[self.data ojk:@""] forKey:@""];
            //        [dicVehicleBaseInfoViewController setObject:[self.data ojk:@""] forKey:@""];
            
//            viewCell.defaultTextfield.text=kS(@"AddVehicles", @"Uploaded");
        }
        
        
        {
            NSMutableDictionary*dicVehicleDetailInfoViewController=[NSMutableDictionary new];
            [dicVehicleDetailInfoViewController setObject:[weakSelf.data ojsk:@"deploy_id"] forKey:@"deploy_id"];
            [dicVehicleDetailInfoViewController setObject:[weakSelf.data ojsk:@"deploy_id"] forKey:@"deploy_id"];
            [weakSelf setAddValue:dicVehicleDetailInfoViewController forKey:@"VehicleDetailInfoViewController"];
            
//            viewCell.defaultTextfield.text=kS(@"AddVehicles", @"Uploaded");
        }
        
        {
            NSMutableDictionary*dicVeicleOwnorInfoViewController=[NSMutableDictionary new];
            [dicVeicleOwnorInfoViewController setObject:[weakSelf.data ojsk:@"user_name"] forKey:@"user_name"];
            [dicVeicleOwnorInfoViewController setObject:[weakSelf.data ojsk:@"user_address"] forKey:@"user_address"];
            [dicVeicleOwnorInfoViewController setObject:[weakSelf.data ojsk:@"birthday"] forKey:@"birthday"];
            [dicVeicleOwnorInfoViewController setObject:[weakSelf.data ojsk:@"plate_number"] forKey:@"plate_number"];
            [dicVeicleOwnorInfoViewController setObject:[weakSelf.data ojsk:@"indate"] forKey:@"indate"];
            [weakSelf setAddValue:dicVeicleOwnorInfoViewController forKey:@"VeicleOwnorInfoViewController"];
            
//            viewCell.defaultTextfield.text=kS(@"AddVehicles", @"Uploaded");
        }
        
        
        [weakSelf updateTjiaoBtn];
    }];
   
    
    
    
//    __weak __typeof(self) weakSelf = self;
//    NSMutableDictionary*paramdic=[NSMutableDictionary new];
//    [paramdic setObject:self.userInfo forKey:@"linkId"];
//    [paramdic setObject:self.otherInfo forKey:@"type"];
    
    
    
    //    [kBusinessSubmissionService getBusinessSubmissionDetailWithParam:paramdic withBlock:^(id data, int status, NSString *msg) {
    //        weakSelf.data=data;
    //
    //        if ([[weakSelf.data ojsk:@"coal"] isEqualToString:@"其他"]) {
    //            weakSelf.isOtherTypeCoal=YES;
    //            //            [weakSelf.mtableView reloadData];
    //            [weakSelf addView];
    //        }
    //        [weakSelf bendData];
    //    }];
}
-(void)bendData{
    [kFormCellService bendCellDataWithCellViewArray:_mtableView.defaultSection.noReUseViewArray withDataDic:self.data];
}
@end
