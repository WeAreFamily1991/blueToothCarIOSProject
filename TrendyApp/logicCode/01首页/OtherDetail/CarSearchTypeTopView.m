//
//  CarSearchTypeTopView.m
//  TrendyApp
//
//  Created by 55like on 2019/3/22.
//  Copyright © 2019 55like. All rights reserved.
//

#import "CarSearchTypeTopView.h"
#import "ComprehensiveSortPopView.h"
#import "SortByPricePopView.h"
#import "MoreSortItemPopView.h"
#import "NSObject+JSONCategories.h"
#import "BrandListPopView.h"

@interface CarSearchTypeTopView ()
{
    
    
    
}
@property(nonatomic,strong)UIView*viewTop;
@property(nonatomic,strong)UIView*popView;
@property(nonatomic,strong)WSSizeButton *btnDropdown;
@property(nonatomic,strong)NSMutableArray *arraytitle;
@property(nonatomic,strong)AllcallBlock changeBlock;
@end
@implementation CarSearchTypeTopView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frameWidth=kScreenWidth;
        self.frameHeight=45;
        [self loadDATA];
    }
    return self;
}
-(void)addView{
    float width=kScreenWidth/(_arraytitle.count);
    for(int i=0;i<_arraytitle.count;i++){
        WSSizeButton *btnDropdown=[RHMethods buttonWithframe:CGRectMake(i*width, 0, width, self.frameHeight) backgroundColor:nil text:[_arraytitle[i] ojsk:@"name"] font:13 textColor:rgb(51, 51, 51) radius:0 superview:self];
        [btnDropdown setImageStr:@"arrowb2" SelectImageStr:@"arrowt"];
        [btnDropdown setTitleColor:rgbpublicColor forState:UIControlStateSelected];
        btnDropdown.data=_arraytitle[i];
        //            [btnDropdown setAddValue:arrayActionType[i] forKey:@"actionType"];
        [btnDropdown setAddUpdataBlock:^(id data, id weakme) {
            WSSizeButton* btnDropdown=weakme;
            float lbwidth=[btnDropdown.currentTitle widthWithFont:13];
            [btnDropdown setBtnLableFrame:CGRectMake(0, 0, lbwidth, btnDropdown.frameHeight)];
            [btnDropdown setBtnImageViewFrame:CGRectMake(0, 0, 6, 4)];
            [btnDropdown imgbeCY];
            btnDropdown.imgframeRX=(btnDropdown.frameWidth-6-lbwidth-10)*0.5;
            
            btnDropdown.lbframeX=(btnDropdown.frameWidth-6-lbwidth-10)*0.5;
        }];
        [btnDropdown upDataMe];
        [btnDropdown addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    UIView*viewLine=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 1) backgroundcolor:rgb(238, 238, 238) superView:self];
    viewLine.frameBY=0;
}
#pragma mark - request data from the server
-(void)loadDATA{
    krequestParam
    [NetEngine createPostAction:@"car/searchList" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData valueForJSONStrKey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *dicData=[resData objectForJSONKey:@"data"];
            self.arraytitle=[dicData ojk:@"list"];
            [self addView];
        }else{
            [SVProgressHUD  showImage:nil status:[resData valueForJSONKey:@"info"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self loadDATA];
            });
        }
    }onError:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:alertErrorTxt];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loadDATA];
        });
    }];
    
}

