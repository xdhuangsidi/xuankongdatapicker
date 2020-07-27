//
//  XKDateGanzhiCaluateUtil.h
//  xuankongDataPicker
//
//  Created by huangsidi on 2020/7/25.
//  Copyright © 2020 huang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XKOutputResultData;


@interface XKDateGanzhiCaluateUtil : NSObject
+ (XKDateGanzhiCaluateUtil *)sharedInstance;
- (NSArray<XKOutputResultData *> *)caluateALLWithDateBuf:(int[])date_buf;
@end


