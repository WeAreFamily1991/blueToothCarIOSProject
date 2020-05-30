//
//  SwichButtonDemo.m
//  55likeLibDemo
//
//  Created by 55like on 21/09/2017.
//  Copyright © 2017 55like lj. All rights reserved.
//

#import "SwichButtonDemo.h"

@implementation SwichButtonDemo

-(void)openme{
    [UTILITY.currentViewController setAddValue:self forKey:@"SwichButtonDemo"];
    
    UISwitch *switchButton2 = [[UISwitch alloc] initWithFrame:CGRectMake(100, 100, 51, 30)];
    //            [switchButton2 setOnTintColor:rgbpublicColor];
    [switchButton2 setTag:101];
    
    
    switchButton2.onTintColor=rgb(242,200,58);
    [switchButton2 addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [UTILITY.currentViewController.view addSubview:switchButton2];
    
}
-(void)switchAction:(id)sender {
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSLog(@"开");
    }else {
        NSLog(@"关");
    }
}


+(void)showMyDemo{
    
SwichButtonDemo*me=    [[SwichButtonDemo alloc]init];
    [me openme];
}
@end
