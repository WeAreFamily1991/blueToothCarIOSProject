//
//  MyUiIAlertView.h
//  LuxuryCarUser55like
//
//  Created by 55like on 04/09/2017.
//  Copyright © 2017 55like lj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AlertViewCallBackBlock)( UIAlertView* _Nonnull  alertView,NSInteger buttonIndex);
@interface MyUiIAlertView : UIAlertView

+( UIAlertView* _Nullable )showAlerttWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString*)btntitle WithAlertBlock:(_Nullable AlertViewCallBackBlock)alertBlock;

//
//+(UIAlertView*)xshowAlerttWithAlertBlock:(AlertViewCallBackBlock)alertBlock WithTitle:( NSString *)title message:( NSString *)message cancelButtonTitle:( NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ... ;

//- (instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id /*<UIAlertViewDelegate>*/)delegate cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION NS_EXTENSION_UNAVAILABLE_IOS("Use UIAlertController instead.");
@end
