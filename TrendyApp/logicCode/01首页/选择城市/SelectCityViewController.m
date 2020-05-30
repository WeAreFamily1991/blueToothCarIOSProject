//
//  SelectCityViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/12.
//  Copyright © 2019 55like. All rights reserved.
//

#import "SelectCityViewController.h"
#import "MYRHTableView.h"
#import "Utility_Location.h"

@interface SelectCityViewController ()<RHTableViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)MYRHTableView *mtableView;
@property(nonatomic,strong)UITextField *txtSearch;
@property(nonatomic,strong)UIView *viewHeaderBG;
@property(nonatomic,strong)UIView *locationView;

@end

@implementation SelectCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self.navView viewWithTag:104] setHidden:YES];
    [self initUI];
    [self request];
}
-(void)initUI{
    __weak typeof(self) weakSelf=self;
    //LocationCity
    {
        UIView *viewSearchBG=[RHMethods viewWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, 50) backgroundcolor:rgbwhiteColor superView:self.view];
        UIView *viewBG=[RHMethods viewWithFrame:CGRectMake(15, 5, kScreenWidth-30, 30) backgroundcolor:rgbGray superView:viewSearchBG];
        [viewBG viewLayerRoundBorderWidth:0.01 cornerRadius:5 borderColor:nil];
        [RHMethods imageviewWithFrame:CGRectMake(0, 0, 30, 30) defaultimage:@"searchi" contentMode:UIViewContentModeCenter supView:viewBG];
        _txtSearch=[RHMethods textFieldlWithFrame:CGRectMake(30, 0, W(viewBG)-30, 30) font:fontTxtContent color:rgbTitleColor placeholder:kS(@"CitySelect", @"inputCityName") text:@"" supView:viewBG];
        _txtSearch.delegate=self;
        _txtSearch.returnKeyType=UIReturnKeySearch;
        [_txtSearch addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
        
    }
    {
        _viewHeaderBG=[RHMethods viewWithFrame:CGRectMake(0, 0, kScreenWidth, 20) backgroundcolor:rgbGray superView:nil];
        float ftempY=0;
        //定位城市
        {
            
        }
        //熱門城市
        {
            
            {
                
                NSDictionary*dic=nil;
                if ([weakSelf.userInfo isEqualToString:@"还车地址"]) {
                 dic=   kUtility_Location.userCityReturn;
                }else{
                     dic=   kUtility_Location.userCityTake;
                }
                UILabel*label1=   [RHMethods labelWithFrame:CGRectMake(15, 0, kScreenWidth-30, 35) font:fontTitle color:rgbTitleColor text:kS(@"CitySelect", @"LocationCity") supView:_viewHeaderBG];
                ftempY+=35;
                UIView *viewBG1=[RHMethods viewWithFrame:CGRectMake(0, ftempY, kScreenWidth, 30+30) backgroundcolor:rgbwhiteColor superView:_viewHeaderBG];
                ftempY=viewBG1.frameYH;
                UIButton *btnCity=[RHMethods buttonWithframe:CGRectMake(15, 15, 50, 30) backgroundColor:nil text:@"" font:16 textColor:rgbTitleColor radius:5 superview:viewBG1 reuseId:@"btnCity"];
                btnCity.hidden=NO;
                btnCity.layer.borderWidth=0.5;
                btnCity.layer.borderColor =[rgbLineColor CGColor];
                [btnCity setTitle:[dic ojsk:@"name"] forState:UIControlStateNormal];
                btnCity.data=dic;
                
                float fw=[btnCity.titleLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, 30)].width+30;
                fw=fw>kScreenWidth-30?kScreenWidth-30:fw;
                btnCity.frameWidth=fw;
//                if ([weakSelf.userInfo isEqualToString:@"还车地址"]) {
//                    kUtility_Location.userCityReturn=view.data;
//                }else{
//                    kUtility_Location.userCityTake=view.data;
//                }
                
                [btnCity addViewClickBlock:^(UIView *view) {
                    if ([weakSelf.userInfo isEqualToString:@"还车地址"]) {
                        kUtility_Location.userCityReturn=view.data;
                    }else{
                        kUtility_Location.userCityTake=view.data;
                        kUtility_Location.userCityReturn=[view.data toBeMutableObj];
                    }
                    
                    [weakSelf.viewHeaderBG upDataMe];
                    [weakSelf.mtableView reloadData];
                    [weakSelf selectCity];
                }];
                _locationView=viewBG1;
//                [viewBG1 setAddUpdataBlock:^(id data, id weakme) {
//                    btnCity
//                }];
//
                
            
            }
            
            
            
            UILabel*label2=    [RHMethods labelWithFrame:CGRectMake(15, ftempY, kScreenWidth-30, 35) font:fontTitle color:rgbTitleColor text:kS(@"CitySelect", @"HotCity") supView:_viewHeaderBG];
            ftempY+=35;
            UIView *viewBG2=[RHMethods viewWithFrame:CGRectMake(0, ftempY, kScreenWidth, 15) backgroundcolor:rgbwhiteColor superView:_viewHeaderBG];
            ftempY+=H(viewBG2)+35;
            
            //
            [_viewHeaderBG setAddUpdataBlock:^(id data, id weakme) {
                
                
                {
                    float fy=15;
                    float fx=15;
                    NSArray *arrayT=data;
                    for (UIView *view in [viewBG2 subviews]) {
                        view.hidden=YES;
                    }
                    viewBG2.frameHeight=15;
                    for (int i=0;i<arrayT.count;i++) {
                        NSDictionary *dic = arrayT[i];
                        UIButton *btnCity=[RHMethods buttonWithframe:CGRectMake(fx, fy, 50, 30) backgroundColor:nil text:@"" font:16 textColor:rgbTitleColor radius:5 superview:viewBG2 reuseId:[NSString stringWithFormat:@"btnCity%d",i]];
                        btnCity.hidden=NO;
                        btnCity.layer.borderWidth=0.5;
                        btnCity.layer.borderColor =[rgbLineColor CGColor];
                        [btnCity setTitle:[dic ojsk:@"name"] forState:UIControlStateNormal];
                        btnCity.data=dic;
                        [btnCity addViewClickBlock:^(UIView *view) {
                            if ([weakSelf.userInfo isEqualToString:@"还车地址"]) {
                                kUtility_Location.userCityReturn=view.data;
                            }else{
                                kUtility_Location.userCityTake=view.data;
                            }
                            
                            [weakSelf.viewHeaderBG upDataMe];
                            [weakSelf.mtableView reloadData];
                            [weakSelf selectCity];
                        }];
                        float fw=[btnCity.titleLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, 30)].width+30;
                        fw=fw>kScreenWidth-30?kScreenWidth-30:fw;
                        btnCity.frameWidth=fw;
                        if (btnCity.frameWidth>kScreenWidth-15) {
                            fx=15;
                            fy+=H(btnCity)+10;
                            btnCity.frameX=fx;
                        }
                        fx+=fw+10;
                        viewBG2.frameHeight=YH(btnCity)+15;
                        NSString *sId=[kUtility_Location.userCityTake ojsk:@"id"];
                        if ([weakSelf.userInfo isEqualToString:@"还车地址"]) {
                            sId=[kUtility_Location.userCityReturn ojsk:@"id"];
                        }
                        if ([[dic ojsk:@"id"] isEqualToString:sId]) {
                            [btnCity setTitleColor:rgbpublicColor forState:UIControlStateNormal];
                        }else{
                            [btnCity setTitleColor:rgbTitleColor forState:UIControlStateNormal];
                        }
                    }
                    weakSelf.viewHeaderBG.frameHeight=YH(viewBG2)+10;
                    if (![weakSelf.txtSearch.text notEmptyOrNull]) {
                        weakSelf.mtableView.tableHeaderView=weakSelf.viewHeaderBG;
                    }
                }
            }];
        }
        _viewHeaderBG.frameHeight=ftempY;
    }
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, kTopHeight+50, kScreenWidth, kContentHeight-50) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mtableView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_mtableView];
    _mtableView.delegate2=self;
    _mtableView.tableHeaderView=_viewHeaderBG;
    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
        UIView *viewcell=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 45) backgroundcolor:rgbwhiteColor superView:reuseView reuseId:@"viewcell"];
        [RHMethods viewWithFrame:CGRectMake(15, H(viewcell)-0.5, kScreenWidth-15, 0.5) backgroundcolor:rgbLineColor superView:viewcell reuseId:@"viewLine"];
        UILabel *lblTitle=[RHMethods labelWithFrame:CGRectMake(15, 10, kScreenWidth-30, 25) font:fontTitle color:rgbTitleColor text:@"" textAlignment:NSTextAlignmentLeft supView:viewcell reuseId:@"lblTitle" ];
        lblTitle.text=[Datadic ojsk:@"name"];
        NSString *sId=[kUtility_Location.userCityTake ojsk:@"id"];
        if ([weakSelf.userInfo isEqualToString:@"还车地址"]) {
            sId=[kUtility_Location.userCityReturn ojsk:@"id"];
        }
        if ([[Datadic ojsk:@"id"] isEqualToString:sId]) {
            lblTitle.textColor=rgbpublicColor;
        }else{
            lblTitle.textColor=rgbTitleColor;
        }
        return viewcell;
    }];
    [_mtableView.defaultSection setSectionIndexClickBlock:^(id Datadic, NSInteger row) {
        if ([weakSelf.userInfo isEqualToString:@"还车地址"]) {
            kUtility_Location.userCityReturn=Datadic;
            
            
        }else{//取车地址
            kUtility_Location.userCityTake=Datadic;
            
            
        }
        [weakSelf.viewHeaderBG upDataMe];
        [weakSelf.mtableView reloadData];
        [weakSelf selectCity];
        //        [weakSelf pushController:[TourismContentViewController class] withInfo:@"" withTitle:@"" withOther:[Datadic valueForJSONStrKey:@"id"]];
    }];
    
}
-(void)selectCity{
    self.allcallBlock?self.allcallBlock(nil, 200, nil):nil;
    [self backButtonClicked:nil];
}
#pragma mark  request data from the server use tableview
-(void)request{
    krequestParam
    _mtableView.urlString=[NSString stringWithFormat:@"welcome/cityList%@",dictparam.wgetParamStr];
    [_mtableView refresh];
}

