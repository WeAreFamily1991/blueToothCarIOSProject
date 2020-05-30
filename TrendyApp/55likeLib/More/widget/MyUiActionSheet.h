//
//  MyUiActionSheet.h
//  55likeLibDemo
//
//  Created by 55like on 20/09/2017.
//  Copyright © 2017 55like lj. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^ActionSheetBlock)( UIActionSheet* _Nonnull  actionSheet,NSInteger buttonIndex);
@interface MyUiActionSheet : UIActionSheet
+(void)showWithActionSheetBlock:(_Nullable ActionSheetBlock)  actionSheetBlock WithTitle:(nullable NSString *)title cancelButtonTitle:(nullable NSString *)cancelButtonTitle destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ...;
@end
