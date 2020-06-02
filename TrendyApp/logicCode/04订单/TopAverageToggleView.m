//
//  TopAverageToggleView.m
//  MeiJiaoSuo55like
//
//  Created by 55like on 2018/11/16.
//  Copyright © 2018 55like. All rights reserved.
//

#import "TopAverageToggleView.h"

@implementation TopAverageToggleView
-(void)initOrReframeView{
    if (self.frameWidth==0) {
        self.frameWidth=kScreenWidth;
    }
    if (self.frameHeight==0) {
//        self.frameHeight=44;
    }
    if (self.isfirstInit) {
        
        self.btnGroup=[WSButtonGroup new];
    UIView*viewLine=[UIView viewWithFrame:CGRectMake(0, 0, 30, 2) backgroundcolor:rgb(25, 84, 140) superView:self];
        viewLine.frameBY=0;
        
        __weak typeof(self)weakSelf=self;
        [self setAddUpdataBlock:^(id data, id weakme) {
            for (UIView*subCellView in weakSelf.subviews) {
                if (subCellView.tag==1001) {
                    [(UIButton*)subCellView setSelected:NO];
                    subCellView.hidden=YES;
                }
            }
            
            NSMutableArray*marray=data;
            id delegate=weakSelf.btnGroup.delegate;
            weakSelf.btnGroup=[WSButtonGroup new];
            weakSelf.btnGroup.delegate=delegate;
            weakSelf.viewline=viewLine;
            [weakSelf.btnGroup setGroupChangeBlock:^(WSButtonGroup *group) {
                [UIView animateWithDuration:0.2 animations:^{
                    viewLine.centerX=group.currentSelectBtn.centerX;
                }];
            }];
            
            if (!marray.count) {
                return ;
            }
            float cellWith=self.frameWidth/marray.count;
            for (int i=0; i<marray.count; i++) {
                NSMutableDictionary*mdic=marray[i];
                NSString*titleStr;
                if([mdic isKindOfClass:[NSDictionary class]]){
                titleStr=[mdic ojsk:@"title"];
                }else{
                    titleStr=(id)mdic;
                }
                
                WSSizeButton*btnCell=[weakSelf getAddValueForKey:[NSString stringWithFormat:@"btnCell%d",i]];
                if (btnCell==nil) {
                     btnCell=[RHMethods buttonWithframe:CGRectMake(0, 0, 50, weakSelf.frameHeight) backgroundColor:nil text:titleStr font:16 textColor:rgb(153,153,153) radius:0 superview:self reuseId:[NSString stringWithFormat:@"btnCell%d",i]];
                    btnCell.tag=1001;
                    [btnCell setTitleColor:rgb(51,51,51) forState:UIControlStateSelected];
                }
                btnCell.hidden=NO;
                btnCell.frameX=i*cellWith;
                btnCell.frameWidth=cellWith;
                [btnCell setTitle:titleStr forState:UIControlStateNormal];
                btnCell.data=mdic;
                [weakSelf.btnGroup addButton:btnCell];
            }
            
            
        }];
        
    }
    
    
    
    
}

-(void)bendData:(id)data withType:(NSString *)type{
    [super bendData:data withType:type];
    self.data=data;
    [self upDataMe];
}
@end
