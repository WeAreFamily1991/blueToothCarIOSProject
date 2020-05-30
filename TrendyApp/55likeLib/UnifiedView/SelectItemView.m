
//
//  SelectItemView.m
//  tuomin
//
//  Created by 55like on 2017/11/13.
//  Copyright © 2017年 55like. All rights reserved.
//

#import "SelectItemView.h"
@interface SelectItemView()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    
    UIView *view_userContact;
    UIPickerView *pickerViewD;
}
@property (nonatomic, strong) UIWindow *overlayWindow;
@property(nonatomic,strong)NSMutableDictionary*currentSelectDataDic;
@property(nonatomic,assign)int componentNumber;

@property(nonatomic,copy)AllcallBlock myblock;
@end

@implementation SelectItemView
@synthesize overlayWindow;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=RGBACOLOR(50, 50, 50, 0.4);
        self.frame=[UIScreen mainScreen].bounds;
        
        UIControl *closeC=[[UIControl alloc]initWithFrame:self.bounds];
        [closeC addTarget:self action:@selector(closeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeC];
        
        view_userContact=[[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-260, kScreenWidth, 260)];
        [view_userContact setBackgroundColor:rgbwhiteColor];
        [self addSubview:view_userContact];
        
        UIImageView *im=[RHMethods imageviewWithFrame:CGRectMake(0, 0, kScreenWidth, 44) defaultimage:@""];
        im.backgroundColor=rgbwhiteColor;
        [view_userContact addSubview:im];
//        [view_userContact addSubview:[RHMethods imageviewWithFrame:CGRectMake(0, YH(im)-0.5, kScreenHeight, 0.5) defaultimage:@"userLine"]];
        UIButton *closeBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn1.frame=CGRectMake(20,  Y(im), 120, 44);
        [closeBtn1 setTitle:kS(@"generalPage", @"cancel") forState:UIControlStateNormal];
        [closeBtn1 setTitleColor:rgbBlue forState:UIControlStateNormal];
        [closeBtn1 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [closeBtn1 addTarget:self action:@selector(closeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [view_userContact addSubview:closeBtn1];
        
        UIButton *OKBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
        OKBtn1.frame=CGRectMake(kScreenWidth-140,  Y(im), 120, 44);
        [OKBtn1 setTitle:kS(@"generalPage", @"OK") forState:UIControlStateNormal];
        [OKBtn1 setTitleColor:rgbBlue forState:UIControlStateNormal];
        [OKBtn1 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [OKBtn1 addTarget:self action:@selector(OKButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [view_userContact addSubview:OKBtn1];
        
        pickerViewD = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, W(view_userContact), 216)];
        //    指定Delegate
        pickerViewD.delegate=self;
        //    显示选中框
        pickerViewD.showsSelectionIndicator=YES;
        [view_userContact addSubview:pickerViewD];
        _currentSelectDataDic=[NSMutableDictionary new];
        
        _datePicker=pickerViewD;
        
        
    }
    return self;
}
-(void)setDataDic:(NSDictionary *)dataDic{
    
    if (_dataDic==dataDic) {
        return;
    }
    NSDictionary*dic=dataDic;


    for (int i=0; i<5; i++) {
        dic=[[dic objectForJSONKey:@"list"] firstObject];
        if (dic) {
            [_currentSelectDataDic setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }else{
            break;
        }
    }
    
    _dataDic=dataDic;
    NSInteger number=[self numberOfComponentsInPickerView:_datePicker];
    for (int i=0; i<number; i++) {
        [self.datePicker selectRow:0 inComponent:i animated:NO];
    }
    
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    NSString*componentNumber=[self.dataDic objectForJSONKey:@"component"];
    if (componentNumber) {
        self.componentNumber= componentNumber.intValue;
        return self.componentNumber;
    }
    
    
    NSArray*array=[self.dataDic objectForJSONKey:@"list"];
    if (array) {
        int componetNumber=1;
        for (int i=0; i<4; i++) {
            NSDictionary*firstDic=array.firstObject;
            if ([firstDic isKindOfClass:[NSDictionary class]]) {
                array=[firstDic objectForKey:@"list"];
                if (array.count) {
                    componetNumber++;
                }else{
                     self.componentNumber= componetNumber;
                    return self.componentNumber;
                }
            }else{
                 self.componentNumber= componetNumber;
                return self.componentNumber;
            }
        }
    }
    
     self.componentNumber= 1;
    return self.componentNumber;
    
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
   
    NSArray*currentArray;
    
    if (component==0) {
        currentArray=[self.dataDic objectForJSONKey:@"list"];
    }else{
        currentArray=[[self.currentSelectDataDic objectForJSONKey:[NSString stringWithFormat:@"%ld",(long)component-1]] objectForJSONKey:@"list"];
    }
    if(currentArray){
        return [currentArray count];
    }
    return 0;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSArray*currentArray;
    
    if (component==0) {
        currentArray=[self.dataDic objectForJSONKey:@"list"];
    }else{
        currentArray=[[self.currentSelectDataDic objectForJSONKey:[NSString stringWithFormat:@"%ld",(long)component-1]] objectForJSONKey:@"list"];
    }
    
    return [currentArray[row] objectForJSONKey:@"title"];
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:18]];
        pickerLabel.textColor=rgbTitleColor;
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSArray*currentArray;
    
    if (component==0) {
        currentArray=[self.dataDic objectForJSONKey:@"list"];
    }else{
        currentArray=[[self.currentSelectDataDic objectForJSONKey:[NSString stringWithFormat:@"%ld",(long)component-1]] objectForJSONKey:@"list"];
    }
    
    NSDictionary *currrentDic;
    if (row<currentArray.count) {
        currrentDic=currentArray[row];
    }
    if (currrentDic) {
        
        [self.currentSelectDataDic setObject:currrentDic forKey:[NSString stringWithFormat:@"%ld",(long)component]];
    }else{
        [self.currentSelectDataDic removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)component]];
    }
    
    
    if (component<self.componentNumber-1) {
        [pickerView reloadComponent:component+1];

        [pickerView selectRow:0 inComponent:component+1 animated:YES];
        [self pickerView:pickerView didSelectRow:0 inComponent:component+1];
    }
//    for (NSInteger i=component; i<self.componentNumber; i++) {
//        NSDictionary*currrentDic;
//        if (i==component) {
//           currrentDic=currentArray[row];
//        }else{
//            currrentDic=currentArray[0];
//        }
//
//        if (currrentDic) {
//
//            [self.currentSelectDataDic setObject:currrentDic forKey:[NSString stringWithFormat:@"%ld",(long)component]];
//        }else{
////            break;
//        }
//
//        currentArray=[currrentDic objectForJSONKey:@"list"];
//        if (i<self.componentNumber-1) {
//                    [pickerView selectRow:0 inComponent:i+1 animated:NO];
//            [pickerView reloadComponent:component+1];
//        }
//
//    }
    
    
}
-(void)closeButtonClicked{
    [self hidden];
}

