//
//  XKConstant.h
//  xuankongDataPicker
//
//  Created by kingsoft on 2020/7/24.
//  Copyright © 2020 huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XKConstant : NSObject
+ (NSString *)tianGan:(NSUInteger)count;
+ (NSString *)diZhi:(NSUInteger)count;
+ (NSString *)guaNameWithUp:(NSUInteger)up Down:(NSUInteger)down;
+ (NSString *)houTianSingGua:(NSUInteger)up;
@end

NS_ASSUME_NONNULL_END
