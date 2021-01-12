//
//  XKDateGanzhiCaluateUtil.m
//  xuankongDataPicker
//
//  Created by huangsidi on 2020/7/25.
//  Copyright © 2020 huang. All rights reserved.
//

#import "XKDateGanzhiCaluateUtil.h"
#import "XKConstant.h"
#import "XKOutputResultData.h"

#include "swephexp.h"
#include "sweph.h"
#include "math.h"

@implementation XKDateGanzhiCaluateUtil

static XKDateGanzhiCaluateUtil *SINGLETON = nil;

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SINGLETON = [[XKDateGanzhiCaluateUtil alloc] init];
    });
    
    return SINGLETON;
}

- (double)sunHuangjingPositon:(int[])date_buf {
    double julday = swe_julday1(date_buf[0], date_buf[1], date_buf[2], date_buf[3], date_buf[4],  YES);
    double computerInfo[7];
    char * errorInfo = (char *)malloc(600);
    swe_calc_ut(julday, 0, 258, computerInfo, errorInfo);
    return computerInfo[0];
}

/**
 根据太阳位置确定节气，从而得到月支
 */
- (NSUInteger)caluateMonthDizhiWithSunPosition:(double)sunPosition {
    NSUInteger index = 0;
    /**
     简洁算法: index = (( (sunPosition + 15) /  30 )  + 3 ) % 12
     */
    if (sunPosition >= 315 && sunPosition < 345) {
        // 立春建 寅
        index = 2;
    } else if ((sunPosition >= 345 && sunPosition <= 360) || (sunPosition >= 0 && sunPosition < 15)) {
        // 惊蜇建 卯
        index = 3;
    } else if (sunPosition >= 15 && sunPosition < 45) {
        // 清明建 辰
        index = 4;
    } else if (sunPosition >= 45 && sunPosition < 75) {
        // 立夏建 巳
        index = 5;
    } else if (sunPosition >= 75 && sunPosition < 105) {
        // 芒种建 午
        index = 6;
    } else if (sunPosition >= 105 && sunPosition < 135) {
        // 小暑建 未
        index = 7;
    } else if (sunPosition >= 135 && sunPosition < 165) {
        // 立秋建 申
        index = 8;
    } else if (sunPosition >= 165 && sunPosition < 195) {
        // 白露建 酉
        index = 9;
    } else if (sunPosition >= 195 && sunPosition < 225) {
        // 寒露建 戌
        index = 10;
    } else if (sunPosition >= 225 && sunPosition < 255) {
        // 小雪建 亥
        index = 11;
    } else if (sunPosition >= 255 && sunPosition < 285) {
        // 大雪建 子
        index = 0;
    } else if (sunPosition >= 285 && sunPosition < 315) {
        // 小寒建 丑
        index = 1;
    }
    return index;
}

/**
    甲己之年丙作首——逢年干是甲或己的年份，正月(2)的月干从丙上起！
 　　乙庚之年戊为头——逢年干是乙或庚的年份，正月的月干从戊上起！
 　　丙辛之岁寻庚上——逢年干是丙或辛的年份，正月的月干从庚上起！
 　　丁壬壬寅顺水流——逢年干是丁或壬的年份，正月的月干从壬上起！
 　　若问戊癸何方发，甲寅之上好追求——逢年干是戊或癸的年份，正月的月干从甲上起
 */
- (NSUInteger)caluateMontTianGanWithYearGan:(NSUInteger)yearGan monthDizhi:(NSUInteger)monthDizhi {
    // 甲己默认 丙上起
    // 简洁算法 beginZhi = ((yearGan % 5 + 1) * 2) % 10
    NSUInteger beginZhi = 2;
    if (monthDizhi == 1 || monthDizhi == 0) {
        yearGan++;
    }
    switch (yearGan) {
        case 1:
        case 6:
            beginZhi = 4;
            break;
        
        case 2:
        case 7:
            beginZhi = 6;
            break;
            
        case 3:
        case 8:
            beginZhi = 8;
            break;
            
        case 4:
        case 9:
            beginZhi = 0;
            
        default:
            break;
    }
    NSUInteger gan = (beginZhi + (monthDizhi - 2)) % 10;
    return gan;
}

- (NSUInteger)caluateYearGan:(NSUInteger)year month:(NSUInteger)month sunPosition:(double)sunPosition {
    NSUInteger gan = (year - 4) % 10;
    
    // 立春后才是新的一年，故小寒这段时间和 1月1日到小寒这段时间都为上一年，要减1
    if ((sunPosition < 315 && sunPosition > 285) || month == 1) {
        gan = (gan == 0) ? 10 : gan;
        gan--;
    }
    return gan;
}