#pragma mark search
-(void)loadSearch:(NSString *)strTxt{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *tempResults = [NSMutableArray array];
        NSArray *tArray=_mtableView.dataArray;
        if ([strTxt notEmptyOrNull]) {
            NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
            
            for (int i = 0; i < tArray.count; i++) {
                NSDictionary *dict=tArray[i];
                NSString *storeString = [dict valueForJSONStrKey:@"name"];
                NSRange storeRange = NSMakeRange(0, storeString.length);
                NSRange foundRange = [storeString rangeOfString:strTxt options:searchOptions range:storeRange];
                if (foundRange.length) {
                    [tempResults addObject:dict];
                }else{
                   
                }
            }
        }else{
            [tempResults addObjectsFromArray:tArray];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_mtableView showNullHint:NO];
            _mtableView.defaultSection.dataArray=tempResults;
            if ([strTxt notEmptyOrNull]) {
                _mtableView.tableHeaderView=nil;
                if (tempResults.count>0) {
                }else{
                    [_mtableView showNullHint:YES];
                }
            }else{
                self.mtableView.tableHeaderView=self.viewHeaderBG;
            }
            [_mtableView reloadData];
        });
    });
    
    
}
#pragma mark RHTableViewDelegate
- (void)refreshData:(RHTableView *)view{
    //hotlist
    if (view.dataDic) {
        [_viewHeaderBG upDataMeWithData:[view.dataDic ojk:@"hotlist"]];
    }
}
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self loadSearch:textField.text];
    return YES;
}
#pragma mark - change
-(void)textFieldTextChange:(UITextField *)textField{
    NSLog(@"textField1 - 输入框内容改变,当前内容为: %@",textField.text);
    [self loadSearch:textField.text];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
