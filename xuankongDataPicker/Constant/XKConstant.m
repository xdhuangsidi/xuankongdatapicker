//
//  XKConstant.m
//  xuankongDataPicker
//
//  Created by kingsoft on 2020/7/24.
//  Copyright © 2020 huang. All rights reserved.
//

#import "XKConstant.h"

@implementation XKConstant

+ (NSString *)tianGan:(NSUInteger)count {
    static NSArray<NSString *> *tianGanArray = nil;
    if (tianGanArray == nil) {
        tianGanArray = @[@"甲",@"乙",@"丙",@"丁",@"戊",@"己",@"庚",@"辛",@"壬",@"癸"];
    }
    
    return tianGanArray[count % 10];

}

+ (NSString *)diZhi:(NSUInteger)count {
    static NSArray<NSString *> *diZhiArray = nil;
     if (diZhiArray == nil) {
         diZhiArray = @[@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥"];
     }
     return diZhiArray[count % 12];
}

@end
