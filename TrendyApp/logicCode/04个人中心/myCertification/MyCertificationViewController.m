//
//  MyCertificationViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/4.
//  Copyright © 2019 55like. All rights reserved.
//

#import "MyCertificationViewController.h"
#import "MYRHTableView.h"
#import "WSButtonGroup.h"
#import "VertificationPhotoUpdataViewController.h"
#import "FCSelectCellView.h"
#import "FCTextFieldCellView.h"
//#import "FCSelectCellView.h"
@interface MyCertificationViewController ()
{
    
    
    
}
@property(nonatomic,strong)BaseFormCellView*driving_countryView;
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)WSButtonGroup*btnGroup;
@property(nonatomic,strong)SectionObj*centerObj1;
@property(nonatomic,strong)SectionObj*centerObj2;
@property(nonatomic,strong)SectionObj*lastObj;

@property(nonatomic,copy)NSString*is_auth;
@end

@implementation  MyCertificationViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[self.userInfo ojsk:@"driving_type"] isEqualToString:@"1"]) {
        if ([[self.userInfo ojsk:@"driving_auth"] isEqualToString:@"2"]&&[[self.userInfo ojsk:@"card_auth"] isEqualToString:@"2"]){
            _is_auth=@"1";
        }else{
            _is_auth=@"0";
        }
    }else{
        if ([[self.userInfo ojsk:@"driving_auth"] isEqualToString:@"2"]){
            _is_auth=@"1";
        }else{
            _is_auth=@"0";
        }
    }
//    _is_auth=@"0";
    self.data=self.userInfo;
    [self addView];
    if ([[self.userInfo ojsk:@"driving_type"] isEqualToString:@"1"]) {
        [self.btnGroup btnClickAtIndex:0];
    }else{
        [self.btnGroup btnClickAtIndex:1];
    }
    {
        NSMutableArray*view_marray=[NSMutableArray new];
        if ([[self.data ojsk:@"driving_type"] isEqualToString:@"1"]) {
            [view_marray addObjectsFromArray:_centerObj1.noReUseViewArray];
        }else{
            [view_marray addObjectsFromArray:_centerObj2.noReUseViewArray];
        }
        
        for (FCSelectCellView*subViews in view_marray) {
            NSArray*keyArray=[subViews.data ojk:@"keyArray"];
            if (keyArray.count) {
                NSMutableDictionary*mdic=[NSMutableDictionary new];
                BOOL isAdd=NO;
                for (NSString*keyStr in keyArray) {
                    if ([[self.data ojk:keyStr] notEmptyOrNull]) {
                        isAdd=YES;
                        NSString*strpath=[self.data ojk:keyStr];
                        {
                            NSRange range=[strpath rangeOfString:basePicPath];
                            if (range.length == 0) {
                                range=[strpath rangeOfString:@"trendycarshare.jp/upload/"];
                            }
                            
//                        https://h5.trendycarshare.jp/upload/2019-12-04/1575441133.jpeg
                            strpath=[strpath substringFromIndex:range.location+range.length];
                        }
                        
                        [mdic setObject:strpath forKey:keyStr];
                    }else{
                        isAdd=NO;
                    }
                }
                if (isAdd) {
                    subViews.defaultTextfield.text=kS(@"IdentityAuthentication", @"Uploaded");
                    [self setAddValue:mdic forKey:[subViews.data ojk:@"requestkey"]];
                }
            }else if([subViews isKindOfClass:[FCTextFieldCellView class]]){
                subViews.defaultTextfield.text=[self.data ojk:[subViews.data ojk:@"requestkey"]];
            }else if([[subViews.data ojk:@"requestkey"] isEqualToString:@"driving_country_id"]){
                if ([[self.data ojsk:@"driving_country_id"] notEmptyOrNull]) {
                    
                    subViews.defaultTextfield.text=[self.data ojsk:@"driving_country"];
                    NSMutableDictionary*mdic=[NSMutableDictionary new];
                    [mdic setObject:[self.data ojsk:@"driving_country"] forKey:@"name"];
                    [mdic setObject:[self.data ojsk:@"driving_country_id"] forKey:@"id"];
                    subViews.defaultTextfield.data=mdic;
//                    subViews.userInteractionEnabled=NO;
                }
//                [_driving_countryView.defaultTextfield.data ojsk:@"id"]
                
            }
        }
        
    }
    
    
    
    //    [self rightButton:@"相關頁面" image:nil sel:@selector(rightBtnClick:)];
}
-(void)submitBtnClick:(UIButton*)btn{
    btn.userInteractionEnabled=NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        btn.userInteractionEnabled=YES;
    });
    __weak __typeof(self) weakSelf = self;
    SectionObj*obj=_btnGroup.currentindex==0?weakSelf.centerObj1:weakSelf.centerObj2 ;
    [kFormCellService getRequestDictionaryWithformCellViewArray:obj.noReUseViewArray withBlock:^(id data, int status, NSString *msg) {
        if (status==200) {
            NSMutableDictionary* dictparam=[NSMutableDictionary new];
//            if (weakSelf.allcallBlock) {
//                weakSelf.allcallBlock(dictparam, 200, nil);
//                [weakSelf.navigationController popViewControllerAnimated:YES];
//            }
            [dictparam setObject:_btnGroup.currentindex==0?@"1":@"0" forKey:@"driving_type"];
            for (UIView*viewcell in obj.noReUseViewArray) {
                NSDictionary*paramDic=[weakSelf getAddValueForKey:[viewcell.data ojsk:@"requestkey"]];
                [dictparam addEntriesFromDictionary:paramDic];
            }
            if ([data ojk:@"driving_country_id"]) {
                [dictparam setObject:[data ojk:@"driving_country_id"] forKey:@"driving_country"];
                if ([[_driving_countryView.defaultTextfield.data ojsk:@"id"] notEmptyOrNull]) {
                    [dictparam setObject:[_driving_countryView.defaultTextfield.data ojsk:@"id"] forKey:@"driving_country_id"];
                }else if ([[self.userInfo ojsk:@"driving_country_id"] notEmptyOrNull]) {
                   
                    [dictparam setObject:[self.userInfo ojsk:@"driving_country_id"] forKey:@"driving_country_id"];
                }
            }
            
            
            [kUserCenterService ucenter_authentication:dictparam withBlock:^(id data, int status, NSString *msg) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
        }
    }];
}
#pragma mark -   write UI
-(void)addView{
      __weak __typeof(self) weakSelf = self;
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    {
        UIView*viewSwichType=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 65) backgroundcolor:nil superView:nil];
        _mtableView.defaultSection.selctionHeaderView=viewSwichType;
        
        if ([_is_auth isEqualToString:@"1"]) {
            viewSwichType.userInteractionEnabled=NO;
        }
        float width=150;
        
