//
//  XKConstant.m
//  xuankongDataPicker
//
//  Created by huangsidi on 2020/7/24.
//  Copyright © 2020 huang. All rights reserved.
//

#import "XKConstant.h"

@implementation XKConstant

+ (NSString *)tianGan:(NSUInteger)count {
    static NSArray<NSString *> *tianGanArray = nil;
    if (tianGanArray == nil) {
                        //  0    1     2    3     4    5     6     7    8     9
        tianGanArray = @[@"甲",@"乙",@"丙",@"丁",@"戊",@"己",@"庚",@"辛",@"壬",@"癸"];
    }
    
    return tianGanArray[count % 10];

}

+ (NSString *)diZhi:(NSUInteger)count {
    static NSArray<NSString *> *diZhiArray = nil;
     if (diZhiArray == nil) {
                        //0     1     2    3     4    5     6     7    8     9    10   11
         diZhiArray = @[@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥"];
     }
     return diZhiArray[count % 12];
}


/**
 64卦，为了保证排序与先天八卦数一直，0和5是非法数字
   1-地坤 2-风巽 3-火离 4-泽兑 6-山艮 7-水坎 8-雷震 9-天乾
*/
+ (NSString *)guaNameWithUp:(NSUInteger)up Down:(NSUInteger)down {
    NSString *guaName = @"-";
    switch (up) {
        case 1:
            guaName = [self kunGua:down];
            break;
        case 2:
            guaName = [self xunGua:down];
            break;
        case 3:
            guaName = [self liGua:down];
            break;
        case 4:
            guaName = [self duiGua:down];
            break;
        case 6:
            guaName = [self genGua:down];
            break;
        case 7:
            guaName = [self kanGua:down];
            break;
        case 8:
            guaName = [self zhenGua:down];
            break;
        case 9:
            guaName = [self qianGua:down];
            break;
            
        default:
            break;
    }
    if (guaName.length == 1) {
        guaName = [guaName stringByAppendingString:@"\n"];
    }
    return guaName;
}

+ (NSString *)kunGua:(NSUInteger)down { // 1
    if (down > 10) {
        return @"-";
    }
    static NSArray<NSString *> *kunArray = nil;
     if (kunArray == nil) {
                      //0    1    2      3     4    5     6    7    8     9
         kunArray = @[@"-",@"坤",@"升",@"明夷",@"临",@"-",@"谦",@"师",@"复",@"泰"];
     }
    return kunArray[down];
}

+ (NSString *)genGua:(NSUInteger)down { // 6
    if (down > 10) {
        return @"-";
    }
    static NSArray<NSString *> *kunArray = nil;
     if (kunArray == nil) {
                      //0    1    2      3     4    5     6    7    8     9
         kunArray = @[@"-",@"剥",@"蛊",@"贲",@"损",@"-",@"艮",@"蒙",@"颐",@"大蓄"];
     }
    return kunArray[down];
}

+ (NSString *)kanGua:(NSUInteger)down { // 7
    if (down > 10) {
        return @"-";
    }
    static NSArray<NSString *> *kunArray = nil;
     if (kunArray == nil) {
                      //0    1    2      3     4    5     6    7    8     9
         kunArray = @[@"-",@"比",@"井",@"既济",@"节",@"-",@"蹇",@"坎",@"屯",@"需"];
     }
    return kunArray[down];
}

+ (NSString *)xunGua:(NSUInteger)down { // 2
    if (down > 10) {
        return @"-";
    }
    static NSArray<NSString *> *kunArray = nil;
     if (kunArray == nil) {
                      //0    1    2      3     4    5     6    7    8     9
         kunArray = @[@"-",@"观",@"巽",@"家人",@"中孚",@"-",@"渐",@"涣",@"益",@"小蓄"];
     }
    return kunArray[down];
}

+ (NSString *)zhenGua:(NSUInteger)down { // 8
    if (down > 10) {
        return @"-";
    }
    static NSArray<NSString *> *kunArray = nil;
     if (kunArray == nil) {
                      //0    1    2      3     4    5     6    7    8     9
         kunArray = @[@"-",@"豫",@"恒",@"丰",@"归妹",@"-",@"小过",@"解",@"震",@"大壮"];
     }
    return kunArray[down];
}

+ (NSString *)liGua:(NSUInteger)down { // 3
    if (down > 10) {
        return @"-";
    }
    static NSArray<NSString *> *kunArray = nil;
     if (kunArray == nil) {
                      //0    1    2      3     4    5     6    7    8     9
         kunArray = @[@"-",@"晋",@"鼎",@"离",@"睽",@"-",@"旅",@"未济",@"噬嗑",@"大有"];
     }
    return kunArray[down];
}

+ (NSString *)duiGua:(NSUInteger)down { // 4
    if (down > 10) {
        return @"-";
    }
    static NSArray<NSString *> *kunArray = nil;
     if (kunArray == nil) {
                      //0    1    2      3     4    5     6    7    8     9
         kunArray = @[@"-",@"萃",@"大过",@"革",@"兑",@"-",@"咸",@"困",@"随",@"夬"];
     }
    return kunArray[down];
}

+ (NSString *)qianGua:(NSUInteger)down { // 9
    if (down > 10) {
        return @"-";
    }
    static NSArray<NSString *> *kunArray = nil;
     if (kunArray == nil) {
                      //0    1    2      3     4    5     6    7    8     9
         kunArray = @[@"-",@"否",@"姤",@"同人",@"履",@"-",@"遁",@"讼",@"无妄",@"乾"];
     }
    return kunArray[down];
}


/**
 获取后天卦
 */
+ (NSString *)houTianSingGua:(NSUInteger)up {
    NSString *guaName = @"-";
    if (up == 1) {
        guaName = @"坤\n2";
    } else if (up == 2) {
        guaName = @"巽\n4";
    } else if (up == 3) {
        guaName = @"离\n9";
    } else if (up == 4) {
        guaName = @"兑\n7";
    } else if (up == 6) {
        guaName = @"艮\n8";
    } else if (up == 7) {
        guaName = @"坎\n1";
    } else if (up == 8) {
        guaName = @"震\n3";
    } else if (up == 9) {
        guaName = @"乾\n6";
    }
    return guaName;
}


@end
