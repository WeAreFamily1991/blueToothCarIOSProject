//
//  SubRectOnly.h
//  SpookCam
//
//  Created by 55like on 18/04/2017.
//
//

#import <Foundation/Foundation.h>

@interface SubRectOnly : NSObject
@property(nonatomic,assign)NSUInteger x;
@property(nonatomic,assign)NSUInteger y;
@property(nonatomic,assign)NSUInteger height;
@property(nonatomic,assign)NSUInteger width;

-(BOOL)HavePointX:(NSInteger)x Y:(NSInteger)y;
@end