- (NSUInteger)caluateYearZhi:(NSUInteger)year month:(NSUInteger)month sunPosition:(double)sunPosition {
    NSUInteger zhi = (year - 4) % 12;
    
    // 立春后才是新的一年，故小寒这段时间和 1月1日到小寒这段时间都为上一年，要减1
    if ((sunPosition < 315 && sunPosition > 285) || month == 1) {
        zhi = (zhi == 0) ? 12 : zhi;
        zhi--;
    }
    return zhi;
}

- (NSUInteger)caluateHourZhi:(NSUInteger)hour {
    return ((hour + 1) / 2) % 12;
}

/**
 甲己还加甲，乙庚丙作初。。。
 */
- (NSUInteger)caluateHourGanWithDayGan:(NSUInteger)dayGan hourZhi:(NSUInteger)zhi {
    NSUInteger beginGan = (dayGan % 5) * 2;
    return (beginGan + zhi) % 10;
}

/**
 日地支的结果依赖于天干，所以一起算
 */
- (XKOutputResultData *)caluateDayGanAndZhi:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day hour:(NSUInteger)hour {
    if (month <= 2) {
        month = month + 12;
        year--;
    }
    NSUInteger x = year / 100;
    NSUInteger y = year % 100;
    NSUInteger G = 5 * (x + y) + (x / 4) + (y / 4) + (month + 1) * 3 / 5 + day - 3 - x;
    NSUInteger Z = G + 4 * x + 10 + (month % 2 == 0 ? 6 : 0);
    
    // 定义是00是甲子，需各减1适配为该程序的计数体系
    G--;
    Z--;
    if (hour >= 23) {
        // 23点以后是第二天
        G++;
        Z++;
        
    }
    XKOutputResultData *dayDate = [[XKOutputResultData alloc] init];
    [dayDate fillGan:(G % 10) Zhi:(Z % 12)];
    return dayDate;
}

/**
  64卦，为了保证排序与先天八卦数一直，0和5是非法数字
    1-地坤 2-风巽 3-火离 4-泽兑 6-山艮 7-水坎 8-雷震 9-天乾
 */


/**
 甲子为坤卦之始，亦为伏卦孕育之初。母孕头胎为长子，为复卦（坤卦动初爻也）；
 二胎中女为明夷卦（坤卦动二爻也）；三胎少女为地泽临卦（坤卦动三爻也）。
 天地交合而为泰卦，合则孕长女为地风升卦（地天泰卦动初爻也）,继孕中男地水师卦，
 再产少男地山谦卦。是故以长子震为首：（震离兑干 ｜ 巽坎艮坤）为序（8349 ｜ 2761）
                                0  2 4  6 8 / 1 3 5 7 9
 五子0 依次配 复 /坤  （甲子11/18）、 颐 （丙子68）、屯    （戊子78）、益  （庚子28）、｜  震（壬子88）
 五丑1 依次配 噬嗑（乙丑38）、 随    （丁丑48）、 无妄（己丑98）-； 明夷（辛丑13）、     贲（癸丑63）
 五寅2 依次配 既济（甲寅73）、 家人（丙寅23）、｜ 丰（戊寅83）、离/革（庚寅33/43）、 同人（壬寅93）- 1672 8349
 五卯3  依次配临   （乙卯14）、损     （丁卯64）        节（己卯74）、 中孚（辛卯24）、      归妹（癸卯84）
 五辰4  依次 配睽   （甲辰34）、泽   （丙辰44）       履（戊辰94）｜、泰（庚辰19）、大蓄（壬辰69）
 五巳5   依次配   需（乙巳79）、小蓄（丁巳29）    大壮（己巳89）、大有（辛巳39）、 夬（癸巳49）
 
 五午6   依次乾/姤 （甲午99/92）、大过（丙午42） 鼎（戊午32）、恒（庚午82）、巽（壬午22）
 五未7   依次配    井（乙未72）、蛊（丁未62） 升（己未12）、讼（辛未97）、困（癸未47）
 五申8   依次配  未济（甲申37）、解（丙申87） 涣（戊申27）、坎蒙（庚申77/67）、师（壬申16）- 9438 2761
 五酉9                      遁 （乙酉96）、（46） （36）、（86）、（26）
 五戌10                       （76）、（66） （16）、（91）、（41）
 五亥11                      （31）、（81） （21）、（71）、（61）
 
 
 TODO : 根据上面这个变化规律，还有更简洁的写法
 */
