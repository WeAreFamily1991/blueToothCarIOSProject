//
//  SearchVehicleLocationViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/5.
//  Copyright © 2019 55like. All rights reserved.
//

#import "SearchVehicleLocationViewController.h"
#import "MYRHTableView.h"
#import "SearchVehicleLocationDetailViewController.h"
#import "Utility_Location.h"
#import <GooglePlaces/GooglePlaces.h>

#define KSaveHistoricalRecord @"SaveHistoricalRecord"

@interface SearchVehicleLocationViewController ()<GMSAutocompleteViewControllerDelegate>
{
    GMSAutocompleteFilter *_filter;
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)NSMutableArray *arrayHistory;
@property(nonatomic,strong)NSMutableArray *arrayNearPlace;
@property(nonatomic,strong)UIView *viewHistoryBG;
@property(nonatomic,strong)UIView *viewNearPlaceBG;

@end

@implementation  SearchVehicleLocationViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* languageStr=kLanguageService.appLanguage;
    
    //    当前语言 appLanguage cn jp en
    
    if ([languageStr isEqualToString:@"cn"]) {
        languageStr=@"zh_Hans_HK";
    }else if ([languageStr isEqualToString:@"jp"]) {
        
        languageStr=@"ja_JP";
    }else if ([languageStr isEqualToString:@"en"]) {
        
        languageStr=@"en_US";
    }
    // 强制 成 当前设置语言
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:languageStr,nil]
                                              forKey:@"AppleLanguages"];
    
    [[self.navView viewWithTag:104] setHidden:YES];
    _arrayHistory=[NSMutableArray new];
    if ([Utility defaultsForKey:KSaveHistoricalRecord]) {
        [_arrayHistory addObjectsFromArray:[Utility defaultsForKey:KSaveHistoricalRecord]];
    }
//    [self navbarTitle:@" "];
    [self addView];
    [self loadDATA];
 
    
}



