//
//  SelectAddressView.m
//  JXGGWWLiKe
//
//  Created by junseek on 15-1-22.
//  Copyright (c) 2015年 五五来客 李江. All rights reserved.
//

#import "SelectAddressView.h"
//#import "AnalysisStringsGdataXml.h"
#import "NSString+expanded.h"


@interface SelectAddressView()<UIPickerViewDataSource,UIPickerViewDelegate,SelectAddressViewDelegate>{
    
    UIView *view_userContact;
    UIPickerView *pickerViewD;
    NSArray *pickerData1;
    NSArray *pickerData2;
    NSArray *pickerData3;
}
@property (nonatomic, strong) UIWindow *overlayWindow;

@property(nonatomic,copy)AllcallBlock myblock;

@end
@implementation SelectAddressView
@synthesize overlayWindow;
@synthesize dicP1,dicP2,dicP3;

-(instancetype)init{
    self=[super init];
    if (self) {
        self.backgroundColor=RGBACOLOR(50, 50, 50, 0.4);
        self.frame=[UIScreen mainScreen].bounds;
        
        UIControl *closeC=[[UIControl alloc]initWithFrame:self.bounds];
        [closeC addTarget:self action:@selector(closeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeC];
        
        view_userContact=[[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-260, kScreenWidth, 260)];
        [view_userContact setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:view_userContact];
        
        UIImageView *im=[RHMethods imageviewWithFrame:CGRectMake(0, 0, kScreenWidth, 44) defaultimage:@""];
        im.backgroundColor=rgbGray;
        [view_userContact addSubview:im];
        [view_userContact addSubview:[RHMethods imageviewWithFrame:CGRectMake(0, YH(im)-0.5, kScreenHeight, 0.5) defaultimage:@"userLine"]];
        UIButton *closeBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn1.frame=CGRectMake(20,  Y(im), 120, 44);
        [closeBtn1 setTitle:@"取消" forState:UIControlStateNormal];
        [closeBtn1 setTitleColor:rgbpublicColor forState:UIControlStateNormal];
        [closeBtn1 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [closeBtn1 addTarget:self action:@selector(closeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [view_userContact addSubview:closeBtn1];
        
        UIButton *OKBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
        OKBtn1.frame=CGRectMake(kScreenWidth-140,  Y(im), 120, 44);
        [OKBtn1 setTitle:@"确定" forState:UIControlStateNormal];
        [OKBtn1 setTitleColor:rgbpublicColor forState:UIControlStateNormal];
        [OKBtn1 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [OKBtn1 addTarget:self action:@selector(OKButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [view_userContact addSubview:OKBtn1];
        
        pickerViewD = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, W(view_userContact), 216)];
        //    指定Delegate
        pickerViewD.delegate=self;
        //    显示选中框
        pickerViewD.showsSelectionIndicator=YES;
        [view_userContact addSubview:pickerViewD];
        
        
        
        
        //        NSInteger row =[pickerView selectedRowInComponent:0];
        //        NSString *selected = [pickerData objectAtIndex:row];
        //        NSString *message = [[NSString alloc] initWithFormat:@"你选择的是:%@",selected];
    }
    return self;
}

-(NSArray *)selectCity:(NSString *)strId{
    NSMutableArray *arrayT=[[NSMutableArray alloc]init];
    for (NSDictionary *dit in self.arrayAddress) {
        if ([strId isEqualToString:[dit valueForJSONStrKey:@"parentid"]]) {
            [arrayT addObject:dit];
        }
    }
    return arrayT;
}
-(void)closeButtonClicked{
    [self hidden];
}

-(void)OKButtonClicked{
    
    if ([self.delegate respondsToSelector:@selector(selectPicker:address1:address2:address3:)]) {
        [self.delegate selectPicker:self address1:dicP1 address2:dicP2 address3:dicP3];
    }
    [self hidden];
}

#pragma mark Picker Date Source Methods
//返回显示的列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
//返回当前列显示的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==0) {
        return [pickerData1 count];
    }else if (component==1){
        
        return [pickerData2 count];
    }else{
        
        return [pickerData3 count];
    }
}

#pragma mark Picker Delegate Methods
//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component==0) {
        return [[pickerData1 objectAtIndex:row] objectForJSONKey:@"name"];
    }else if (component==1){
        return [[pickerData2 objectAtIndex:row] objectForJSONKey:@"name"];
    }else{
        return [[pickerData3 objectAtIndex:row] objectForJSONKey:@"name"];
    }
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    switch (component) {
        case 0:
            pickerData2=[self selectCity:[[pickerData1 objectAtIndex:row] objectForKey:@"areaid"]];
            
            [pickerView reloadComponent:1];
            if ([pickerData2 count]) {
                pickerData3=[self selectCity:[[pickerData2 objectAtIndex:0] objectForKey:@"areaid"]];
            }else{
                pickerData3=@[];
            }
            
            [pickerView reloadComponent:2];
            
            
            
            dicP1=[pickerData1 objectAtIndex:row];
            if ([pickerData2 count]) {
                dicP2=[pickerData2 objectAtIndex:0];
            }else{
                dicP2=nil;
            }
            if ([pickerData3 count]) {
                dicP3=[pickerData3 objectAtIndex:0];
            }else{
                dicP3=nil;
            }
            [pickerView selectRow:0 inComponent:1 animated:YES];
            [pickerView selectRow:0 inComponent:2 animated:YES];
            
            break;
        case 1:
            pickerData3=[self selectCity:[[pickerData2 objectAtIndex:row] objectForKey:@"areaid"]];
            
            [pickerView reloadComponent:2];
            
            
            
            dicP2=[pickerData2 objectAtIndex:row];
            if ([pickerData3 count]) {
                dicP3=[pickerData3 objectAtIndex:0];
            }else{
                dicP3=nil;
            }
            [pickerView selectRow:0 inComponent:2 animated:YES];
            break;
        case 2:
            if ([pickerData3 count]) {
                dicP3=[pickerData3 objectAtIndex:row];
            }else{
                dicP3=nil;
            }
            break;
        default:
            break;
    }
    
    
    
}


- (void)show
{
    if (!pickerData1) {
        
        pickerData1=[self selectCity:@"0"];
        if (!pickerData1 || [pickerData1 count]==0) {
            [SVProgressHUD showImage:nil status:@"数据获取失败！稍后再试"];
            return;
        }
        pickerData2=[self selectCity:[[pickerData1 objectAtIndex:0] objectForKey:@"areaid"]];
        if ([pickerData2 count]) {
            pickerData3=[self selectCity:[[pickerData2 objectAtIndex:0] objectForKey:@"areaid"]];
        }
        
        
        int index_p1=0;
        if (dicP1) {
            //有数据
            for (int i=0;i<[pickerData1 count];i++) {
                NSDictionary *dic = [pickerData1 objectAtIndex:i];
                NSString *strId=[dic objectForKey:@"areaid"];
                if ([strId isEqualToString:[dicP1 objectForKey:@"areaid"]]) {
                    dicP1=dic;
                    [pickerViewD selectRow:i inComponent:0 animated:YES];
                    index_p1=i;
                    break;
                }
                
            }
        }else{
            dicP1=[pickerData1 objectAtIndex:0];
        }
        int index_p2=0;
        if (dicP2) {
            pickerData2=[self selectCity:[[pickerData1 objectAtIndex:index_p1] objectForKey:@"areaid"]];
            [pickerViewD reloadComponent:1];
            //有数据
            for (int i=0;i<[pickerData2 count];i++) {
                NSDictionary *dic = [pickerData2 objectAtIndex:i];
                NSString *strId=[dic objectForKey:@"areaid"];
                if ([strId isEqualToString:[dicP2 objectForKey:@"areaid"]]) {
                    dicP2=dic;
                    [pickerViewD selectRow:i inComponent:1 animated:YES];
                    index_p2=i;
                    break;
                }
                
            }
        }else if([pickerData2 count]){
            dicP2=[pickerData2 objectAtIndex:0];
        }
        
        
        if (pickerData3.count) {
            dicP3=[pickerData3 objectAtIndex:0];
        }
        
        
        [pickerViewD reloadAllComponents];
    }else{
        
        int index_p1=0;
        if (dicP1) {
            //有数据
            for (int i=0;i<[pickerData1 count];i++) {
                NSDictionary *dic = [pickerData1 objectAtIndex:i];
                NSString *strId=[dic objectForKey:@"areaid"];
                if ([strId isEqualToString:[dicP1 objectForKey:@"areaid"]]) {
                    
                    [pickerViewD selectRow:i inComponent:0 animated:YES];
                    index_p1=i;
                    break;
                }
                
            }
        }
        int index_p2=0;
        if (dicP2) {
            pickerData2=[self selectCity:[[pickerData1 objectAtIndex:index_p1] objectForKey:@"areaid"]];
            [pickerViewD reloadComponent:1];
            //有数据
            for (int i=0;i<[pickerData2 count];i++) {
                NSDictionary *dic = [pickerData2 objectAtIndex:i];
                NSString *strId=[dic objectForKey:@"areaid"];
                if ([strId isEqualToString:[dicP2 objectForKey:@"areaid"]]) {
                    
                    [pickerViewD selectRow:i inComponent:1 animated:YES];
                    index_p2=i;
                    break;
                }
                
            }
        }
        if (dicP3) {
            pickerData3=[self selectCity:[[pickerData2 objectAtIndex:index_p2] objectForKey:@"areaid"]];
            [pickerViewD reloadComponent:2];
            //有数据
            for (int i=0;i<[pickerData3 count];i++) {
                NSDictionary *dic = [pickerData3 objectAtIndex:i];
                NSString *strId=[dic objectForKey:@"areaid"];
                if ([strId isEqualToString:[dicP3 objectForKey:@"areaid"]]) {
                    
                    [pickerViewD selectRow:i inComponent:2 animated:YES];
                    
                    break;
                }
                
            }
        }
        
    }
    
    
    
    [self.overlayWindow addSubview:self];
    //    [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];
    [view_userContact setFrame:CGRectMake(X(view_userContact), kScreenHeight, W(view_userContact), H(view_userContact))];
    self.hidden = NO;
    self.alpha = 0.0f;
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.alpha = 1.0f;
                         [view_userContact setFrame:CGRectMake(X(view_userContact), (kScreenHeight-H(view_userContact)), W(view_userContact), H(view_userContact))];
                         
                     }
                     completion:^(BOOL finished) {
                         if (dicP1) {
                             //                                 if ([self.delegate respondsToSelector:@selector(selectPicker:address1:address2:address3:)]) {
                             //                                     [self.delegate selectPicker:self address1:dicP1 address2:dicP2 address3:dicP3];
                             //                                 }
                         }
                     }];
    
}

