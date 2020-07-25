//
//  XKOutputResultData.h
//  xuankongDataPicker
//
//  Created by kingsoft on 2020/7/24.
//  Copyright © 2020 huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XKOutputResultData : NSObject
@property (nonatomic, copy) NSString *gan;
@property (nonatomic, copy) NSString *zhi;
@property (nonatomic, copy) NSString *num1;
@property (nonatomic, copy) NSString *num2;
@property (nonatomic, copy) NSString *gua1;
@property (nonatomic, copy) NSString *gua2;
@property (nonatomic, copy) NSString *guayun;
- (NSString *)result;
- (void)fillDefaultData;
@end

NS_ASSUME_NONNULL_END
