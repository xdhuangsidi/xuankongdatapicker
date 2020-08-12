//
//  XKOutputResultData.h
//  xuankongDataPicker
//
//  Created by huangsidi on 2020/7/24.
//  Copyright © 2020 huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XKOutputResultData : NSObject

@property (nonatomic, copy) NSString *gan;
@property (nonatomic, assign) NSUInteger ganIndex;

@property (nonatomic, copy) NSString *zhi;
@property (nonatomic, assign) NSUInteger zhiIndex;

@property (nonatomic, assign) NSUInteger upGua;
@property (nonatomic, assign) NSUInteger downGua;
@property (nonatomic, copy) NSString *guaName;
@property (nonatomic, copy) NSString *gua1;
@property (nonatomic, copy) NSString *gua2;
@property (nonatomic, assign) NSUInteger houTianGuaIndex;

@property (nonatomic, copy) NSString *guayun;
@property (nonatomic, assign) NSUInteger guayunIndex;

- (NSString *)result;
- (void)fillDefaultData;

- (void)fillGan:(NSUInteger)gan Zhi:(NSUInteger)zhi;
@end

NS_ASSUME_NONNULL_END