- (void)hidden
{
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:0
                     animations:^{
                         self.alpha = 0.0;
                         [view_userContact setFrame:CGRectMake(X(view_userContact), kScreenHeight, W(view_userContact), H(view_userContact))];
                     }
                     completion:^(BOOL finished) {
                         if (self.myblock) {
                             [self removeFromSuperview];
                         }
                         
                         [self.overlayWindow removeFromSuperview];
                         self.overlayWindow = nil;
                     }];
    
}
-(void)selectPicker:(SelectAddressView *)selectView address1:(id)addres_a address2:(id)address_b address3:(id)address_c{
    
    NSMutableDictionary*mdic=[NSMutableDictionary new];
    if (addres_a) {
        [mdic setObject:addres_a forKey:@"province"];
    }
    if (address_b) {
        [mdic setObject:address_b forKey:@"city"];
    }
    if (address_c) {
        [mdic setObject:address_c forKey:@"area"];
    }
    
    if (self.myblock) {
        self.myblock(mdic,200,nil);
    }
    //    [dicSelectCate setValue:addres_a forKey:@"provinceid"];// valueForJSONStrKey:@"areaid"]
    //    [dicSelectCate setValue:address_b forKey:@"cityid"];
    //    UITextField *txt=(UITextField *)[scrollView viewWithTag:(1000+btnTemp.tag)];
    //    txt.text=[NSString stringWithFormat:@"%@ %@",[addres_a valueForJSONStrKey:@"name"],[address_b valueForJSONStrKey:@"name"]];
}
+(SelectAddressView*)showWithCurrentAddressDic:(NSString*)currentAddressDic withCallBack:(AllcallBlock)block{
    
    [[self class] loadCityWithBlock:^(id data, int status, NSString *msg) {
        NSDictionary*dic=data;
        
        SelectAddressView* addressView=[[SelectAddressView alloc] init];
        addressView.arrayAddress=[dic objectForJSONKey:@"list"];
        addressView.delegate=addressView;
        [addressView show];
        addressView.myblock=^(id data, int status, NSString *msg) {
            NSString*addressname=@"";
            NSMutableDictionary*datadic=[NSMutableDictionary new];
            
            if ([data objectForKey:@"area"]) {
                addressname=[NSString stringWithFormat:@"%@ %@ %@",data[@"province"][@"name"],data[@"city"][@"name"],data[@"area"][@"name"]];
                
                [datadic setObject:data[@"province"][@"areaid"] forKey:@"provinceid"];
                [datadic setObject:data[@"city"][@"areaid"] forKey:@"cityid"];
                [datadic setObject:data[@"area"][@"areaid"] forKey:@"areaid"];
            }else if([data objectForKey:@"city"]){
                addressname=[NSString stringWithFormat:@"%@ %@",data[@"province"][@"name"],data[@"city"][@"name"]];
                [datadic setObject:data[@"province"][@"areaid"] forKey:@"provinceid"];
                [datadic setObject:data[@"city"][@"areaid"] forKey:@"cityid"];
                [datadic setObject:@"" forKey:@"areaid"];
            }else{
                addressname=[NSString stringWithFormat:@"%@",data[@"province"][@"name"]];
                [datadic setObject:data[@"province"][@"areaid"] forKey:@"provinceid"];
                [datadic setObject:@"" forKey:@"cityid"];
                [datadic setObject:@"" forKey:@"areaid"];
            }
            [datadic setObject:addressname forKey:@"addressname"];
            
            //            "province": "310000",
            //            "city": "310100",
            //            "county": "310115",
            if (block) {
                block(datadic,status,msg);
            }
            
        };
    }];
    
    
    return nil;
}


