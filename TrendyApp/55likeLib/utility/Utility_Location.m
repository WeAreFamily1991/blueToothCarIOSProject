//
//  Utility_Location.m
//  ZhiChuXing55like
//
//  Created by 55like on 2018/6/13.
//  Copyright © 2018年 55like. All rights reserved.
//

#import "Utility_Location.h"
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
//#import <GoogleMaps/GoogleMaps.h>

#define SaveSelectUserCityData @"SaveSelectUserCityData"
#define SaveSelectUserCityTake @"SaveSelectUserCityTake"
#define SaveSelectUserCityReturn @"SaveSelectUserCityReturn"
@interface Utility_Location ()<CLLocationManagerDelegate>{
    NSURLSessionDataTask *op;
    
    
}
@property(nonatomic,strong)CLLocationManager *locManager;
@property (nonatomic, strong) AllcallBlock loactionUserDefaut;

@end
@implementation Utility_Location

static Utility_Location *_utility=nil;
static dispatch_once_t utility_Location;

- (void)setUserCityData:(NSDictionary *)userCityData{
    if (_userCityData!=userCityData) {
        _userCityData=userCityData;
        [Utility saveToDefaults:_userCityData forKey:SaveSelectUserCityData];
    }
}

+(instancetype)shareInstence{
    dispatch_once(&utility_Location, ^ {
        _utility = [[Utility_Location alloc] init];
        
//        NSString*applanguagestr=[[NSUserDefaults standardUserDefaults]objectForKey:@"appLanguagedata"];
//        _utility.languageServiceDataDic=[applanguagestr objectFromJSONString ];
    });
    return _utility;
}
/**
 更新默认数据
 */
-(void)readUserLocationFromDefault{
    [self readUserLocationFromDefault:nil];
}
-(void)readUserLocationFromDefault:(AllcallBlock)isSuccess{
    self.loactionUserDefaut=isSuccess;
    self.userCityData=[Utility defaultsForKey:SaveSelectUserCityData];
    self.userCityReturn=[Utility defaultsForKey:SaveSelectUserCityReturn];
    self.userCityTake=[Utility defaultsForKey:SaveSelectUserCityTake];
    if (!self.userCityTake) {
        //没有默认数据时-获取后台设置默认城市
        [self requestwelcome_nowCity];
//    }else{
//        self.loactionUserDefaut?self.loactionUserDefaut(nil, 200, nil):nil;
    }
    
}

-(void)removeCityInfo{
    
    [Utility removeForKey:SaveSelectUserCityData];
    [Utility removeForKey:SaveSelectUserCityReturn];
    [Utility removeForKey:SaveSelectUserCityTake];

    _utility = [[Utility_Location alloc] init];
    //    _userCityTake = nil;
//    _userCityTake = nil;
//    _userCityTake = nil;
//    self.userCityTake = nil;
//    self.userCityData = nil;
//    self.userCityReturn = nil;
}
////定位
-(void)loadUserLocation:(AllcallBlock)isSuccess{
    self.loactionUserData = isSuccess;
    
    //初始化位置管理器
    self.locManager = [[CLLocationManager alloc]init];
    //设置代理
    self.locManager.delegate = self;
    if (kVersion8) {
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
            [self.locManager requestWhenInUseAuthorization];
        }
        [self.locManager requestAlwaysAuthorization];
    }
    //设置位置经度
    self.locManager.desiredAccuracy = kCLLocationAccuracyBest;
    //设置每隔-米更新位置
    self.locManager.distanceFilter = 100;
    //开始定位服务
    [self.locManager startUpdatingLocation];
    
    if (![self determineWhetherTheAPPOpensTheLocation]) {
        //        DLog(@"定位服务当前可能尚未打开，请设置打开！");
        __weak typeof(self) weakSelf=self;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"定位服务当前可能尚未打开，请在设置中打开！" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"前往打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            self.loactionUserData?self.loactionUserData(nil,0,@""):nil;
//            [weakSelf loadsearchServerCity:@"" blockNil:NO];
        }]];
        [UTILITY.currentViewController presentViewController:alertController animated:YES completion:nil];
        
    }
    //    self.userlatitude=@"31.165367";
    //    self.userlongitude=@"121.407257";
}

