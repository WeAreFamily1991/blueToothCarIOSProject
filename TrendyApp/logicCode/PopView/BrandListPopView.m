//
//  BrandListPopView.m
//  TrendyApp
//
//  Created by 55like on 2019/3/19.
//  Copyright © 2019 55like. All rights reserved.
//

#import "BrandListPopView.h"
#import "MYRHTableView.h"
@interface BrandListPopView()
{
    
}
@property(nonatomic,strong)MYRHTableView *mtableViewLeft;
@property(nonatomic,strong)MYRHTableView *mtableViewRight;
@property(nonatomic,strong)AllcallBlock selectBlock;
@property(nonatomic,strong)UIView *viewHeader;

@property(nonatomic,assign)NSInteger selectIndex;
@property (nonatomic, strong) UIWindow *overlayWindow;
@end
@implementation BrandListPopView
@synthesize overlayWindow;
- (instancetype)init
{
    self = [super init];
    if (self) {        
        self.frame=[UIScreen mainScreen].bounds;
        self.backgroundColor=[UIColor clearColor];
        UIControl *closeC=[[UIControl alloc]initWithFrame:self.bounds];
        [closeC addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeC];
        _contentViewBG=[UIView viewWithFrame:CGRectMake(0, 100, kScreenWidth, kScreenHeight-100) backgroundcolor:nil superView:self];
        [self addView];
    }
    return self;
}
- (void)addView{
        float fw=kScreenWidth*(270.0/750);
        __weak typeof(self) weakSelf=self;
        _mtableViewLeft =[[MYRHTableView alloc]initWithFrame:CGRectMake(0, 0, fw, H(_contentViewBG)-60-kIphoneXBottom) style:UITableViewStylePlain];
        _mtableViewLeft.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mtableViewLeft.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    _mtableViewLeft.backgroundColor=rgbwhiteColor;
        [_contentViewBG addSubview:_mtableViewLeft];
        [_mtableViewLeft.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
            UIView *viewcell=[UIView viewWithFrame:CGRectMake(0, 0, W(weakSelf.mtableViewLeft),45) backgroundcolor:nil superView:reuseView reuseId:@"viewcell"];
            UILabel *lblTitle=[RHMethods labelWithFrame:CGRectMake(10, 10, W(viewcell)-20, 25) font:fontTitle color:rgbTitleColor text:@"" textAlignment:NSTextAlignmentLeft supView:viewcell reuseId:@"lblTitle"];
            [UIView viewWithFrame:CGRectMake(10, H(viewcell)-0.5,  W(viewcell)-10, 0.5) backgroundcolor:rgbLineColor superView:viewcell  reuseId:@"viewline"];
            UIImageView *imageSelect=[RHMethods imageviewWithFrame:CGRectMake(W(viewcell)-20, 0, 11, H(viewcell)) defaultimage:@"complete1" supView:viewcell reuseId:@"imageSelect"];
            imageSelect.contentMode=UIViewContentModeScaleAspectFit;
            
            lblTitle.text=[Datadic ojsk:@"name"];
            if ([[Datadic ojsk:@"isClicked"] isEqualToString:@"1"]) {
                imageSelect.hidden=NO;
                lblTitle.frameWidth=W(viewcell)-35;
                lblTitle.textColor=rgbpublicColor;
            }else{
                imageSelect.hidden=YES;
                lblTitle.frameWidth=W(viewcell)-20;
                lblTitle.textColor=rgbTitleColor;
            }
            if (weakSelf.selectIndex==row) {
                viewcell.backgroundColor=RGBACOLOR(14,112,161,0.11);
            }else{
                viewcell.backgroundColor=rgbwhiteColor;
            }
            return viewcell;
        }];
        [_mtableViewLeft.defaultSection setSectionIndexClickBlock:^(id Datadic, NSInteger row) {
            weakSelf.selectIndex=row;
            weakSelf.mtableViewRight.defaultSection.dataArray=[weakSelf.mtableViewLeft.defaultSection.dataArray[row] ojk:@"son"];
            [weakSelf.mtableViewLeft reloadData];
            [weakSelf.mtableViewRight reloadData];
            [weakSelf.viewHeader upDataMe];
        }];
        
        
        UIView *viewLine=[RHMethods viewWithFrame:CGRectMake(fw, 0, 10, H(_mtableViewLeft)) backgroundcolor:rgbwhiteColor superView:_contentViewBG];
    viewLine.autoresizingMask=UIViewAutoresizingFlexibleHeight;
        CALayer *layer = [viewLine layer];
        layer.shadowOffset = CGSizeMake(-2, 0); //(0,0)时是四周都有阴影
        layer.shadowColor = [UIColor blackColor].CGColor;
        layer.shadowOpacity = 0.2;
        layer.shadowRadius = 2;//阴影半径，默认3
        _mtableViewRight =[[MYRHTableView alloc]initWithFrame:CGRectMake(fw, 0, W(self)-fw, H(_mtableViewLeft)) style:UITableViewStylePlain];
        _mtableViewRight.backgroundColor=rgbwhiteColor;
        _mtableViewRight.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mtableViewRight.autoresizingMask=UIViewAutoresizingFlexibleHeight;
        [_contentViewBG addSubview:_mtableViewRight];
        
        {
            UIView *viewHeader=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 45) backgroundcolor:rgbwhiteColor superView:nil];
            _mtableViewRight.tableHeaderView=viewHeader;
            _viewHeader=viewHeader;
            
            UILabel *lblTitle=[RHMethods labelWithFrame:CGRectMake(10, 10, W(viewHeader)-20, 25) font:fontTitle color:rgbTitleColor text:kS(@"carFilter", @"allCarBrand") textAlignment:NSTextAlignmentLeft supView:viewHeader reuseId:@"lblTitle"];
            [UIView viewWithFrame:CGRectMake(10, H(viewHeader)-0.5,  W(viewHeader)-10, 0.5) backgroundcolor:rgbLineColor superView:viewHeader reuseId:@"viewline"];
            UIImageView *imageSelect=[RHMethods imageviewWithFrame:CGRectMake(W(viewHeader)-20, 0, 11, H(viewHeader)) defaultimage:@"complete1" supView:viewHeader reuseId:@"imageSelect"];
            imageSelect.contentMode=UIViewContentModeScaleAspectFit;
           
            [viewHeader setAddUpdataBlock:^(id data, id weakme) {
                bool abool=YES;
                if(weakSelf.mtableViewRight.defaultSection.dataArray.count){
                    for (id dateT in weakSelf.mtableViewRight.defaultSection.dataArray) {
                        if (![[dateT ojsk:@"isClicked"] isEqualToString:@"1"]) {
                            abool=NO;
                            break;
                        }
                    }
                }else{
                    abool=[[weakSelf.mtableViewLeft.defaultSection.dataArray[weakSelf.selectIndex]  ojsk:@"isAllClicked"] isEqualToString:@"1"];
                }
                if (abool) {
                    [weakSelf.mtableViewLeft.defaultSection.dataArray[weakSelf.selectIndex]  setValue:@"1" forKey:@"isAllClicked"];
                    imageSelect.hidden=NO;
                    lblTitle.frameWidth=W(viewHeader)-35;
                    lblTitle.textColor=rgbpublicColor;
                }else{
                    [weakSelf.mtableViewLeft.defaultSection.dataArray[weakSelf.selectIndex]  setValue:@"0" forKey:@"isAllClicked"];
                    imageSelect.hidden=YES;
                    lblTitle.frameWidth=W(viewHeader)-20;
                    lblTitle.textColor=rgbTitleColor;
                }
            }];
            [viewHeader addViewClickBlock:^(UIView *view) {
                if (imageSelect.hidden) {
                    //没有选中
                    [weakSelf.mtableViewLeft.defaultSection.dataArray[weakSelf.selectIndex]  setValue:@"1" forKey:@"isAllClicked"];
                    for (id dateT in weakSelf.mtableViewRight.defaultSection.dataArray) {
                        //标记选中
                        [dateT setValue:@"1" forKey:@"isClicked"];
                    }
                }else{
                    [weakSelf.mtableViewLeft.defaultSection.dataArray[weakSelf.selectIndex]  setValue:@"0" forKey:@"isAllClicked"];
                    for (id dateT in weakSelf.mtableViewRight.defaultSection.dataArray) {
                        //标记
                        [dateT removeObjectForKey:@"isClicked"];
                    }
                }
                [weakSelf.mtableViewLeft.defaultSection.dataArray[weakSelf.selectIndex] removeObjectForKey:@"isClicked"];
                if(weakSelf.mtableViewRight.defaultSection.dataArray.count){
                    for (id dateT in weakSelf.mtableViewRight.defaultSection.dataArray) {
                        if ([[dateT ojsk:@"isClicked"] isEqualToString:@"1"]) {
                            [weakSelf.mtableViewLeft.defaultSection.dataArray[weakSelf.selectIndex]  setValue:@"1" forKey:@"isClicked"];
                            break;
                        }
                    }
                }else{
                    if (imageSelect.hidden) {
                        [weakSelf.mtableViewLeft.defaultSection.dataArray[weakSelf.selectIndex]  setValue:@"1" forKey:@"isClicked"];
                    }
                }
                
                [weakSelf.mtableViewLeft reloadData];
                [weakSelf.mtableViewRight reloadData];
                [weakSelf.viewHeader upDataMe];
            }];
        }
        [_mtableViewRight.defaultSection setSectionreUseViewBlock:^UIView *(UIView *reuseView, id Datadic, NSInteger row) {
            UIView *viewcell=[UIView viewWithFrame:CGRectMake(0, 0, W(weakSelf.mtableViewRight),45) backgroundcolor:nil superView:reuseView reuseId:@"viewcellR"];
            UILabel *lblTitle=[RHMethods labelWithFrame:CGRectMake(10, 10, W(viewcell)-20, 25) font:fontTitle color:rgbTitleColor text:@"" textAlignment:NSTextAlignmentLeft supView:viewcell reuseId:@"lblTitle"];
            [UIView viewWithFrame:CGRectMake(10, H(viewcell)-0.5,  W(viewcell)-10, 0.5) backgroundcolor:rgbLineColor superView:viewcell  reuseId:@"viewline"];
            UIImageView *imageSelect=[RHMethods imageviewWithFrame:CGRectMake(W(viewcell)-20, 0, 11, H(viewcell)) defaultimage:@"complete1" supView:viewcell reuseId:@"imageSelect"];
            imageSelect.contentMode=UIViewContentModeScaleAspectFit;
            lblTitle.text=[Datadic ojsk:@"name"];
            if ([[Datadic ojsk:@"isClicked"] isEqualToString:@"1"]) {
                imageSelect.hidden=NO;
                lblTitle.frameWidth=W(viewcell)-35;
                lblTitle.textColor=rgbpublicColor;
            }else{
                imageSelect.hidden=YES;
                lblTitle.frameWidth=W(viewcell)-20;
                lblTitle.textColor=rgbTitleColor;
            }
            return viewcell;
        }];
        [_mtableViewRight.defaultSection setSectionIndexClickBlock:^(id Datadic, NSInteger row) {
            if ([[Datadic ojsk:@"isClicked"] isEqualToString:@"1"]) {
                [Datadic removeObjectForKey:@"isClicked"];
                [weakSelf.mtableViewLeft.defaultSection.dataArray[weakSelf.selectIndex] removeObjectForKey:@"isClicked"];
                for (id dateT in weakSelf.mtableViewRight.defaultSection.dataArray) {
                    if ([[dateT ojsk:@"isClicked"] isEqualToString:@"1"]) {
                        [weakSelf.mtableViewLeft.defaultSection.dataArray[weakSelf.selectIndex]  setValue:@"1" forKey:@"isClicked"];
                        break;
                    }
                }
            }else{
                [Datadic setValue:@"1" forKey:@"isClicked"];
                [weakSelf.mtableViewLeft.defaultSection.dataArray[weakSelf.selectIndex]  setValue:@"1" forKey:@"isClicked"];
            }
            
            [weakSelf.mtableViewLeft reloadData];
            [weakSelf.mtableViewRight reloadData];
            [weakSelf.viewHeader upDataMe];
        }];
        
        [self setAddUpdataBlock:^(id data, id weakme) {
            weakSelf.mtableViewLeft.defaultSection.dataArray=[data ojk:@"list"];
            if ([[data ojk:@"list"] count]>0) {
                weakSelf.selectIndex=0;
                weakSelf.mtableViewRight.defaultSection.dataArray=[weakSelf.mtableViewLeft.defaultSection.dataArray[0] ojk:@"son"];
            }
            [weakSelf.mtableViewLeft reloadData];
            [weakSelf.mtableViewRight reloadData];
            [weakSelf.viewHeader upDataMe];
        }];
        
        
        
        {
            UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, YH(_mtableViewLeft), kScreenWidth, 60+kIphoneXBottom) backgroundcolor:rgbwhiteColor superView:_contentViewBG];
            viewContent.autoresizingMask=UIViewAutoresizingFlexibleTopMargin;
            [viewContent addLineLayerWhitframe:CGRectMake(0, 0, kScreenWidth, 0.5) whitColor:rgbLineColor];
            NSArray*arrayBtntitle=@[kS(@"generalPage", @"clear"),kS(@"generalPage", @"OK")];//@[@"清空",@"確認",];
            for (int i=0; i<arrayBtntitle.count; i++) {
                WSSizeButton*btnItem=[RHMethods buttonWithframe:CGRectMake(15, 10, (kScreenWidth-45)*0.5, 40) backgroundColor:rgb(244,244,244) text:arrayBtntitle[i] font:16 textColor:rgb(51, 51, 51) radius:3 superview:viewContent];
                if (i==1) {
                    btnItem.frameRX=15;
                    [btnItem setBackgroundColor:rgb(13, 112, 161)];
                    [btnItem setTitleColor:rgb(255, 255, 255) forState:UIControlStateNormal];
                    
                    [btnItem addViewClickBlock:^(UIView *view) {
                        NSMutableArray *arrayTemp=[NSMutableArray new];
                        for (id dataLeft in weakSelf.mtableViewLeft.defaultSection.dataArray) {
                            if ([[dataLeft ojsk:@"isAllClicked"] isEqualToString:@"1"]) {
                                [arrayTemp addObject:[NSString stringWithFormat:@"brandList_brand_%@",[dataLeft ojsk:@"id"]]];
                            }else{
                                for (id dataRight  in [dataLeft ojk:@"son"]) {
                                    if ([[dataRight ojsk:@"isClicked"] isEqualToString:@"1"]) {
                                        [arrayTemp addObject:[NSString stringWithFormat:@"brandList_brand_%@",[dataRight ojsk:@"id"]]];
                                    }
                                }
                            }
                            
                        }
                        weakSelf.selectBlock?weakSelf.selectBlock(@{@"brandList_brand":arrayTemp},200,nil):nil;
                        [weakSelf hidden];
                    }];
                }else{
                    [btnItem addViewClickBlock:^(UIView *view) {
                        [weakSelf endEditing:YES];
                        //清空
                        for (id dataLeft in weakSelf.mtableViewLeft.defaultSection.dataArray) {
                            [dataLeft removeObjectForKey:@"isClicked"];
                            [dataLeft removeObjectForKey:@"isAllClicked"];
                            for (id dataRight  in [dataLeft ojk:@"son"]) {
                                [dataRight removeObjectForKey:@"isClicked"];
                            }
                        }
                        if ([weakSelf.mtableViewLeft.defaultSection.dataArray count]>0) {
                            weakSelf.selectIndex=0;
                            weakSelf.mtableViewRight.defaultSection.dataArray=[weakSelf.mtableViewLeft.defaultSection.dataArray[0] ojk:@"son"];
                        }
                        [weakSelf.mtableViewLeft reloadData];
                        [weakSelf.mtableViewRight reloadData];
                        [weakSelf.viewHeader upDataMe];
                    }];
                }
            }
            
        }
   
}
-(void)showPopViewBlock:(AllcallBlock)aBlock{
    self.hidden=NO;
    self.alpha =1;
    self.selectBlock = aBlock;
    [self.overlayWindow addSubview:self];
}
- (void)hidden
{
    __weak typeof(self) weakSelf=self;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        
        weakSelf.selectBlock?weakSelf.selectBlock(nil,0,nil):nil;
        [self.overlayWindow removeFromSuperview];
        self.overlayWindow = nil;
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