- (void)setupXuanKongBaGuaData:(XKOutputResultData *)data {
    NSUInteger ganIndex = ((data.ganIndex % 2 == 0)  ? (data.ganIndex / 2) : ((data.ganIndex - 1) / 2) );
    NSUInteger zhiIndex = data.zhiIndex;
    
    NSUInteger up = 0;
    NSUInteger down = 8;
    //                 0  1  2  3  4  5  6  7
    int yangArray[] = {1, 6, 7, 2, 8, 3, 4, 9};
    int yinArray[] = {9, 4, 3, 8, 2, 7, 6, 1};
    
    if (zhiIndex == 0) {
        up = yangArray[(0 + ganIndex) % 8];
        down = 8;
    } else if (zhiIndex == 1) {
        up = yangArray[(5 + ganIndex) % 8];
        down = (ganIndex <= 2 ? 8 : 3);
    } else if (zhiIndex == 2) {
        up = yangArray[(2 + ganIndex) % 8];
        down = 3;
    } else if (zhiIndex == 3) {
        up = yangArray[(0 + ganIndex) % 8];
        down = 4;
    } else if (zhiIndex == 4) {
        up = yangArray[(5 + ganIndex) % 8];
        down = (ganIndex <= 2 ? 4 : 9);
    } else if (zhiIndex == 5) {
        up = yangArray[(2 + ganIndex) % 8];
        down = 9;
    } else if (zhiIndex == 6) {
        up = yinArray[(0 + ganIndex) % 8];
        down = 2;
    } else if (zhiIndex == 7) {
        up = yinArray[(5 + ganIndex) % 8];
        down = (ganIndex <= 2 ? 2 : 7);
    } else if (zhiIndex == 8) {
        up = yinArray[(2 + ganIndex) % 8];
        down = (ganIndex <= 3 ? 7 : 6);
    } else if (zhiIndex == 9) {
        up = yinArray[(0 + ganIndex) % 8];
        down = 6;
    } else if (zhiIndex == 10) {
        up = yinArray[(5 + ganIndex) % 8];
        down = (ganIndex <= 2 ? 6 : 1);
    } else if (zhiIndex == 11) {
        up = yinArray[(2 + ganIndex) % 8];
        down = 1;
    }
    data.upGua = up;
    data.downGua = down;
    [self caluateGuaYun:data];
}



/**
 
 1-地坤 2-风巽 3-火离 4-泽兑 6-山艮 7-水坎 8-雷震 9-天乾
 
 贪狼不变一运来（上下两卦卦爻相同者，为一运卦，如乾99、兑44、离33、震88、巽22、坎77、艮66、坤11）up == down                                  99  44  33  88  22  77  66 11
九运全变弼应该（上下两卦卦爻相反者，为九运卦，如否91、咸46、未济73、恒82、益28、旣济37、损64、泰19）up + down = 10                       91  19  46  64  73  37  28 82
二运巨门上中变（上下两卦卦爻其上爻中爻相反为二运卦，如无妄98、革34、睽43、大壮89、观21、蹇76、蒙67、升12）|up - down | = 1            98  89  43  34   21 12  76  67
八运辅星初爻裁（上下两卦只有初爻相反者，为八运卦，如姤92、困47、旅36、豫81、小畜29、节74、贲92、复18） ｜up - down| = 7 or 3           92  29  47  74  36  63  81 18
三运禄存上下变（上下两卦上下爻相反者，为三运卦，如讼97、大过42、晋31、小过86、中孚24、需79、颐68、明夷13） | up -down | = 2;          97  79  42  24  31  13  68 86
七运破军变中胎（上下两卦只有中爻相反者，为七运卦，如同人93、随48、大有39、归妹84、渐26、比71、蛊62、师17）up + down = 8 or 12;    93  39  48  84  26  62  17 71
四运中下文曲处（上下两卦中爻下爻相反者，为四运卦，如遁96、萃41、鼎32、解87、家人23、屯78、大畜69、临14）up + down = 5 or 15;        96  69  41  14  23  32  78 87
六运武曲上爻抬（上下两卦只有上爻相反者，为六运卦，如94履、夬49、噬嗑38、丰83、涣27、井72、剥61、谦16） | up -down | = 5                   94  49  16  61 38  83  72  27
此是玄空大卦诀，合乎零正发丁财

 */
