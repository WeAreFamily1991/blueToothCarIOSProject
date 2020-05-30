//
//  GoogleMapMyViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/28.
//  Copyright © 2019 55like. All rights reserved.
//
#import "MapSelectPointViewController.h"
#import <GoogleMaps/GoogleMaps.h>

#import "Utility_Location.h"

@interface MapSelectPointViewController ()<GMSMapViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)GMSMapView *mapView ;
@property(nonatomic,strong)GMSMutableCameraPosition *camera;
@property(nonatomic,strong)UITextField*txtSearch;
@property(nonatomic,strong)NSMutableArray*markerArray;

@end

@implementation MapSelectPointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self addView];
    __weak __typeof(self) weakSelf = self;
    [kUtility_Location loadUserLocation:^(id data, int status, NSString *msg) {
        if (status==200) {
            if (weakSelf.mapView==nil) {
                [weakSelf addView];
//                [weakSelf loadData];
            }
        }
    }];
    
    {
        [self backButton];
        
        //kS(@"EditDeliveryPlace", @"Preservation")
        [self rightButton:kS(@"mapFindCar", @"Determine") image:nil sel:@selector(okBtnClick:)];
//        //        UIView *viewSearchBG=[RHMethods viewWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, 50) backgroundcolor:rgbwhiteColor superView:self.view];
//        UIView *viewBG=[RHMethods viewWithFrame:CGRectMake(50, 5, kScreenWidth-50-15, 30) backgroundcolor:rgbGray superView:self.navView];
//        [viewBG viewLayerRoundBorderWidth:0.01 cornerRadius:5 borderColor:nil];
//        viewBG.frameBY=7;
//        [RHMethods imageviewWithFrame:CGRectMake(0, 0, 30, 30) defaultimage:@"searchi" contentMode:UIViewContentModeCenter supView:viewBG];
//        _txtSearch=[RHMethods textFieldlWithFrame:CGRectMake(30, 0, W(viewBG)-30, 30) font:fontTxtContent color:rgbTitleColor placeholder:kS(@"CitySelect", @"inputCityName") text:@"" supView:viewBG];
//        _txtSearch.delegate=self;
//        _txtSearch.returnKeyType=UIReturnKeySearch;
//        [_txtSearch addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    }
    
    // Do any additional setup after loading the view.
}
-(void)okBtnClick:(UIButton*)btn{
    
      __weak __typeof(self) weakSelf = self;
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    
    NSLog(@"%f,%f",_mapView.camera.target.longitude,_mapView.camera.target.latitude);
    
    
    [[GMSGeocoder geocoder] reverseGeocodeCoordinate:_mapView.camera.target completionHandler:^(GMSReverseGeocodeResponse * _Nullable obj, NSError * _Nullable error) {
        [SVProgressHUD dismiss];
        if (error) {
        }else{
            GMSAddress *placemark = obj.firstResult;//第一个位置是最精确的
            NSLog(@"%@",placemark.lines.firstObject);
            NSMutableDictionary*mdic=[NSMutableDictionary new];
            [mdic setObject:placemark.lines.firstObject forKey:@"mapaddr"];
            [mdic setObject:[NSString stringWithFormat:@"%f",_mapView.camera.target.longitude] forKey:@"lng"];
            [mdic setObject:[NSString stringWithFormat:@"%f",_mapView.camera.target.latitude] forKey:@"lat"];
            if (weakSelf.allcallBlock) {
                weakSelf.allcallBlock(mdic, 200, nil);
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
//            //赋值详细地址
        }
    }];
    
//    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
//
//    //反地理编码
//    [geocoder reverseGeocodeLocation:[[CLLocation alloc]initWithLatitude:_mapView.camera.target.latitude longitude:_mapView.camera.target.longitude] completionHandler:^(NSArray * _Nullable placemarks, NSError * _Nullable error) {
//
//        if (error) {
//        }else{
//
//            CLPlacemark *placemark = [placemarks objectAtIndex:0];//第一个位置是最精确的
//            //赋值详细地址
//            DLog(@"placemark---路号name:%@-市locality:%@-区subLocality:%@-省administrativeArea:%@-路thoroughfare:%@",placemark.name,placemark.locality,placemark.subLocality,placemark.administrativeArea,placemark.thoroughfare);
//        }
//        }];
//
    
}
- (void)addView {//addressi4
    
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSMutableCameraPosition *camera = [GMSMutableCameraPosition cameraWithLatitude:kUtility_Location.userlatitude.floatValue
                                                                          longitude:kUtility_Location.userlongitude.floatValue
                                                                               zoom:16];
    if (self.userInfo&&([self.userInfo ojsk:@"lat"].floatValue||[self.userInfo ojsk:@"lng"].floatValue)) {
        camera = [GMSMutableCameraPosition cameraWithLatitude:[self.userInfo ojsk:@"lat"].floatValue
                                                    longitude:[self.userInfo ojsk:@"lng"].floatValue
                                                         zoom:16];
    }
    
    
    _camera=camera;
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight) camera:camera];
    _mapView=mapView;
    mapView.delegate=self;
    mapView.myLocationEnabled = YES;
    //     Creates a marker in the center of the map.
    [self.view addSubview:mapView];
    
    
    WSSizeButton*btnIcon=[RHMethods buttonWithframe:CGRectMake(0, kTopHeight+31, 34, 34) backgroundColor:nil text:@"" font:0 textColor:nil radius:0 superview:self.view];
    btnIcon.frameRX=15;
    //    [btnIcon setImageStr:@"addressi4" SelectImageStr:nil];
    [btnIcon setBackgroundImage:[UIImage imageNamed:@"addressi4"] forState:UIControlStateNormal];
    [btnIcon addViewTarget:self select:@selector(btnClick:)];
    
    [_mapView animateToZoom:16];
