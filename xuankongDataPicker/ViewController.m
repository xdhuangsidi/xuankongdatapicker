//
//  ViewController.m
//  xuankongDataPicker
//
//  Created by kingsoft on 2020/7/24.
//  Copyright © 2020 huang. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#include "swephexp.h"
#include "sweph.h"
#include "math.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *lable = [[UILabel alloc]init];
    lable.textColor = [UIColor blackColor];
    [self.view addSubview:lable];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.view);
    }];
    double julday = swe_julday1(2020, 07, 22, 8, 37, YES);
    double computerInfo[7];
    char * errorInfo = (char *)malloc(600);
    swe_calc_ut(julday, 0, 258, computerInfo, errorInfo);
    double sunDegree = computerInfo[0];
    lable.text = [NSString stringWithFormat:@"%f", sunDegree];
    // Do any additional setup after loading the view.
}


@end