//        NSArray*arraytitle=@[@"有日本駕駛證",@"無日本駕駛證",]; driving_type
        NSArray*arraytitle=@[kS(@"IdentityAuthentication", @"JapaneseDrivesrLicense"),kS(@"IdentityAuthentication", @"NoJapaneseDrivingLicense"),];
        _btnGroup=[WSButtonGroup new];
        [_btnGroup setGroupClickBlock:^(WSButtonGroup *group) {
            [weakSelf.mtableView.sectionArray removeObject:weakSelf.centerObj1];
            [weakSelf.mtableView.sectionArray removeObject:weakSelf.centerObj2];
//            [weakSelf.mtableView.sectionArray addObject:group.currentindex==0?weakSelf.centerObj1:weakSelf.centerObj2];
            [weakSelf.mtableView.sectionArray insertObject:group.currentindex==0?weakSelf.centerObj1:weakSelf.centerObj2 atIndex:1];
            [weakSelf.mtableView reloadData];
        }];
        float myx = 15;
        for (int i=0; i<arraytitle.count; i++) {
             WSSizeButton*btnSwitch=[RHMethods buttonWithframe:CGRectMake(myx, 0, width, viewSwichType.frameHeight) backgroundColor:nil text:arraytitle[i] font:14 textColor:rgb(102, 102, 102) radius:0 superview:viewSwichType];
            [btnSwitch setImageStr:@"checkedoff" SelectImageStr:@"checkedon"];
            btnSwitch.frameWidth = [arraytitle[i] widthWithFont:14] +28+3+10;
            myx = btnSwitch.frameXW +3;
            [btnSwitch setBtnImageViewFrame:CGRectMake(0, 0, 19, 19)];
            [btnSwitch imgbeCY];
            [btnSwitch setBtnLableFrame:CGRectMake(28, 0, btnSwitch.frameWidth-btnSwitch.imgframeXW-10, btnSwitch.frameHeight)];
            [_btnGroup addButton:btnSwitch];
            
        }
    }
    {
        _centerObj1=[SectionObj new];
        NSArray*arraytitle=@[
                             @{
                                 @"classStr":@"FCSelectCellView",
//                                 @"name":@"日本駕駛證",
                                 @"name":kS(@"IdentityAuthentication", @"JapaneseDrivingLicense"),
                                 @"requestkey":@"a_driving_front__driving_behind",
                                 @"keyArray":@[@"driving_front",@"driving_behind"],
                                 //                                 driving_front    字符串    必须        驾驶证正页图片地址
                                 //                                 driving_behind    字符串    必须        驾驶证副页图片地址
//                                 @"placeholder":@"未選擇",
                                 @"placeholder":kS(@"IdentityAuthentication", @"PleaseUpload"),
                                 @"isMust":@"1",
                                 },
//                             @{
//                                 @"classStr":@"FCSelectCellView",
////                                 @"name":@"本人信用卡",
//                                 @"name":kS(@"IdentityAuthentication", @"UploadCreditCard"),
//                                 @"requestkey":@"card_path",
//                                 @"keyArray":@[@"card_path",],
////                                 @"placeholder":@"未選擇",
//                                 @"placeholder":kS(@"IdentityAuthentication", @"PleaseUpload"),
//                                 @"isMust":@"1",
//                                 },
                             
                             
                             ];
        
        arraytitle=[arraytitle toBeMutableObj];
        [_mtableView.defaultSection.noReUseViewArray removeAllObjects];
        for (int i=0; i<arraytitle.count; i++) {
            NSMutableDictionary*dic=arraytitle[i];
            BaseFormCellView*viewCell=[UIView getViewWithConfigData:dic];
            [_centerObj1.noReUseViewArray addObject:viewCell];
            [viewCell addViewTarget:self select:@selector(cellViewClick:)];
            if ([viewCell isKindOfClass:[viewCell class]]) {
                viewCell.defaultTextfield.textColor=rgb(13, 107, 154);
            }
        }
    }
    {
        _centerObj2=[SectionObj new];
        NSArray*arraytitle=@[
                             @{
                                 @"classStr":@"FCSelectCellView",
//                                 @"name":@"選擇您所在的國家",
                                 @"name":kS(@"IdentityAuthentication", @"ChooseYourCountry"),
//                                 @"requestkey":@"driving_country",
                                  @"requestkey":@"driving_country_id",
                                 
                                 @"selectsubtype":@"selectCate",
//                                 @"placeholder":@"未選擇",
                                 @"placeholder":kS(@"IdentityAuthentication", @"PleaseInput"),
                                 @"isMust":@"1",
                                 },
                             @{
                                 @"classStr":@"FCSelectCellView",
//                                 @"name":@"您所在的國家駕駛證",
                                 @"name":kS(@"IdentityAuthentication", @"DrivingLicenseInYourCountry"),
                                 @"requestkey":@"b_driving_front__driving_behind",
                                 @"keyArray":@[@"driving_front",@"driving_behind",],
//                                 driving_front    字符串    必须        驾驶证正页图片地址
//                                 driving_behind    字符串    必须        驾驶证副页图片地址
                                 //                                 @"placeholder":@"未選擇",
                                 @"placeholder":kS(@"IdentityAuthentication", @"PleaseUpload"),
                                 @"isMust":@"1",
                                 },
//                             @{
//                                 @"classStr":@"FCSelectCellView",
//                                 @"name":@"選擇您所在的國家",
////                                 @"placeholder":@"未選擇",
//                                 @"placeholder":kS(@"IdentityAuthentication", @"PleaseChoose"),
//                                 },
                             @{
                                 @"classStr":@"FCSelectCellView",
//                                 @"name":@"國際駕駛證",
                                 @"name":kS(@"IdentityAuthentication", @"InternationalDrivingLicense"),
//                                 inter_driving_front    字符串    必须        国际驾驶证正页图片地址
//                                 inter_driving_behind    字符串    必须        国际驾驶证副页图片地址
                                 @"requestkey":@"inter_driving_front__inter_driving_behind",
                                 @"keyArray":@[@"inter_driving_front",@"inter_driving_behind",],
//                                 @"placeholder":@"未選擇",
                                 @"placeholder":kS(@"IdentityAuthentication", @"PleaseUpload"),
                                 @"isMust":@"1",
                                 },
                             @{
                                 @"classStr":@"FCSelectCellView",
//                                 @"name":@"護照",
                                 @"name":kS(@"IdentityAuthentication", @"Passport"),
                                 @"requestkey":@"passport",
                                 @"keyArray":@[@"passport",],
//                                 @"placeholder":@"未選擇",
                                 @"placeholder":kS(@"IdentityAuthentication", @"PleaseUpload"),
                                 @"isMust":@"1",
                                 },];
        
        arraytitle=[arraytitle toBeMutableObj];
        [_mtableView.defaultSection.noReUseViewArray removeAllObjects];
        for (int i=0; i<arraytitle.count; i++) {
            NSMutableDictionary*dic=arraytitle[i];
            BaseFormCellView*viewCell=[UIView getViewWithConfigData:dic];
            [_centerObj2.noReUseViewArray addObject:viewCell];
            if (![[dic ojsk:@"requestkey"] isEqualToString:@"driving_country_id"]) {
                [viewCell addViewTarget:self select:@selector(cellViewClick:)];
            }
            if ([[dic ojsk:@"requestkey"] isEqualToString:@"driving_country_id"]) {
//                [viewCell addViewTarget:self select:@selector(cellViewClick:)];
                _driving_countryView=viewCell;
                krequestParam
                
                [NetEngine createPostAction:@"welcome/countryList" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
                    if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
                        NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
                        for (NSMutableDictionary*mdic in dic[@"list"]) {
                            [mdic setObject:[mdic ojsk:@"name"] forKey:@"title"];
                        }
                        
                        
                        [viewCell.data setObject:[dic ojk:@"list"] forKey:@"cateList"];
                        
                    }else{
                        [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
                        
                    }
                }];

            }
            
            if ([viewCell isKindOfClass:[viewCell class]]) {
                viewCell.defaultTextfield.textColor=rgb(13, 107, 154);
            }
//              @"selectsubtype":@"selectCate",   @"requestkey":@"a_driving_front__driving_behind",
            if ([_is_auth isEqualToString:@"1"]&&([[dic ojsk:@"selectsubtype"] isEqualToString:@"selectCate"]||[[dic ojsk:@"requestkey"] isEqualToString:@"a_driving_front__driving_behind"])) {
                viewCell.userInteractionEnabled=NO;
            }
            
        }
    }
    
    _lastObj=[SectionObj new];
    
    [_mtableView.sectionArray addObject:_lastObj];
    if (![self.is_auth isEqualToString:@"1"]) {
        WSSizeButton*btnCommit=[RHMethods buttonWithframe:CGRectMake(15, 40, kScreenWidth-30, 44) backgroundColor:rgb(13, 107, 154) text:kS(@"IdentityAuthentication", @"Submit") font:17 textColor:rgb(255, 255, 255) radius:5 superview:nil];
        [_lastObj.noReUseViewArray addObject:btnCommit];
        [btnCommit addViewTarget:self select:@selector(submitBtnClick:)];
    }
    
    {
//        UILabel*lbRemark=[RHMethods lableX:15 Y:20 W:kScreenWidth-30 Height:0 font:12 superview:nil withColor:rgb(153, 153, 153) text:@"請完成以上證件上傳并提交\n平台將在4小時內完成認證操作\n工作時間：週一~週日（9:00-18:00）"];
        UILabel*lbRemark=[RHMethods lableX:15 Y:20 W:kScreenWidth-30 Height:0 font:12 superview:nil withColor:rgb(153, 153, 153) text:[NSString stringWithFormat:@"%@\n%@\n%@",kS(@"IdentityAuthentication", @"AboveDocuments"),kS(@"IdentityAuthentication", @"OperationIn4Hours"),kS(@"IdentityAuthentication", @"MondayToSunday")]];
        [_lastObj.noReUseViewArray addObject:lbRemark];
    }
    
}

