//
//  Utility_Location.h
//  ZhiChuXing55like
//
//  Created by 55like on 2018/6/13.
//  Copyright © 2018年 55like. All rights reserved.
//基于系统地图定位

#import <Foundation/Foundation.h>

#define kUtility_Location [Utility_Location shareInstence]
@interface Utility_Location : MYBaseService



@property (nonatomic, strong) AllcallBlock loactionUserData;

@property (nonatomic, strong) NSString *userlongitude;
@property (nonatomic, strong) NSString *userlatitude;
@property (nonatomic, strong) NSString *userAddress;
//定位的
@property (nonatomic, strong) NSString *userCity;
///当前选择的
@property (nonatomic, strong) NSDictionary *userCityData;
///默认定位的
@property (nonatomic, strong) NSDictionary *userCityData_Default;

/**
 更新默认数据
 */
-(void)readUserLocationFromDefault;
-(void)readUserLocationFromDefault:(AllcallBlock)isSuccess;
-(void)removeCityInfo;

////定位
-(void)loadUserLocation:(AllcallBlock)isSuccess;



#pragma mark - 二手车专用
///当前选择的默认取车城市
@property (nonatomic, strong) NSDictionary *userCityTake;
///当前选择的默认还车城市
@property (nonatomic, strong) NSDictionary *userCityReturn;

@end
