//
//  NetRequsetDemo.m
//  55likeLibDemo
//
//  Created by 55like on 22/09/2017.
//  Copyright © 2017 55like lj. All rights reserved.
//

#import "NetRequsetDemo.h"

@implementation NetRequsetDemo
+(void)showMyDemo{
    
    UIView*s_view=UTILITY.currentViewController.view;
    float yAdd=kTopHeight;
    {
        WSSizeButton*btn1=[RHMethods buttonWithframe:CGRectMake(10, yAdd+10, kScreenWidth-20, 40) backgroundColor:rgbBlue text:@"请求" font:15 textColor:[UIColor whiteColor] radius:4 superview:s_view];
        
        [btn1 addViewClickBlock:^(UIView *view) {
            krequestParam
            
//            user/getversion User/address
            [NetEngine createHttpAction:@"user/getversion" withCache:NO withParams:dictparam withMask:SVProgressHUDMaskTypeNone onCompletion:^(id resData, BOOL isCache) {
                if ([[resData valueForJSONStrKey:@"status"]isEqualToString:@"200"]) {
                    
                }else{
                    
                }
            } onError:^(NSError *error) {
                
            }];
        }];
        yAdd=btn1.frameYH+10;
    }
    

    

}
@end