+(void)showMyDemo{
    
    UIView*s_view=UTILITY.currentViewController.view;
    float yAdd=kTopHeight;
    s_view.backgroundColor=rgbGray;
    UILabel*lbtime=[RHMethods RlableRX:10 Y:yAdd+10 W:kScreenWidth-20 Height:40 font:15 superview:s_view withColor:nil text:@"地址选择"];
    lbtime.backgroundColor=[UIColor whiteColor];
    [lbtime addViewClickBlock:^(UIView *view) {
        
        UILabel*currentlb=(UILabel*)view;
        NSDictionary*dic=[UTILITY getAddValueForKey:@"citylistdata"];
        if (dic==nil) {
            
            dic= [SelectAddressView JsonObjectWithPath:@"citylistdata.txt"];
            if (dic) {
                [UTILITY setAddValue:dic forKey:@"citylistdata"];
            }
        }
        [UTILITY setAddValue:dic forKey:@"citylistdata"];
        
        SelectAddressView* addressView=[[SelectAddressView alloc] init];
        addressView.arrayAddress=[dic objectForJSONKey:@"list"];
        addressView.delegate=addressView;
        [addressView show];
        addressView.myblock=^(id data, int status, NSString *msg) {
            
            if ([data objectForKey:@"area"]) {
                currentlb.text=[NSString stringWithFormat:@"%@ %@ %@",data[@"province"][@"name"],data[@"city"][@"name"],data[@"area"][@"name"]];
            }else{
                currentlb.text=[NSString stringWithFormat:@"%@ %@",data[@"province"][@"name"],data[@"city"][@"name"]];
            }
            
        };
        
        
    }];
    
}


