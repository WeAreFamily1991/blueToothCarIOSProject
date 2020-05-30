//
//  VehicleDetailsCarDeployViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/20.
//  Copyright © 2019 55like. All rights reserved.
//

#import "VehicleDetailsCarDeployViewController.h"

@interface VehicleDetailsCarDeployViewController ()
@property(nonatomic,strong)NSMutableDictionary *dicAll;

@end

@implementation VehicleDetailsCarDeployViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDATA];
}
-(void)addView{
    UIScrollView *scrollBG=[UIScrollView viewWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kContentHeight) backgroundcolor:rgbwhiteColor superView:self.view];
    scrollBG.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    NSArray*arraytitle=[_dicAll ojk:@"list"];
    //            float fx=0;
    float fw=kScreenWidth/3;
    //            float fy=45;
    for(int i=0;i<arraytitle.count;i++){
        NSDictionary*currentdic=arraytitle[i];
        WSSizeButton*btnItem=[RHMethods buttonWithframe:CGRectMake(0, 20+ 64*(i/3), fw, 64) backgroundColor:nil text:[currentdic ojsk:@"title"] font:13 textColor:rgb(51, 51, 51) radius:0 superview:scrollBG];
        [btnItem imageWithURL:[currentdic ojsk:@"path"]];
        //                [btnItem setImageStr:@"datai4" SelectImageStr:@"datai5"];
        [btnItem setTitleColor:RGBACOLOR(51, 51, 51, 0.3) forState:UIControlStateNormal];
        [btnItem setBtnImageViewFrame:CGRectMake(0, 13, 27, 27)];
        btnItem.imageView.contentMode=UIViewContentModeScaleAspectFit;
        [btnItem imgbeCX];
        [btnItem setBtnLableFrame:CGRectMake(0, btnItem.imgframeYH+5-3, btnItem.frameWidth, 12+6)];
        
        btnItem.titleLabel.textAlignment=NSTextAlignmentCenter;
        if (i%3==2) {
            btnItem.frameRX=0;
        }else if(i%3==1){
            [btnItem beCX];
        }
        if (i==arraytitle.count-1) {
            scrollBG.contentHeight=btnItem.frameYH+10;
        }
    }
}
#pragma mark - request data from the server
-(void)loadDATA{
    krequestParam
    [dictparam setValue:self.userInfo forKey:@"id"];
    [NetEngine createPostAction:@"car/carDeploy" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData valueForJSONStrKey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dicData=[resData objectForJSONKey:@"data"];
            self.dicAll=dicData;
            [self addView];
        }else{
            [SVProgressHUD  showImage:nil status:[resData valueForJSONKey:@"info"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self backButtonClicked:nil];
            });
        }
    } onError:^(NSError *error) {
        [SVProgressHUD showImage:nil status:alertErrorTxt];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self backButtonClicked:nil];
        });
    }];
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
