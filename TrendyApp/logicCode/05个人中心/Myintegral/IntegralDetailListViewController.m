//
//  IntegralDetailListViewController.m
//  TrendyApp
//
//  Created by 55like on 2019/3/4.
//  Copyright © 2019 55like. All rights reserved.
//

#import "IntegralDetailListViewController.h"
#import "MYRHTableView.h"
#import "IntegralDetailListCellView.h"
#import "SelectTimeView.h"
@interface IntegralDetailListViewController ()
{
    
    
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)WSSizeButton*btnTimeSelect;
@property(nonatomic,copy)NSString*dataStr;
@end

@implementation  IntegralDetailListViewController
#pragma mark  bigen
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    [self request];
}
#pragma mark -   write UI
-(void)addView{
     WSSizeButton*btnTimeSelect=[RHMethods buttonWithframe:CGRectMake(0, kTopHeight, kScreenWidth, 45) backgroundColor:nil text:@"2019年01月" font:15 textColor:rgb(51, 51, 51) radius:0 superview:self.view];
    _btnTimeSelect=btnTimeSelect;
    [btnTimeSelect addViewTarget:self select:@selector(btnTimeClick:)];
    {
        [btnTimeSelect setImageStr:@"arrowb02" SelectImageStr:nil];
        [btnTimeSelect setAddUpdataBlock:^(id data, id weakme) {
            WSSizeButton*btnTimeSelect=weakme;
            [btnTimeSelect setBtnLableFrame:CGRectMake(15, 0, [btnTimeSelect.currentTitle widthWithFont:btnTimeSelect.titleLabel.font.pointSize]+10, btnTimeSelect.frameHeight)];
            [btnTimeSelect setBtnImageViewFrame:CGRectMake(btnTimeSelect.lbframeXW+4, 0, 9, 6)];
            [btnTimeSelect imgbeCY];
        }];
#pragma mark 日期
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy%@MM%@";
        //#warning 真机调试下, 必须加上这段
        fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        NSDate *date=[NSDate dateWithTimeIntervalSinceNow:0];
        NSString*datestr=[fmt stringFromDate:date];
        
        datestr=[NSString stringWithFormat:datestr,kS(@"SignInStr", @"year"),kS(@"SignInStr", @"month")];
        [btnTimeSelect setTitle:datestr forState:UIControlStateNormal];
        fmt.dateFormat = @"yyyy-MM";
        datestr=[fmt stringFromDate:date];
        [btnTimeSelect setAddValue:datestr forKey:@"date"];
        [btnTimeSelect upDataMe];
        
    }
    _mtableView =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, btnTimeSelect.frameYH, kScreenWidth, kScreenHeight-btnTimeSelect.frameYH) style:UITableViewStylePlain];
    _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mtableView];
    [_mtableView.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
        IntegralDetailListCellView*viewcell=[IntegralDetailListCellView viewWithFrame:CGRectMake(0, 0, 0, 0) backgroundcolor:nil superView:reuseView reuseId:@"viewcell"];
        [viewcell bendData:Datadic withType:nil];
        return viewcell;
    }];
}
-(void)btnTimeClick:(UIButton*)btn{
    __weak __typeof(self) weakSelf = self;
    UIButton*currentlb=btn;
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    NSString*formStr=@"yyyy%@MM%@";
    PGDatePickerMode pickerMode=PGDatePickerModeYearAndMonth;
//        formStr=@"yyyy-MM";
//        pickerMode=PGDatePickerModeYearAndMonth;

    [dateFormatter setDateFormat:formStr];
    
    NSString*currentStr=[currentlb currentTitle];
    currentStr=[currentStr stringByReplacingOccurrencesOfString:kS(@"SignInStr", @"year") withString:@"%@"];
    currentStr=[currentStr stringByReplacingOccurrencesOfString:kS(@"SignInStr", @"month") withString:@"%@"];
    NSDate *dateT=[dateFormatter dateFromString:currentStr];
    if (![currentStr notEmptyOrNull]) {
        dateT=[NSDate date];
    }
    SelectTimeView *dateView=[SelectTimeView showWithTime:[NSString stringWithFormat:@"%f",[dateT timeIntervalSince1970]] withCallBack:^(id data, int status, NSString *msg) {
        NSString*timestr= [dateFormatter stringFromDate: [NSDate dateWithTimeIntervalSince1970:[data integerValue]]];
//        currentlb.text=timestr;
        
        timestr=[NSString stringWithFormat:timestr,kS(@"SignInStr", @"year"),kS(@"SignInStr", @"month")];
        
        [currentlb setTitle:timestr forState:UIControlStateNormal];
        
        dateFormatter.dateFormat = @"yyyy-MM";
        timestr= [dateFormatter stringFromDate: [NSDate dateWithTimeIntervalSince1970:[data integerValue]]];
        [currentlb setAddValue:timestr forKey:@"date"];
        [weakSelf request];
        
    }];
    dateView.datePicker.datePickerMode = pickerMode;
    
    
    
}
#pragma mark  request data from the server use tableview
-(void)request{
//    krequestParam
//
//    [dictparam setObject:@"%@" forKey:@"page"];
//    [dictparam setObject:@"12" forKey:@"limit"];
//    _mtableView.urlString=[NSString stringWithFormat:@"schedule/getList%@",dictparam.wgetParamStr];
//    [_mtableView refresh];
      __weak __typeof(self) weakSelf = self;
    [_mtableView showRefresh:YES LoadMore:YES];
    [_mtableView setLoadDataBlock:^(NSMutableDictionary *pageOrPageSizeData, AllcallBlock dataCallBack) {
        [pageOrPageSizeData setObject:weakSelf.otherInfo forKey:@"type"];
        [pageOrPageSizeData setObject:[weakSelf.btnTimeSelect getAddValueForKey:@"date"] forKey:@"date"];
        [kUserCenterService ucenter_getaccountlist:pageOrPageSizeData withBlock:dataCallBack];
    }];
    [_mtableView refresh];
    
    
}
#pragma mark - request data from the server

#pragma mark - event listener function


#pragma mark - delegate function


@end