#pragma mark -   write UI
-(void)addView{
    __weak typeof(self) weakSelf=self;
    NSString *str_searchHint=kS(@"useCarAddress", @"searchHint");//
    NSString *str_nearAddress=kS(@"useCarAddress", @"nearAddress");//
    NSString *str_searchHistory=kS(@"useCarAddress", @"searchHistory");//
    if (self.userInfo && [self.userInfo isEqualToString:@"end"]) {
        
        str_searchHint=kS(@"returnCarAddress", @"searchHint");//
        str_nearAddress=kS(@"returnCarAddress", @"nearAddress");//
        str_searchHistory=kS(@"returnCarAddress", @"searchHistory");//
    }
    
    UIView*viewTopSearch=[UIView viewWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, 45) backgroundcolor:rgb(255, 255, 255) superView:self.view];
    {
        UIView*viewSearchContent=[UIView viewWithFrame:CGRectMake(15, 3, kScreenWidth-101-15, 30) backgroundcolor:rgb(246, 246, 246) superView:viewTopSearch];
        [viewSearchContent addViewTarget:self select:@selector(searchBtnClick:)];
        viewSearchContent.layer.cornerRadius=5;
        UIImageView*imgVSearch=[RHMethods imageviewWithFrame:CGRectMake(10, 9, 12, 12) defaultimage:@"searchi" supView:viewSearchContent];
         UITextField*tfSearch=[RHMethods textFieldlWithFrame:CGRectMake(imgVSearch.frameXW+10, 0, viewSearchContent.frameWidth-20-imgVSearch.frameXW, viewSearchContent.frameHeight) font:Font(13) color:rgb(51, 51, 51) placeholder:str_searchHint text:@""  supView:viewSearchContent];
        tfSearch.userInteractionEnabled=NO;
//        tfSearch.text=@"行徳駅前3丁目";
        
         WSSizeButton*btnMyLocation=[RHMethods buttonWithframe:CGRectMake(viewSearchContent.frameXW, 3, 101, viewSearchContent.frameHeight) backgroundColor:nil text:[NSString stringWithFormat:@"  %@",kS(@"KeyHome", @"myAddress")] font:13 textColor:rgb(51,51,51) radius:0 superview:viewTopSearch];
        [btnMyLocation setImageStr:@"iconi1" SelectImageStr:nil];
        [btnMyLocation addViewClickBlock:^(UIView *view) {
            NSMutableDictionary *dic=[NSMutableDictionary new];
            [dic setValue:kUtility_Location.userlatitude forKey:@"lat"];
            [dic setValue:kUtility_Location.userlongitude forKey:@"lng"];
            [dic setValue:kUtility_Location.userAddress?kUtility_Location.userAddress:@"" forKey:@"title"];
            weakSelf.allcallBlock?weakSelf.allcallBlock(dic, 200, nil):nil;
            [weakSelf backButtonClicked:nil];
        }];
        
    }
    
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, viewTopSearch.frameYH, kScreenWidth, kScreenHeight-viewTopSearch.frameYH) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    
    {
        {
            //@"附近地点",
            UIView *viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 55) backgroundcolor:rgbwhiteColor superView:nil];
            [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
            [RHMethods lableX:16 Y:0 W:0 Height:55 font:16 superview:viewContent withColor:rgb(102, 102, 102) text:str_nearAddress];//@"附近地点"

            
            _viewNearPlaceBG=[UIView viewWithFrame:CGRectMake(0, 55, kScreenWidth, 50) backgroundcolor:rgbwhiteColor superView:viewContent];
            [_viewNearPlaceBG setAddUpdataBlock:^(id data, id weakme) {
                for (UIView *view in [weakSelf.viewNearPlaceBG subviews]) {
                    [view setHidden:YES];
                }
                float sx=15;
                float sy=0;
                for (int i=0; i<weakSelf.arrayNearPlace.count; i++) {
                    NSDictionary *dic=weakSelf.arrayNearPlace[i];
                    WSSizeButton*btnCell=[RHMethods buttonWithframe:CGRectMake(sx,sy , 30, 30) backgroundColor:RGBACOLOR(13, 107, 154, 0.1) text:[dic ojsk:@"title"] font:14 textColor:rgb(13, 107, 154) radius:3 superview:weakSelf.viewNearPlaceBG reuseId:[NSString stringWithFormat:@"btnCell_%d",i]];
                    btnCell.hidden=NO;
                    btnCell.data=dic;
                    [btnCell setTitle:[dic ojsk:@"title"] forState:UIControlStateNormal];
                    btnCell.frameWidth=[btnCell.currentTitle widthWithFont: 14]+32;
                    if (btnCell.frameWidth>viewContent.frameWidth-30) {
                        btnCell.frameWidth=viewContent.frameWidth-30;
                    }
                    if (btnCell.frameXW>viewContent.frameWidth-14) {
                        btnCell.frameX=15;
                        btnCell.frameY=btnCell.frameYH+10;
                    }
                    sx=btnCell.frameXW+10;
                    sy=btnCell.frameY;
                    [btnCell addViewClickBlock:^(UIView *view) {
                        weakSelf.allcallBlock?weakSelf.allcallBlock(view.data, 200, nil):nil;
                        [weakSelf backButtonClicked:nil];
                    }];
                }
                weakSelf.viewNearPlaceBG.frameHeight=sy+30+20;
                viewContent.frameHeight=YH(weakSelf.viewNearPlaceBG);
            }];
            [_viewNearPlaceBG upDataMe];
        }
        {
            //@"历史记录"
            UIView *viewContent=[UIView viewWithFrame:CGRectMake(0, 10, kScreenWidth, 55) backgroundcolor:rgbwhiteColor superView:nil];
            [_mtableView.defaultSection.noReUseViewArray addObject:viewContent];
            [RHMethods lableX:16 Y:0 W:0 Height:55 font:16 superview:viewContent withColor:rgb(102, 102, 102) text:str_searchHistory];
            
            UIButton *btnDelete=[RHMethods buttonWithFrame:CGRectMake(0, 0, 18+30, 55) title:nil image:@"deli" bgimage:nil supView:viewContent];
            btnDelete.frameRX=0;
            [btnDelete addViewClickBlock:^(UIView *view) {
                [weakSelf.arrayHistory removeAllObjects];
                [Utility saveToDefaults:weakSelf.arrayHistory forKey:KSaveHistoricalRecord];
                [weakSelf.mtableView reloadData];
            }];
            _viewHistoryBG=[UIView viewWithFrame:CGRectMake(0, 55, kScreenWidth, 50) backgroundcolor:rgbwhiteColor superView:viewContent];
//            NSArray*arraybtntitle=@[@"漕河泾开发区",@"漕河泾开发区",@"漕河泾开发区",@"漕河泾开发区",@"漕河泾开发区",@"漕河泾开发区",@"漕河泾开发区",@"漕河泾开发区",];
            [_viewHistoryBG setAddUpdataBlock:^(id data, id weakme) {
                btnDelete.hidden=weakSelf.arrayHistory.count==0;
                for (UIView *view in [weakSelf.viewHistoryBG subviews]) {
                    [view setHidden:YES];
                }
                float sx=15;
                float sy=0;
                for (int i=0; i<weakSelf.arrayHistory.count; i++) {
                    NSDictionary *dic=weakSelf.arrayHistory[i];
                    WSSizeButton*btnCell=[RHMethods buttonWithframe:CGRectMake(sx,sy , 30, 30) backgroundColor:RGBACOLOR(13, 107, 154, 0.1) text:[dic ojsk:@"title"] font:14 textColor:rgb(13, 107, 154) radius:3 superview:weakSelf.viewHistoryBG reuseId:[NSString stringWithFormat:@"btnCell_%d",i]];
                    btnCell.hidden=NO;
                    btnCell.data=dic;
                    [btnCell setTitle:[dic ojsk:@"title"] forState:UIControlStateNormal];
                    btnCell.frameWidth=[btnCell.currentTitle widthWithFont: 14]+32;
                    if (btnCell.frameWidth>viewContent.frameWidth-30) {
                        btnCell.frameWidth=viewContent.frameWidth-30;
                    }
                    if (btnCell.frameXW>viewContent.frameWidth-14) {
                        btnCell.frameX=15;
                        btnCell.frameY=btnCell.frameYH+10;
                    }
                    sx=btnCell.frameXW+10;
                    sy=btnCell.frameY;
                    [btnCell addViewClickBlock:^(UIView *view) {
                        weakSelf.allcallBlock?weakSelf.allcallBlock(view.data, 200, nil):nil;
                        [weakSelf backButtonClicked:nil];
                    }];
                }
                weakSelf.viewHistoryBG.frameHeight=sy+30+20;
                viewContent.frameHeight=YH(weakSelf.viewHistoryBG);
            }];
            [_viewHistoryBG upDataMe];
        }
        
    }
    
}
-(void)searchBtnClick:(UIButton*)btn{
    [self autocompleteClicked];
//    [self pushController:[SearchVehicleLocationDetailViewController class] withInfo:nil withTitle:@"用車地點"];
    
}  // Present the autocomplete view controller when the button is pressed.
- (void)autocompleteClicked {
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    
    // Specify the place data types to return.
//    GMSPlaceField fields = (GMSPlaceFieldName | GMSPlaceFieldPlaceID);
//    acController.placeFields = fields;
    
    // Specify a filter.
    _filter = [[GMSAutocompleteFilter alloc] init];
//    _filter.type = kGMSPlacesAutocompleteTypeFilterAddress;
    _filter.type = kGMSPlacesAutocompleteTypeFilterNoFilter;
    acController.autocompleteFilter = _filter;
    
    // Display the autocomplete view controller.
    [self presentViewController:acController animated:YES completion:nil];
}
#pragma mark  request data from the server use tableview
-(void)request{
//    krequestParam
//
//    [dictparam setObject:@"%@" forKey:@"page"];
//    [dictparam setObject:@"12" forKey:@"limit"];
//    _mtableView.urlString=[NSString stringWithFormat:@"schedule/getList%@",dictparam.wgetParamStr];
//    [_mtableView refresh];
    
    
}
#pragma mark - request data from the server
-(void)loadDATA{
    krequestParam
    if ([kUtility_Location.userlatitude notEmptyOrNull] && [kUtility_Location.userlongitude notEmptyOrNull]) {
        [dictparam setValue:kUtility_Location.userlatitude forKey:@"lat"];
        [dictparam setValue:kUtility_Location.userlongitude forKey:@"lng"];
    }
    [NetEngine createGetAction_LJ:[NSString stringWithFormat:@"car/nearPlace%@",dictparam.wgetParamStr] onCompletion:^(id resData, BOOL isCache) {
        if ([[resData valueForJSONStrKey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dicData=[resData objectForJSONKey:@"data"];
            self.arrayNearPlace=[NSMutableArray new];
            for (id dic in [dicData ojk:@"list"]) {
                [dic setValue:[dic ojsk:@"address"] forKey:@"title"];
                [self.arrayNearPlace addObject:dic];
            }
            [self.viewNearPlaceBG upDataMe];
            [self.mtableView reloadData];
        }else{
            [SVProgressHUD  showImage:nil status:[resData valueForJSONKey:@"info"]];
        }
    }];
    
}
#pragma mark - event listener function


#pragma mark - delegate function


// Handle the user's selection.
- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:NO completion:^{
        // Do something with the selected place.
        NSLog(@"Place name %@", place.name);
        NSLog(@"Place ID %@", place.placeID);
        NSLog(@"Place attributions %@", place.attributions.string);
        DLog(@"formattedAddress:%@",place.formattedAddress);
        NSMutableDictionary *dic=[NSMutableDictionary new];
        [dic setValue:[NSString stringWithFormat:@"%f",place.coordinate.latitude] forKey:@"lat"];
        [dic setValue:[NSString stringWithFormat:@"%f",place.coordinate.longitude] forKey:@"lng"];
        [dic setValue:[NSString stringWithFormat:@"%@(%@)",place.name,place.formattedAddress] forKey:@"title"];
        //保存历史搜索
        if(![_arrayHistory containsObject:dic]){
            [_arrayHistory addObject:dic];
            [Utility saveToDefaults:_arrayHistory forKey:KSaveHistoricalRecord];
//            [_viewHistoryBG upDataMe];
//            [_mtableView reloadData];
        }
        self.allcallBlock?self.allcallBlock(dic, 200, nil):nil;
        [self backButtonClicked:nil];
    }];
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"ErrorTTTT: %@", [error description]);
}

// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
@end