-(void)OKButtonClicked{
    
    NSInteger number=[self numberOfComponentsInPickerView:_datePicker];
    NSMutableArray*marray=[NSMutableArray new];
    for (int i=0; i<number; i++) {
        NSDictionary*currentdic=[_currentSelectDataDic objectForJSONKey:[NSString stringWithFormat:@"%d",i]];
        if (currentdic) {
            [marray addObject:currentdic];
        }
    }
    if (self.myblock) {
        self.myblock(marray, 200, nil);
    }
    
//    if ([self.delegate respondsToSelector:@selector(selectPicker:address1:address2:address3:)]) {
//        [self.delegate selectPicker:self address1:dicP1 address2:dicP2 address3:dicP3];
//    }
    [self hidden];
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
                         
                         [overlayWindow removeFromSuperview];
                         overlayWindow = nil;
                     }];
    
}
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

- (void)show{
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
                       
                     }];
}

+(SelectItemView*)showWithDataDic:(NSDictionary*)datadic WithBlock:(AllcallBlock)block{
    return [self showWithDataDic:datadic addforKey:@"SelectItemView" WithBlock:block];
}
+(SelectItemView*)showWithDataDic:(NSDictionary*)datadic addforKey:(NSString *)akey WithBlock:(AllcallBlock)block {
    
    SelectItemView*view=[UTILITY.currentViewController getAddValueForKey:akey];
    if (view==nil) {
        
        view=[[SelectItemView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [UTILITY.currentViewController setAddValue:view forKey:akey];
    }
    view.myblock = block;
    view.dataDic=datadic;
    [view show];
    return view;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
