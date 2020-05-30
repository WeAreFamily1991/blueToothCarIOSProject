//
//  MyXibView.m
//  TrendyApp
//
//  Created by 55like on 2019/2/21.
//  Copyright © 2019 55like. All rights reserved.
//

#import "MyXibView.h"

@implementation MyXibView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadmyview];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor=rgbBlue;
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=  [super initWithCoder:aDecoder];
    if (self) {
        [self loadmyview];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    
}
-(void)loadmyview{
    
    UIView* view=[[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil]lastObject];
    
    if (self.frameHeight==0) {
        self.frameHeight=view.frameHeight;
        view.frameSize=self.frameSize;
    }else{
        view.frameSize=self.frameSize;
    }
    self.xibView=view;
    [self addSubview:view];
}

@end