- (void)caluateGuaYun:(XKOutputResultData *)data {
    NSUInteger up = data.upGua;
    NSUInteger down = data.downGua;
    NSString *guaYun = @"0";
    NSUInteger guaIndex = 0;
    NSUInteger total = up * 10 + down;
    if        (total == 99 || total == 44 || total == 33 || total == 88 || total == 22 || total == 77 || total == 66 || total == 11) {
        guaYun = @"一";
        guaIndex = 1;
    } else if (total == 91 || total == 19 || total == 46 || total == 64 || total == 73 || total == 37 || total == 28 || total == 82) {
        guaYun = @"九";
        guaIndex = 9;
    } else if (total == 98 || total == 89 || total == 43 || total == 34 || total == 21 || total == 12 || total == 76 || total == 67) {
        guaYun = @"二";
        guaIndex = 2;
    } else if (total == 92 || total == 29 || total == 47 || total == 74 || total == 36 || total == 63 || total == 18 || total == 81) {
        guaYun = @"八";
        guaIndex = 8;
    } else if (total == 97 || total == 79 || total == 42 || total == 24 || total == 31 || total == 13 || total == 68 || total == 86) {
        guaYun = @"三";
        guaIndex = 3;
    } else if (total == 93 || total == 39 || total == 48 || total == 84 || total == 26 || total == 62 || total == 17 || total == 71) {
        guaYun = @"七";
        guaIndex = 7;
    } else if (total == 96 || total == 69 || total == 41 || total == 14 || total == 23 || total == 32 || total == 78 || total == 87) {
        guaYun = @"四";
        guaIndex = 4;
    } else if (total == 94 || total == 49 || total == 16 || total == 61 || total == 38 || total == 83 || total == 72 || total == 27) {
        guaYun = @"六";
        guaIndex = 6;
    }
    data.guayun = guaYun;
    data.guayunIndex = guaIndex;
    [self caluateHouTianGua:data];
    
}

/**
 计算后天八卦
 二三六运下卦变，一四八九上卦宫；

 七运归魂看下卦，审准卦运认祖宗。
 
  1-地坤 2-风巽 3-火离 4-泽兑 6-山艮 7-水坎 8-雷震 9-天乾
 */

- (void)caluateHouTianGua:(XKOutputResultData *)data {
    NSUInteger guaIndex = data.guayunIndex;
    if (guaIndex == 2 || guaIndex == 3 || guaIndex == 6) {
        data.guayunIndex = [self indexOfBianGua:data.downGua];
    } else if (guaIndex == 1 || guaIndex == 4 || guaIndex == 8 || guaIndex == 9) {
        data.guayunIndex = data.upGua;
    } else if (guaIndex == 7) {
        data.guayunIndex = data.downGua;
    }
}

- (NSUInteger)indexOfBianGua:(NSUInteger)originGuaIndex {
    NSUInteger bianGuaIndex = 0;
    switch (originGuaIndex) {
        case 1:
            bianGuaIndex = 9;
            break;
        case 2:
            bianGuaIndex = 8;
            break;
        case 3:
            bianGuaIndex = 7;
            break;
        case 4:
            bianGuaIndex = 6;
            break;
        case 6:
            bianGuaIndex = 4;
            break;
        case 7:
            bianGuaIndex = 3;
            break;
        case 8:
            bianGuaIndex = 2;
            break;
        case 9:
            bianGuaIndex = 1;
            break;
        default:
            break;
    }
    return bianGuaIndex;
}


- (NSArray<XKOutputResultData *> *)caluateALLWithDateBuf:(int[])date_buf {
    double sunPosition = [self sunHuangjingPositon:date_buf];
    NSUInteger year = date_buf[0];
    NSUInteger month = date_buf[1];
    NSUInteger day = date_buf[2];
    NSUInteger hour = date_buf[3];
    
    XKOutputResultData *yearData = [[XKOutputResultData alloc] init];
    NSUInteger yearGan = [self caluateYearGan:year month:month sunPosition:sunPosition];
    NSUInteger yearZhi = [self caluateYearZhi:year month:month sunPosition:sunPosition];
    [yearData fillGan:yearGan Zhi:yearZhi];
    [self setupXuanKongBaGuaData:yearData];
    
    XKOutputResultData *monthData = [[XKOutputResultData alloc] init];
    NSUInteger monthZhi = [self caluateMonthDizhiWithSunPosition:sunPosition];
    NSUInteger monthGan = [self caluateMontTianGanWithYearGan:yearGan monthDizhi:monthZhi];
    [monthData fillGan:monthGan Zhi:monthZhi];
    [self setupXuanKongBaGuaData:monthData];
    
    XKOutputResultData *dayData = [self caluateDayGanAndZhi:year month:month day:day hour:hour];
    [self setupXuanKongBaGuaData:dayData];
    
    XKOutputResultData *hourData = [[XKOutputResultData alloc] init];
    NSUInteger hourZhi = [self caluateHourZhi:hour];
    NSUInteger hourGan = [self caluateHourGanWithDayGan:dayData.ganIndex hourZhi:hourZhi];
    [hourData fillGan:hourGan Zhi:hourZhi];
    [self setupXuanKongBaGuaData:hourData];
    
    return @[yearData, monthData, dayData, hourData];
}


@end
