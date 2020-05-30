//
//  PerforManceTestTool.h
//  55likeLibDemo
//
//  Created by 55like on 2017/10/30.
//  Copyright © 2017年 55like lj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PerforManceTestTool : NSObject
+(float)testPerforManceWithName:(NSString*)name WithTimes:(NSInteger)times With:(AllcallBlock)block;
@end
