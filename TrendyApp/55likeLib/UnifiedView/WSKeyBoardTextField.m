



//
//  WSKeyBoardTextField.m
//  XinKaiFa55like
//
//  Created by 55like on 29/09/2017.
//  Copyright © 2017 55like lj. All rights reserved.
//

#import "WSKeyBoardTextField.h"
#import "MessageInterceptor.h"

@interface WSKeyBoardTextFielddelegate : NSObject

@property (nonatomic, strong) MessageInterceptor *delegateInterceptor;
@end
@implementation WSKeyBoardTextFielddelegate
#pragma mark - textfielddelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (_delegateInterceptor.receiver !=nil && [_delegateInterceptor.receiver respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return   [_delegateInterceptor.receiver textFieldShouldReturn:textField];
    }
    [textField endEditing:YES];
    return YES;
}


@end


@interface WSKeyBoardTextField()<UITextFieldDelegate>
{
}
@property(nonatomic,strong)WSKeyBoardTextFielddelegate *wsDelegate;
@end

@implementation WSKeyBoardTextField

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.delegate=nil;
    }
    return self;
    
}

- (void)setDelegate:(id<UITableViewDelegate>)delegate
{
    if (_wsDelegate==nil) {
        _wsDelegate=[WSKeyBoardTextFielddelegate new];
        _wsDelegate.delegateInterceptor = [[MessageInterceptor alloc] init];
        _wsDelegate.delegateInterceptor.middleMan = _wsDelegate;
        _wsDelegate.delegateInterceptor.receiver = delegate;
        
        super.delegate = (id)_wsDelegate.delegateInterceptor;
    }
    _wsDelegate.delegateInterceptor.receiver=delegate;
}




/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end


