//
//  ComprehensiveSortPopView.m
//  TrendyApp
//
//  Created by 55like on 2019/3/6.
//  Copyright © 2019 55like. All rights reserved.
//

#import "MoreSortItemPopView.h"

#import "MYRHTableView.h"
@interface MoreSortItemPopView()
{
    
}
@property(nonatomic,strong)MYRHTableView*mtableView;
@property(nonatomic,strong)AllcallBlock selectBlock;
@property (nonatomic, strong) UIWindow *overlayWindow;
@end
@implementation MoreSortItemPopView
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
        _contentViewBG=[UIView viewWithFrame:CGRectMake(0, 100, kScreenWidth, kScreenHeight-100) backgroundcolor:RGBACOLOR(0, 0, 0, 0.3) superView:self];
        [self addView];
    }
    return self;
}
- (void)addView{
    
    
        _mtableView =[[MYRHTableView alloc]initWithFrame:_contentViewBG.bounds style:UITableViewStylePlain];
        _mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mtableView.frameHeight=_mtableView.frameHeight-13;
    _mtableView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
        [_contentViewBG addSubview:_mtableView];
        __weak __typeof(self) weakSelf = self;
        [self addViewClickBlock:^(UIView *view) {
            [weakSelf hidden];
        }];
        
        [self setAddUpdataBlock:^(id data, id weakme) {
            [weakSelf.mtableView.defaultSection.noReUseViewArray removeAllObjects];
            NSArray *arraytitle=[data ojk:@"list"];
            for (int i=0; i<arraytitle.count; i++) {
                id titleData=arraytitle[i];
                UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 10) backgroundcolor:rgbwhiteColor superView:nil];
                [viewContent addViewClickBlock:^(UIView *view) {
                }];
                [weakSelf.mtableView.defaultSection.noReUseViewArray addObject:viewContent];
                UILabel*lbMe=[RHMethods lableX:15 Y:20 W:kScreenWidth-30 Height:14 font:14 superview:viewContent withColor:rgb(51, 51, 51) text:[titleData ojsk:@"name"]];
                viewContent.data=titleData;
                NSMutableArray *selectArray=[NSMutableArray new];
                [viewContent setAddValue:selectArray forKey:@"selectArray"];
//                float width=(viewContent.frameWidth-15*2-11*3)/4;
                NSArray *arraybtntitle=[titleData ojk:@"son"];
                
                float fx=15;
                float fy=lbMe.frameYH+15;
                for (int j=0; j<arraybtntitle.count; j++) {
                    id tData=arraybtntitle[j];
                    WSSizeButton*btnItem=[RHMethods buttonWithframe:CGRectMake(fx,fy, 40, 30) backgroundColor:nil text:@"" font:12 textColor:rgb(102, 102, 102) radius:2 superview:viewContent];
                    [btnItem setBackGroundImageviewColor:RGBACOLOR(153, 153, 153,0.11) forState:UIControlStateNormal];
                    [btnItem setBackGroundImageviewColor:RGBACOLOR(14,112,161,0.11) forState:UIControlStateSelected];
                    [btnItem setTitleColor:rgbpublicColor forState:UIControlStateSelected];
                    [btnItem setTitle:[tData ojsk:@"name"] forState:UIControlStateNormal];
                    btnItem.data=tData;
                    float width=[btnItem.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, 30)].width+20;
                    if (width>kScreenWidth-30) {
                        width=kScreenWidth-30;
                    }
                    btnItem.frameWidth=width;
                    if (XW(btnItem)>kScreenWidth-15) {
                        fx=15;
                        fy+=H(btnItem)+10;
                        btnItem.frameX=fx;
                        btnItem.frameY=fy;
                    }
                    fx+=W(btnItem)+10;
                    if (j==arraybtntitle.count-1) {
                        viewContent.frameHeight=btnItem.frameYH;
                    }
                    [btnItem addViewClickBlock:^(UIView *view) {
                        UIView *supV=[view superview];
                        NSMutableArray *selectArray=[supV getAddValueForKey:@"selectArray"];
                        
                        WSSizeButton *btnItem=(WSSizeButton *)view;
                        if ([[supV.data ojsk:@"ismulti"] isEqualToString:@"1"]) {//1 多选 单选(品牌)
                            //多选
                            if ([selectArray containsObject:btnItem.data]) {
                                [selectArray removeObject:btnItem.data];
                                btnItem.selected=NO;
                            }else{
                                [selectArray addObject:btnItem.data];
                                btnItem.selected=YES;
                            }
                        }else{
                            //单选
                            for (UIView *vT in [supV subviews]) {
                                if ([vT isKindOfClass:[WSSizeButton class]]) {
                                    WSSizeButton *btnt=(WSSizeButton *)vT;
                                    btnt.selected=NO;
                                }
                            }
                            [selectArray removeAllObjects];
                            [selectArray addObject:btnItem.data];
                            btnItem.selected=YES;
                        }
                        
                        [viewContent setAddValue:selectArray forKey:@"selectArray"];
                    }];
                }
            }
            [weakSelf.mtableView reloadData];
        }];
       
        
        {
            UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 70) backgroundcolor:rgbwhiteColor superView:nil];
            _mtableView.defaultSection.selctionFooterView=viewContent;
            NSArray*arrayBtntitle=@[kS(@"generalPage", @"clear"),kS(@"generalPage", @"OK")];//@[@"清空",@"確認",];
            for (int i=0; i<arrayBtntitle.count; i++) {
                WSSizeButton*btnItem=[RHMethods buttonWithframe:CGRectMake(15, 15, (kScreenWidth-45)*0.5, 40) backgroundColor:rgb(244,244,244) text:arrayBtntitle[i] font:16 textColor:rgb(51, 51, 51) radius:3 superview:viewContent];
                if (i==1) {
                    btnItem.frameRX=15;
                    [btnItem setBackgroundColor:rgb(13, 112, 161)];
                    [btnItem setTitleColor:rgb(255, 255, 255) forState:UIControlStateNormal];
                    viewContent.frameHeight=btnItem.frameYH+15;
                    
                    [btnItem addViewClickBlock:^(UIView *view) {
                        NSMutableDictionary *dicTemp=[NSMutableDictionary new];
                        for (UIView *viewC in weakSelf.mtableView.defaultSection.noReUseViewArray) {
                            NSMutableArray *selectArray=[viewC getAddValueForKey:@"selectArray"];
                           
                            NSString *strKey=[NSString stringWithFormat:@"%@_%@",[weakSelf.data ojsk:@"type"],[viewC.data ojsk:@"obj"]];
                            if ([[viewC.data ojsk:@"ismulti"] isEqualToString:@"1"]) {//1 多选 单选(品牌)
                                if (selectArray.count>0) {
                                    NSMutableArray *arrayT=[NSMutableArray new];
                                    for (id sData in selectArray) {
                                        NSString *strValue=[NSString stringWithFormat:@"%@_%@",strKey,[sData ojsk:@"id"]];
                                        [arrayT addObject:strValue];
                                    }
                                    [dicTemp setValue:arrayT forKey:strKey];
                                }
                            }else{
                                for (id sData in selectArray) {
                                    NSString *strValue=[NSString stringWithFormat:@"%@_%@",strKey,[sData ojsk:@"id"]];
                                    [dicTemp setValue:strValue forKey:strKey];
                                }
                            }
                        }
                        weakSelf.selectBlock?weakSelf.selectBlock(dicTemp,200,nil):nil;
                        [weakSelf hidden];
                    }];
                }else{
                    [btnItem addViewClickBlock:^(UIView *view) {
                        [weakSelf endEditing:YES];
                        //清空
                        for (UIView *viewC in weakSelf.mtableView.defaultSection.noReUseViewArray) {
                            NSMutableArray *selectArray=[viewC getAddValueForKey:@"selectArray"];
                            [selectArray removeAllObjects];
                            [viewC setAddValue:selectArray forKey:@"selectArray"];
                            for (UIView *vT in [viewC subviews]) {
                                if ([vT isKindOfClass:[WSSizeButton class]]) {
                                    WSSizeButton *btnt=(WSSizeButton *)vT;
                                    btnt.selected=NO;
                                }
                            }
                        }
                    }];
                }
            }
            
        }
        
    
    
}
-(void)showPopViewBlock:(AllcallBlock)aBlock{
    self.hidden=NO;
    self.alpha=1;
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
