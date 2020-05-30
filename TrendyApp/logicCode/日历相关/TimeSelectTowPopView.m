//
//  TimeSelectPopView.m
//  TrendyApp
//
//  Created by 55like on 2019/3/8.
//  Copyright © 2019 55like. All rights reserved.
//

#import "TimeSelectTowPopView.h"
#import "WSButtonGroup.h"
@interface TimeSelectTowPopView()
{
    
}
@property(nonatomic,strong)WSButtonGroup*btnGroup;
@end

@implementation TimeSelectTowPopView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
        self.frameHeight=kScreenHeight;
    }
    if (self.isfirstInit) {
        self.backgroundColor=RGBACOLOR(0, 0, 0, 0.3);
        
        __weak __typeof(self) weakSelf = self;
        [self addViewClickBlock:^(UIView *view) {
            weakSelf.hidden=YES;
        }];
        
        UIView*viewContent=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 100) backgroundcolor:rgbwhiteColor superView:self];
        [viewContent addViewClickBlock:^(UIView *view) {
            
        }];
        {
            UIView*viewTop=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 44) backgroundcolor:rgb(245, 245, 245) superView:viewContent];
            {
                WSSizeButton*btnCancel=[RHMethods buttonWithframe:CGRectMake(0, 0, 60, 44) backgroundColor:nil text:@"取消" font:16 textColor:rgb(153, 153, 153) radius:0 superview:viewTop ];
                
                WSSizeButton*btnOK=[RHMethods buttonWithframe:CGRectMake(0, 0, 60, 44) backgroundColor:nil text:@"確定" font:16 textColor:rgb(14,112,161) radius:0 superview:viewTop ];
                
                btnOK.frameRX=0;
                UILabel*lbTitle=[RHMethods ClableY:0 W:0 Height:viewTop.frameHeight font:17 superview:viewTop withColor:rgb(51, 51, 51) text:@"請選擇具體時間"];
                
            }
            UIView*viewBtnGroup=[UIView viewWithFrame:CGRectMake(0, viewTop.frameYH, kScreenWidth, 50) backgroundcolor:rgbwhiteColor superView:viewContent];
            {
                UIView*viewLine1=[UIView viewWithFrame:CGRectMake(0, 0, kScreenWidth, 1) backgroundcolor:rgb(238, 238, 238) superView:viewBtnGroup]; 
                viewLine1.frameBY=0;
                
                UIView*viewLine=[UIView viewWithFrame:CGRectMake(0, 0, 125, 2) backgroundcolor:rgb(13,107,154) superView:viewBtnGroup];
                viewLine.frameBY=0;
                _btnGroup=[WSButtonGroup new];
                [_btnGroup setGroupClickBlock:^(WSButtonGroup *group) {
                    viewLine.centerX=group.currentSelectBtn.centerX;
                }];
                NSArray*arraytitle=@[@"上午 (00:00-11:00)",@"下午 (12:00-23:00)",];
                for (int i=0; i<arraytitle.count; i++) {
                    WSSizeButton*btnSelect=[RHMethods buttonWithframe:CGRectMake(0+i*kScreenWidth*0.5, 0, viewBtnGroup.frameWidth*0.5, 50) backgroundColor:nil text:arraytitle[i] font:14 textColor:rgb(153, 153, 153) radius:0 superview:viewBtnGroup];
                    [btnSelect setTitleColor:rgb(14,112,161) forState:UIControlStateSelected];
                    [_btnGroup addButton:btnSelect];
                }
                
            }
            
            {
                float btnWidth=(kScreenWidth-16*2-10*3)/4;
                for (int i=0; i<6; i++) {
                    for (int j=0; j<4; j++) {
                        WSSizeButton*btnOther=[RHMethods buttonWithframe:CGRectMake(16+j*(btnWidth+10), 10+viewBtnGroup.frameYH+i*48, btnWidth, 40) backgroundColor:nil text:@"11:00" font:15 textColor:rgb(51, 51, 51) radius:5 superview:viewContent];
                        btnOther.layer.borderColor=rgb(238, 238, 238).CGColor;
                        btnOther.layer.borderWidth=1;
                        [btnOther setBackGroundImageviewColor:rgbwhiteColor forState:UIControlStateNormal];
                        [btnOther setBackGroundImageviewColor:rgb(13,107,154) forState:UIControlStateSelected];
                        [btnOther setTitleColor:rgbwhiteColor forState:UIControlStateSelected];
                        [btnOther addViewClickBlock:^(UIView *view) {
                            WSSizeButton*btnOther=(id)view;
                            btnOther.selected=!btnOther.selected;
                            btnOther.layer.borderWidth=btnOther.selected?0:1;
                        }];
                        
                        if (i==5&&j==3) {
                            viewContent.frameHeight=btnOther.frameYH+20;
                        }
                    }
                }
            }
            
            
            viewContent.frameBY=0;
        }
        
        [_btnGroup btnClickAtIndex:0];
    }
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
