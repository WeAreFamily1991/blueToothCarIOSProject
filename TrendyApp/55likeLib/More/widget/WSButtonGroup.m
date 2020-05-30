//
//  WSButtonGroup.m
//  jinYingWu
//
//  Created by 55like on 11/08/2017.
//  Copyright © 2017 55like lj. All rights reserved.
//

#import "WSButtonGroup.h"
@interface WSButtonGroup()
@property(nonatomic,copy)WSButtonGroupBlock myClickblock;
@property(nonatomic,copy)WSButtonGroupBlock myChangeblock;
@end
@implementation WSButtonGroup

- (instancetype)init
{
    self = [super init];
    if (self) {
        _currentindex=0;
    }
    return self;
}
-(void)addButton:(UIButton*)button{
    if (_buttonArray==nil) {
        _buttonArray=[NSMutableArray new];
        
        
    }
    if ([_buttonArray containsObject:button]) {
        [_buttonArray removeObject:button];
    }
    [_buttonArray addObject:button];
    
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    
}
-(void)btnClick:(UIButton*)btn{
    NSInteger index=[_buttonArray indexOfObject:btn];
    _currentindex=index;
    for (UIButton*btnx in _buttonArray) {
        btnx.selected=NO;
    }
    btn.selected=YES;
    
    if (self.currentSelectBtn==btn) {
        
    }else{
        self.currentSelectBtn=btn;
        if (self.myChangeblock) {
            self.myChangeblock(self);
        }
        if ([self.delegate respondsToSelector:@selector(WSButtonGroupChange:)]) {
            [self.delegate WSButtonGroupChange:self];
            
        }
    }
    if (self.myClickblock) {
        self.myClickblock(self);
    }
    if ([self.delegate respondsToSelector:@selector(WSButtonGroupClick:)]) {
        [self.delegate WSButtonGroupClick:self];
    }
    
    
    
    
    
}
-(void)setGroupClickBlock:(WSButtonGroupBlock)clickBlock{
    self.myClickblock=clickBlock;
}
-(void)setGroupChangeBlock:(WSButtonGroupBlock)ChangeBlock{
    self.myChangeblock=ChangeBlock;
}
-(void)btnClickAtIndex:(int)index{
    if (index>=_buttonArray.count) {
        return;
    }
    UIButton*btn=_buttonArray[index];
    [self btnClick:btn];
}
@end