-(void)changeValuePopViewBlock:(AllcallBlock)aBlock{
    self.changeBlock = aBlock;
}
-(void)request{
    //本页面筛选
    /*
     {
     "sortList_juli": "sortList_juli_asc",
     "min_price": "",
     "max_price": "",
     "priceList_price": "priceList_price_0_150",
     "brandList_brand": ["brandList_brand_2", "brandList_brand_3", "brandList_brand_4"],
     "moreList_5|1": ["moreList_5|1_6"],
     "moreList_7|0": "moreList_7|0_9",
     "moreList_42|0": "moreList_42|0_44"
     }
     //类型 : sortList 排序 priceList 价格 brandList 品牌 moreList 更多
     */
    NSMutableDictionary *dicSelect=[NSMutableDictionary new];
    if ([self getAddValueForKey:@"sortList"]) {
        [dicSelect addEntriesFromDictionary:[self getAddValueForKey:@"sortList"]];
    }
    if ([self getAddValueForKey:@"priceList"]) {
        [dicSelect addEntriesFromDictionary:[self getAddValueForKey:@"priceList"]];
    }
    if ([self getAddValueForKey:@"brandList"]) {
        [dicSelect addEntriesFromDictionary:[self getAddValueForKey:@"brandList"]];
    }
    if ([self getAddValueForKey:@"moreList"]) {
        [dicSelect addEntriesFromDictionary:[self getAddValueForKey:@"moreList"]];
    }
//    [dictparam setObject:[dicSelect JSONString] forKey:@"searchArr"];
    self.changeBlock?self.changeBlock([dicSelect JSONString], 200, nil):nil;
}
#pragma mark button
-(void)selectBtnClick:(UIButton*)btn{
    __weak typeof(self) weakSelf=self;
    if (self.btnDropdown==btn && !self.popView.hidden) {
        self.btnDropdown.selected=NO;
        self.btnDropdown=nil;
        self.popView.hidden=YES;
        [weakSelf endEditing:YES];
        return;
    }
    self.popView.hidden=YES;
    if (self.btnDropdown) {
        self.btnDropdown.selected=NO;
    }
    self.btnDropdown=btn;
    self.btnDropdown.selected=YES;
    NSDictionary *data=btn.data;
    NSString *actionType=[btn.data ojsk:@"type"];//类型 : sortList 排序 priceList 价格 brandList 品牌 moreList 更多
    UIViewController *viewC=[self supViewController];
    //映射到控制器view的位置
    CGRect tempFrame = [self.superview convertRect:self.frame toView:viewC.view];
    float fy=tempFrame.origin.y+tempFrame.size.height;
    if ([actionType isEqualToString:@"sortList"]) {        
        ComprehensiveSortPopView *view1=[self getAddValueForKey:@"ComprehensiveSortPopView"];
        if (!view1) {
            view1=[ComprehensiveSortPopView new];
            [self setAddValue:view1 forKey:@"ComprehensiveSortPopView"];
        }
        view1.contentViewBG.frameY=fy;
        view1.contentViewBG.frameHeight=kScreenHeight-fy;
        self.popView=view1;
        [view1 showPopViewBlock:^(id data, int status, NSString *msg) {
            weakSelf.btnDropdown.selected=NO;
            if (status==200) {
                [weakSelf setAddValue:data forKey:actionType];
                [weakSelf request];
            }
        }];
    }else if ([actionType isEqualToString:@"priceList"]) {
        SortByPricePopView *view1=[self getAddValueForKey:@"SortByPricePopView"];
        if (!view1) {
            view1=[SortByPricePopView new];
            [self setAddValue:view1 forKey:@"SortByPricePopView"];
        }
        view1.contentViewBG.frameY=fy;
        view1.contentViewBG.frameHeight=kScreenHeight-fy;
        self.popView=view1;
        [view1 showPopViewBlock:^(id data, int status, NSString *msg) {
            weakSelf.btnDropdown.selected=NO;
            [weakSelf endEditing:YES];
            if (status==200) {
                [weakSelf setAddValue:data forKey:actionType];
                [weakSelf request];
            }
        }];
    }else if ([actionType isEqualToString:@"brandList"]) {
        BrandListPopView *view1=[self getAddValueForKey:@"BrandListPopView"];
        if (!view1) {
            view1=[BrandListPopView new];
            [self setAddValue:view1 forKey:@"BrandListPopView"];
        }
        view1.contentViewBG.frameY=fy;
        view1.contentViewBG.frameHeight=kScreenHeight-fy;
        self.popView=view1;
        [view1 showPopViewBlock:^(id data, int status, NSString *msg) {
            weakSelf.btnDropdown.selected=NO;
            if (status==200) {
                [weakSelf setAddValue:data forKey:actionType];
                [weakSelf request];
            }
        }];
    }else if ([actionType isEqualToString:@"moreList"]) {
        MoreSortItemPopView *view1=[self getAddValueForKey:@"MoreSortItemPopView"];
        if (!view1) {
            view1=[MoreSortItemPopView new];
            [self setAddValue:view1 forKey:@"MoreSortItemPopView"];
        }
        view1.contentViewBG.frameY=fy;
        view1.contentViewBG.frameHeight=kScreenHeight-fy;
        self.popView=view1;
        [view1 showPopViewBlock:^(id data, int status, NSString *msg) {
            weakSelf.btnDropdown.selected=NO;
            if (status==200) {
                [weakSelf setAddValue:data forKey:actionType];
                [weakSelf request];
            }
        }];
    }
    if (!_popView.data) {
        [_popView upDataMeWithData:data];
    }
    [self endEditing:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