//    [_mapView animateToZoom:20];
    UIImageView*imgVDTZ=[RHMethods imageviewWithFrame:CGRectMake(0, 0, 35.5, 46.5) defaultimage:@"dingwei" supView:mapView];
    [imgVDTZ beCenter];
    imgVDTZ.frameY-=46.5*0.5;
    
}
-(void)btnClick:(UIButton*)btn{
    __weak __typeof(self) weakSelf = self;
    [kUtility_Location loadUserLocation:^(id data, int status, NSString *msg) {
        if (status==200) {
            //            CLLocationCoordinate2D xx=CLLocationCoordinate2DMake(kUtility_Location.userlatitude.floatValue, kUtility_Location.userlongitude.floatValue);
            
            GMSMutableCameraPosition *camera = [GMSMutableCameraPosition cameraWithLatitude:kUtility_Location.userlatitude.floatValue longitude:kUtility_Location.userlongitude.floatValue zoom:16];
            weakSelf.camera=camera;
            weakSelf.mapView.camera=camera;
            kUtility_Location.loactionUserData=nil;
              [_mapView animateToZoom:16];
        }
    }];
    
}
//- (nullable UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker{
//
//    GgleMapCellView*view11=[GgleMapCellView viewWithFrame:CGRectMake(0, 0, 0, 0) backgroundcolor:nil superView:nil];
//    [view11 upDataMeWithData:marker.data];
//    [view11 addViewClickBlock:^(UIView *view) {
//        NSLog(@"GgleMapCellViewGgleMapCellViewGgleMapCellViewGgleMapCellView");
//    }];
//    return view11;
//}
- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker{
    
    NSLog(@"GgleMapCellViewGgleMapCellViewGgleMapCellViewGgleMapCellView");
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //    [self loadSearch:textField.text];
    [self.view endEditing:YES];
//    [self loadData];
    return YES;
}
#pragma mark - change
-(void)textFieldTextChange:(UITextField *)textField{
    //    NSLog(@"textField1 - 输入框内容改变,当前内容为: %@",textField.text);
    //    [self loadSearch:textField.text];
    
}
//-(void)updataMap{
//
//    for (GMSMarker *marker in self.markerArray) {
//        marker.map=nil;
//    }
//    self.markerArray=[NSMutableArray new];
//
//    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] init];
//    //    CLLocationCoordinate2D location;
//    for (NSDictionary*dic in [self.data ojk:@"list"]) {
//        GMSMarker *marker = [[GMSMarker alloc] init];
//        marker.position = CLLocationCoordinate2DMake([dic ojsk:@"lat"].floatValue, [dic ojsk:@"lng"].floatValue);
//        marker.data=dic;
//        [self.markerArray addObject:marker];
//        marker.icon=[UIImage imageNamed:@"addressi1"];
//        marker.map = self.mapView;
//
//        bounds = [bounds includingCoordinate:marker.position];
//    }
//
//    //    [_mapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withEdgeInsets:UIEdgeInsetsMake(500,300,500,300)]];
//    [_mapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withEdgeInsets:UIEdgeInsetsMake(100,100,100,100)]];
//    if (_mapView.maxZoom<16) {
//        [_mapView animateToZoom:16];
//    }
//
//    //    [_mapView animateToZoom:16];
//    //    [_mapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:500.0]];
//
//}
//-(void)loadData{
//    __weak __typeof(self) weakSelf = self;
//    krequestParam
//    [dictparam setObject:[NSString stringWithFormat:@"%f",weakSelf.camera.target.longitude] forKey:@"lng"];
//    [dictparam setObject:[NSString stringWithFormat:@"%f",weakSelf.camera.target.latitude] forKey:@"lat"];
//    [dictparam setObject:_txtSearch.text forKey:@"keywords"];
//    [NetEngine createPostAction:@"car/map" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
//        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
//            NSDictionary *dic=[resData getSafeObjWithkey:@"data"];
//            weakSelf.data=dic;
//            //            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"info"]];
//            [weakSelf updataMap];
//        }else{
//            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"info"]];
//
//        }
//    }];
//}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
