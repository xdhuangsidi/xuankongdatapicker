//
//  XKOutputResultData.m
//  xuankongDataPicker
//
//  Created by kingsoft on 2020/7/24.
//  Copyright © 2020 huang. All rights reserved.
//

#import "XKOutputResultData.h"
#import "XKConstant.h"
@implementation XKOutputResultData

- (NSString *)result {
    return [NSString stringWithFormat:@"%@\n%@\n\n%ld\n%ld\n\n%@\n\n%@\n\n%@",_gan, _zhi, _upGua, _downGua, [XKConstant guaNameWithUp:_upGua Down:_downGua], _guayun, [XKConstant houTianSingGua:_guayunIndex]];
  
}

- (void)fillDefaultData {
    _gan = [XKConstant tianGan:1];
    _zhi = [XKConstant diZhi:1];
}

- (void)fillGan:(NSUInteger)gan Zhi:(NSUInteger)zhi {
    _ganIndex = gan;
    _zhiIndex = zhi;
    
    _gan = [XKConstant tianGan:gan];
    _zhi= [XKConstant diZhi:zhi];
}

@end