-(void)cellViewClick:(BaseFormCellView*)viewCell{
    
    if (![viewCell isKindOfClass:[FCSelectCellView class]]) {
        return;
    }
    
    NSMutableDictionary*mdataDic=viewCell.data;
    NSDictionary*dic=nil;
    //日本驾证
    if ([[mdataDic ojsk:@"requestkey"] isEqualToString:@"a_driving_front__driving_behind"]) {
        dic=@{
              @"title":kS(@"IdentityAuthentication", @"DriversLicense"),
//              @"describe":@"請上傳您本人的日本駕駛證,請確保圖片清晰,四角完整！",
              @"describe":kS(@"IdentityAuthentication", @"PleaseUploadJapaneseDriversLicense"),
              @"is_auth":_is_auth,
              @"list":@[
                      @{
                          @"requestkey":@"driving_front",
//                          @"placeholder":@"上傳駕證主頁",
                          @"placeholder":kS(@"IdentityAuthentication", @"UploadDrivingLicenseHomePage"),
                          },
                      @{
                          @"requestkey":@"driving_behind",
//                          @"placeholder":@"上傳駕證副頁",
                          @"placeholder":kS(@"IdentityAuthentication", @"UploadDrivingLicenseSubpage"),
                          },
                      ],
              };
//        本人信用卡
    }else    if ([[mdataDic ojsk:@"requestkey"] isEqualToString:@"card_path"]) {
        dic=@{
              @"title":kS(@"IdentityAuthentication", @"PersonalCreditCard"),
//              @"describe":@"請上傳您本人的信用卡,請確保圖片清晰,四角完整！",
              @"describe":kS(@"IdentityAuthentication", @"PleaseUploadYourCreditCard"),
              @"is_auth":_is_auth,
              @"list":@[
                      @{
                          @"requestkey":[mdataDic ojsk:@"requestkey"],
//                          @"placeholder":@"上傳信用卡",
                          @"placeholder":kS(@"IdentityAuthentication", @"UploadCreditCard"),
                          },
                      ],
              };
//您所在的國家駕駛證
    }else    if ([[mdataDic ojsk:@"requestkey"] isEqualToString:@"b_driving_front__driving_behind"]) {
        dic=@{
//              @"title":@"駕證",
              @"title":kS(@"IdentityAuthentication", @"DriversLicense"),
//              @"describe":@"請上傳您所在國家本人的駕駛證,請確保圖片清晰,四角完整！",
              @"describe":kS(@"IdentityAuthentication", @"PleaseUploadYourDriversLicenseCountry"),
              @"is_auth":_is_auth,
              @"list":@[
                      @{
                          @"requestkey":@"driving_front",
                          //                          @"placeholder":@"上傳駕證主頁",
                          @"placeholder":kS(@"IdentityAuthentication", @"UploadDrivingLicenseHomePage"),
                          },
                      @{
                          @"requestkey":@"driving_behind",
                          //                          @"placeholder":@"上傳駕證副頁",
                          @"placeholder":kS(@"IdentityAuthentication", @"UploadDrivingLicenseSubpage"),
                          },
                      ],
              };
        
        //國際駕駛證
    }else    if ([[mdataDic ojsk:@"requestkey"] isEqualToString:@"inter_driving_front__inter_driving_behind"]) {
        dic=@{
//              @"title":@"國際駕證",
              @"title":kS(@"IdentityAuthentication", @"InternationalDrivingLicense"),
//              @"describe":@"請上傳您本人的國際駕證,請確保圖片清晰,四角完整！",
              @"describe":kS(@"IdentityAuthentication", @"PleaseUploadYourInternational"),
              @"is_auth":_is_auth,
              @"list":@[
                      @{
                          @"requestkey":@"inter_driving_front",
//                          @"placeholder":@"上傳國際駕證主頁",
//                          @"placeholder":@"上傳國際駕證主頁",
                          @"placeholder":kS(@"IdentityAuthentication", @"UploadInternationalDrivingLicenseHomePage"),
                          },
                      @{
                          @"requestkey":@"inter_driving_behind",
//                          @"placeholder":@"上傳國際駕證副頁",
                          @"placeholder":kS(@"IdentityAuthentication", @"UploadInternationalDLSupplementaryPage"),
                          },
                      ],
              };
    }else    if ([[mdataDic ojsk:@"requestkey"] isEqualToString:@"passport"]) {
        dic=@{
//              @"title":@"護照",
              @"title":kS(@"IdentityAuthentication", @"Passport"),
//              @"describe":@"請上傳您本人的護照,請確保圖片清晰,四角完整！",
              @"describe":kS(@"IdentityAuthentication", @"PleaseUploadYourPassport"),
              @"is_auth":_is_auth,
              @"list":@[
                      @{
                          @"requestkey":@"passport",
//                          @"placeholder":@"上傳國際駕證主頁",
                          @"placeholder":kS(@"IdentityAuthentication", @"UploadPassport"),
                          },
                      ],
              };
    }
      __weak __typeof(self) weakSelf = self;
    [self pushController:[VertificationPhotoUpdataViewController class] withInfo:[weakSelf getAddValueForKey:[mdataDic ojsk:@"requestkey"]] withTitle:[mdataDic ojsk:@"name"] withOther:dic withAllBlock:^(id data, int status, NSString *msg) {
        [weakSelf setAddValue:data forKey:[mdataDic ojsk:@"requestkey"]];
        viewCell.defaultTextfield.text=kS(@"IdentityAuthentication", @"Uploaded");
    }];
    
    
}

#pragma mark  request data from the server use tableview

#pragma mark - request data from the server

#pragma mark - event listener function


#pragma mark - delegate function


@end