-(BOOL)determineWhetherTheAPPOpensTheLocation{
    if ([CLLocationManager locationServicesEnabled] &&
        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse ||
         [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined ||
         [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)) {
            return YES;
        }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
            return NO;
        }else{
            return NO;
        }
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *newLocation = locations[0];
    //结构体，存储位置坐标
    CLLocationCoordinate2D loc = [newLocation coordinate];
    float longitude = loc.longitude;
    float latitude = loc.latitude;
    DLog(@"longitude:%f,latitude:%f",longitude,latitude);
    self.userlatitude=[NSString stringWithFormat:@"%f",latitude];
    self.userlongitude=[NSString stringWithFormat:@"%f",longitude];
    self.loactionUserData?self.loactionUserData(nil,200,@""):nil;
    // 保存 Device 的现语言 (英语 法语 ，，，)
    NSMutableArray *userDefaultLanguages = [[NSUserDefaults standardUserDefaults]
                                            objectForKey:@"AppleLanguages"];
    
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
    
    
//    CLPlacemark * placemark;
//
//    NSString * identifier = [NSLocale localeIdentifierFromComponents:[NSDictionary dictionaryWithObject:placemark.ISOcountryCode forKey:NSLocaleCountryCode]];
//    NSLocale * usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
//    NSString * country = [usLocale displayNameForKey:NSLocaleIdentifier value:identifier];

    ///-------------谷歌
    [[GMSGeocoder geocoder] reverseGeocodeCoordinate:loc completionHandler:^(GMSReverseGeocodeResponse * _Nullable resp, NSError * _Nullable error) {
        GMSAddress *addres=resp.firstResult;
        if (addres) {
            if (addres.lines.count) {
                self.userAddress=addres.lines[0];
            }else{
                self.userAddress=[NSString stringWithFormat:@"%@%@%@",addres.locality,addres.subLocality,addres.thoroughfare];
            }
        }else{
            self.userAddress=@"";
        }
                    if ([self getAddValueForKey:@"homepageLocationUpdata"]==nil) {
        
                        [kUtility_Location dispatchEventWithActionType:@"homepageLocationUpdata" actionData:nil];
                        [self setAddValue:@"1" forKey:@"homepageLocationUpdata"];
                    }
        
        DLog(@"%@",addres.administrativeArea);
        // 还原Device 的语言
        [[NSUserDefaults standardUserDefaults] setObject:userDefaultLanguages forKey:@"AppleLanguages"];
    }];
    
    ///-------------系统
    //创建地理编码对象
    
//    CLGeocoder *geocoder1=[CLGeocoder new];
 
//
//    [[GMSGeocoder geocoder] reverseGeocodeCoordinate:loc completionHandler:^(GMSReverseGeocodeResponse * _Nullable obj, NSError * _Nullable error) {
//        [SVProgressHUD dismiss];
//        if (error) {
//        }else{
//
//
//            GMSAddress *placemark = obj.firstResult;//第一个位置是最精确的
//
//
//              self.userAddress=[NSString stringWithFormat:@"%@%@%@",placemark.administrativeArea,placemark.subLocality,placemark.thoroughfare];
//
//            if ([self getAddValueForKey:@"homepageLocationUpdata"]==nil) {
//
//                [kUtility_Location dispatchEventWithActionType:@"homepageLocationUpdata" actionData:nil];
//                [self setAddValue:@"1" forKey:@"homepageLocationUpdata"];
//            }
//
//        }
//        //         还原Device 的语言
//        [[NSUserDefaults standardUserDefaults] setObject:userDefaultLanguages forKey:@"AppleLanguages"];
//    }];
//
    
    
//    CLGeocoder *geocoder=[CLGeocoder new];
//      __weak __typeof(geocoder) weakgeocoder = geocoder;
//    //反地理编码
//    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
////        NSMutableArray *userDefaultLanguages = [[NSUserDefaults standardUserDefaults]
////                                                objectForKey:@"AppleLanguages"];
////        NSLog(@"%@",userDefaultLanguages);
//        //判断是否有错误或者placemarks是否为空
//        if (error !=nil || placemarks.count==0) {
//            NSLog(@"%@",error);
//             self.userAddress=@"";
//        }else{
//            for (CLPlacemark *placemark in placemarks) {
//                //详细地址
//                NSString *addressStr = placemark.name;
//
//                NSLog(@"详细地址1：%@",addressStr);
//                NSLog(@"详细地址2：%@",placemark.addressDictionary);
//                NSLog(@"详细地址3：%@",placemark.locality);
//            }
//            CLPlacemark *placemark=[placemarks objectAtIndex:0];
//            NSDictionary *addressDictionary=placemark.addressDictionary;
//            self.userAddress=[NSString stringWithFormat:@"%@%@%@",[addressDictionary ojsk:@"City"],[addressDictionary ojsk:@"SubLocality"],[addressDictionary ojsk:@"Name"]];
//        }
//
//        if ([self getAddValueForKey:@"homepageLocationUpdata"]==nil) {
//
//            [kUtility_Location dispatchEventWithActionType:@"homepageLocationUpdata" actionData:nil];
//            [self setAddValue:@"1" forKey:@"homepageLocationUpdata"];
//        }
//
//
//        // 还原Device 的语言
//        [[NSUserDefaults standardUserDefaults] setObject:userDefaultLanguages forKey:@"AppleLanguages"];
//
//
//    }];
}

