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
    return [NSString stringWithFormat:@"%@\n%@",_gan,_zhi];
}

- (void)fillDefaultData {
    _gan = [XKConstant tianGan:1];
    _zhi = [XKConstant diZhi:1];
}


@end
