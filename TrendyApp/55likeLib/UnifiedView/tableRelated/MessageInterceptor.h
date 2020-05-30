
#import <Foundation/Foundation.h>

@interface MessageInterceptor : NSObject
//change strong to  assign  2013.06.21
@property (nonatomic, weak) id receiver;
@property (nonatomic, weak) id middleMan;
@end