//当位置获取或更新失败会调用的方法
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSString *errorMsg = nil;
    if ([error code] == kCLErrorDenied) {
        errorMsg = @"访问被拒绝";
    }
    if ([error code] == kCLErrorLocationUnknown) {
        errorMsg = @"获取位置信息失败";
    }
//    [self loadsearchServerCity:@"" blockNil:NO];
    self.loactionUserData?self.loactionUserData(nil,0,errorMsg):nil;
    
    //    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Location"
    //                                                       message:errorMsg delegate:self cancelButtonTitle:@"Ok"otherButtonTitles:nil, nil];
    //    [alertView show];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    switch (status) {
            
        case kCLAuthorizationStatusNotDetermined:
            
            if ([self.locManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                
                [self.locManager requestWhenInUseAuthorization];
                
            }
            
            break;
            
        default:
            
            break;
            
    }
    
    
}
-(void)loadsearchServerCity:(NSString *)city blockNil:(BOOL)abool{
//    self.userCity=city;
//    //    MKFapp_search_city
////    if ([city length]>1) {
////        city = [city substringWithRange:NSMakeRange(0, [city length] - 1)];
////    }
//    krequestParam
//    [dictparam setValue:city forKey:@"area_name"];
//    [dictparam setValue:@"location" forKey:@"type"];
//    if (op) {
//        [op cancel];
//    }
//    op=[NetEngine createGetAction_LJ:[NSString stringWithFormat:@"car/getcity%@",dictparam.wgetParamStr] onCompletion:^(id resData, BOOL isCache) {
//        if ([[resData valueForJSONStrKey:@"status"] isEqualToString:@"200"]) {
//            NSDictionary *dicT=[resData objectForJSONKey:@"data"];
//            if (!self.userCityData) {
//                self.userCityData=[dicT objectForKey:@"location"];
//            }
//            self.userCityData_Default=[dicT objectForKey:@"location"];
//
//            [self.locManager stopUpdatingLocation];
//            self.loactionUserData?self.loactionUserData(nil,200,@""):nil;
//            if (abool) {
//                self.loactionUserData = nil;
//            }
//            DLog(@"_userCityData:%@",self.userCityData);
//        }else{
//            [SVProgressHUD showImage:nil status:[resData valueForJSONStrKey:@"msg"]];
//        }
//    }];
    
}
#pragma mark - 二手车专用

- (void)setUserCityTake:(NSDictionary *)userCityTake{
    if (_userCityTake!=userCityTake) {
        if ([_userCityTake isEqualToDictionary:userCityTake]) {
            return;
        }
        _userCityTake=userCityTake;
        [Utility saveToDefaults:_userCityTake forKey:SaveSelectUserCityTake];
        [self dispatchEventWithActionType:@"SaveSelectUserCityUpdate" actionData:nil];
        self.loactionUserDefaut?self.loactionUserDefaut(nil, 200, nil):nil;
    }
}
- (void)setUserCityReturn:(NSDictionary *)userCityReturn{
    if (_userCityReturn!=userCityReturn) {
        if ([_userCityReturn isEqualToDictionary:userCityReturn]) {
            return;
        }
        _userCityReturn=userCityReturn;
        [Utility saveToDefaults:_userCityReturn forKey:SaveSelectUserCityReturn];
        [self dispatchEventWithActionType:@"SaveSelectUserReturnCityUpdate" actionData:nil];
    }
}
-(void)requestwelcome_nowCity{
//    krequestParam
    [NetEngine createGetAction_LJ_two:[NSString stringWithFormat:@"welcome/nowCity%@",@""] onCompletion:^(id resData, BOOL isCache) {
        if ([[resData valueForJSONStrKey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dicData=[resData objectForJSONKey:@"data"];
            self.userCityReturn=[dicData ojk:@"cityReturn"];
            self.userCityTake=[dicData ojk:@"cityTake"];
        }else{
            [SVProgressHUD  showImage:nil status:[resData valueForJSONKey:@"info"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self requestwelcome_nowCity];
            });
        }
    } onError:^(NSError *error) {
        [SVProgressHUD  showImage:nil status:alertErrorTxt];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self requestwelcome_nowCity];
        });
    }];
}
@end
