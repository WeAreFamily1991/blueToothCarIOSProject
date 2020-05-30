//
//  PLTextView.m
//
//
//  Created by 55like on 15/10/29.
//
//
//#import "UIView+Extension.h"
#import "PLTextView.h"
#import "MessageInterceptor.h"


@interface PLTextViewdelegate : NSObject

@property (nonatomic, assign) BOOL retunHiddenKey;
@property (nonatomic, strong) MessageInterceptor *delegateInterceptor;
@end
@implementation PLTextViewdelegate

#pragma mark - UITextView Delegate Methods
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if (_delegateInterceptor !=nil && [_delegateInterceptor.receiver respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        return   [_delegateInterceptor.receiver textView:textView shouldChangeTextInRange:range replacementText:text];
    }
    if (self.retunHiddenKey && [text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


@end



@interface PLTextView()

@property(nonatomic,strong)PLTextViewdelegate *wsDelegate;
@property (nonatomic,weak) UILabel *placeholderLabel; //这里先拿出这个label以方便我们后面的使用
@end
@implementation PLTextView


-(void)setRetunHiddenKey:(BOOL)retunHiddenKey{
    if (_retunHiddenKey!=retunHiddenKey) {
        _retunHiddenKey=retunHiddenKey;
        _wsDelegate.retunHiddenKey=retunHiddenKey;
        if (retunHiddenKey) {
            self.returnKeyType=UIReturnKeyDone;
        }else{
            self.returnKeyType=UIReturnKeyNext;
        }
    }
}

- (void)setDelegate:(id<UITableViewDelegate>)delegate
{
    if (_wsDelegate==nil) {
        _wsDelegate=[PLTextViewdelegate new];
        _wsDelegate.delegateInterceptor = [[MessageInterceptor alloc] init];
        _wsDelegate.delegateInterceptor.middleMan = _wsDelegate;
        _wsDelegate.delegateInterceptor.receiver = delegate;
        
        super.delegate = (id)_wsDelegate.delegateInterceptor;
    }
    _wsDelegate.delegateInterceptor.receiver=delegate;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if(self) {
        self.delegate=nil;
        
        self.backgroundColor= [UIColor clearColor];
        
        UILabel *placeholderLabel = [[UILabel alloc]init];//添加一个占位label
        
        placeholderLabel.backgroundColor= [UIColor clearColor];
        
        placeholderLabel.numberOfLines=0; //设置可以输入多行文字时可以自动换行
        
        [self addSubview:placeholderLabel];
        
        self.placeholderLabel= placeholderLabel; //赋值保存
        
        self.PlaceholderColor= [UIColor lightGrayColor]; //设置占位文字默认颜色
        
        self.font= [UIFont systemFontOfSize:15]; //设置默认的字体
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self]; //通知:监听文字的改变
        self.retunHiddenKey=YES;
        self.returnKeyType=UIReturnKeyDone;
    }
    
    return self;
    
}


#pragma mark -监听文字改变

- (void)textDidChange {
    
    self.placeholderLabel.hidden = self.hasText;
    
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.placeholderLabel.frameY=8; //设置UILabel 的 y值
    
    self.placeholderLabel.frameX=5;//设置 UILabel 的 x 值
    
    self.placeholderLabel.frameWidth=self.frameWidth-self.placeholderLabel.frameX*2.0; //设置 UILabel 的 x
    
    //根据文字计算高度
    
    CGSize maxSize =CGSizeMake(self.placeholderLabel.frameWidth,MAXFLOAT);
    
    self.placeholderLabel.frameHeight= [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.placeholderLabel.font} context:nil].size.height;
    
}


- (void)setPlaceholder:(NSString*)myPlaceholder{
    
    _placeholder= [myPlaceholder copy];
    
    //设置文字
    
    self.placeholderLabel.text= myPlaceholder;
    
    //重新计算子控件frame
    
    [self setNeedsLayout];
    
}


- (void)setPlaceholderColor:(UIColor*)myPlaceholderColor{
    
    _PlaceholderColor= myPlaceholderColor;
    
    //设置颜色
    
    self.placeholderLabel.textColor= myPlaceholderColor;
    
}


//重写这个set方法保持font一致

- (void)setFont:(UIFont*)font {
    
    [super setFont:font];
    
    self.placeholderLabel.font= font;
    
    //重新计算子控件frame
    
    [self setNeedsLayout];
    
}
- (void)setText:(NSString*)text{
    
    [super setText:text];
    
    [self textDidChange]; //这里调用的就是 UITextViewTextDidChangeNotification 通知的回调
    
}


- (void)setAttributedText:(NSAttributedString*)attributedText {
    
    [super setAttributedText:attributedText];
    
    [self textDidChange]; //这里调用的就是UITextViewTextDidChangeNotification 通知的回调
    
}


- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end


