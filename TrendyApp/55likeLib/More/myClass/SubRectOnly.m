//
//  SubRectOnly.m
//  SpookCam
//
//  Created by 55like on 18/04/2017.
//
//

#import "SubRectOnly.h"

@implementation SubRectOnly



-(BOOL)HavePointX:(NSInteger)x Y:(NSInteger)y{

    if (x<self.x) {
        return NO;
    }
    if (x>self.x+self.width) {
        return NO;
    }
    if (y<self.y) {
        return NO;
    }
    if (y>self.y+self.height) {
        return NO;
    }
    


    return YES;
}
@end