#pragma mark - Getters
- (UIWindow *)overlayWindow {
    if(!overlayWindow) {
        overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        overlayWindow.backgroundColor = [UIColor clearColor];
        overlayWindow.userInteractionEnabled = YES;
        overlayWindow.windowLevel = UIWindowLevelStatusBar-1;
    }
    overlayWindow.hidden=NO;
    return overlayWindow;
}

+(void)loadCityWithBlock:(AllcallBlock)block{
    NSDictionary*citydic=[UTILITY getAddValueForKey:@"citydic"];
    if (citydic) {
        block(citydic,200,nil);
        return;
    }
    
    
    krequestParam
    
    [NetEngine createPostAction:@"userapi/getarea" withParams:dictparam onCompletion:^(id resData, BOOL isCache) {
        if ([[resData getSafeObjWithkey:@"status"] isEqualToString:@"200"]) {
            NSDictionary *citydic=[resData getSafeObjWithkey:@"data"];
            
            [UTILITY setAddValue:citydic forKey:@"citydic"];
            block(citydic,200,nil);
            //            [SVProgressHUD showSuccessWithStatus:[resData valueForJSONKey:@"msg"]];
            //            [self addView];
            
        }else{
            [SVProgressHUD showErrorWithStatus:[resData valueForJSONKey:@"msg"]];
            
        }
    }];
    
    
    
    
}


+ (id )JsonObjectWithPath:(NSString *)path {
    if (path == nil) {
        return nil;
    }
    NSString *pathr=[[NSBundle mainBundle] pathForResource:path ofType:nil];
    
    NSString *jsonString=[[NSString alloc] initWithContentsOfFile:pathr encoding:NSUTF8StringEncoding error:nil];
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
