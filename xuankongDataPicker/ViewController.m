//
//  ViewController.m
//  xuankongDataPicker
//
//  Created by kingsoft on 2020/7/24.
//  Copyright © 2020 huang. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>

#import "XKOutputResultData.h"
#import "XKDateGanzhiCaluateUtil.h"
#import "CHDatePickerViewHeader.h"
#import "CHPickerView.h"

@interface ViewController ()  <CHDatePickerViewDelegate>
@property (nonatomic, strong) NSDate *selectDate;
@property (nonatomic, strong) UILabel *yearDetailLabel;
@property (nonatomic, strong) UILabel *monthDetalLabel;
@property (nonatomic, strong) UILabel *dayDetailLabel;
@property (nonatomic, strong) UILabel *hourDetailLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) NSDateFormatter *formatter;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectDate = [NSDate date];
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    UIButton *beforeButton = [[UIButton alloc] init];
    beforeButton.layer.cornerRadius = 4;
    beforeButton.titleLabel.textColor = [UIColor blackColor];
    beforeButton.layer.borderWidth = 1;
    beforeButton.layer.borderColor = [UIColor blackColor].CGColor;
    beforeButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [beforeButton setTitle:@"前一个小时" forState:UIControlStateNormal];
    [beforeButton addTarget:self action:@selector(beforeHourAction) forControlEvents:UIControlEventTouchUpInside];
    [beforeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:beforeButton];
    [beforeButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self.view.mas_top).offset(100);
        make.height.mas_equalTo(42);
        make.width.mas_equalTo(80);
    }];
    
    UIButton *selectButton = [[UIButton alloc] init];
    [selectButton setTitle:@"选择时间" forState:UIControlStateNormal];
    [selectButton addTarget:self action:@selector(selectDateAction) forControlEvents:UIControlEventTouchUpInside];
    [selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    selectButton.layer.cornerRadius = 4;
    selectButton.titleLabel.textColor = [UIColor blackColor];
    selectButton.titleLabel.font = [UIFont systemFontOfSize:12];
    selectButton.layer.borderWidth = 1;
    selectButton.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:selectButton];
    [selectButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(100);
        make.height.mas_equalTo(42);
        make.width.mas_equalTo(80);
    }];
    
    UIButton *afterButton = [[UIButton alloc] init];
    [afterButton setTitle:@"后一个小时" forState:UIControlStateNormal];
    [afterButton addTarget:self action:@selector(afterHourAction) forControlEvents:UIControlEventTouchUpInside];
    [afterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    afterButton.layer.cornerRadius = 4;
    afterButton.titleLabel.textColor = [UIColor blackColor];
    afterButton.layer.borderWidth = 1;
    afterButton.titleLabel.font = [UIFont systemFontOfSize:12];
    afterButton.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:afterButton];
    [afterButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(self.view.mas_top).offset(100);
        make.height.mas_equalTo(42);
        make.width.mas_equalTo(80);
    }];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textColor = [UIColor blackColor];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.mas_equalTo(42);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(afterButton.mas_bottom).offset(10);
    }];
    
    

    self.timeLabel.text = [_formatter stringFromDate:_selectDate];
    
    CGFloat space = ([UIScreen mainScreen].bounds.size.width - 20 * 4) / 5;
    
    UILabel *yearLabel = [[UILabel alloc] init];
    yearLabel.text = @"年";
    yearLabel.textColor = [UIColor blackColor];
    [self.view addSubview:yearLabel];
    [yearLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-space);
        make.width.mas_equalTo(20);
    }];
    
    UILabel *monthLabel = [[UILabel alloc] init];
    monthLabel.text = @"月";
    monthLabel.textColor = [UIColor blackColor];
    [self.view addSubview:monthLabel];
    [monthLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(yearLabel.mas_left).offset(-space);
        make.width.mas_equalTo(20);
    }];
    
    UILabel *dayLabel = [[UILabel alloc] init];
    dayLabel.text = @"日";
    dayLabel.textColor = [UIColor blackColor];
    [self.view addSubview:dayLabel];
    [dayLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(monthLabel.mas_left).offset(-space);
        make.width.mas_equalTo(20);
    }];
    
    UILabel *hourLabel = [[UILabel alloc] init];
    hourLabel.text = @"时";
    hourLabel.textColor = [UIColor blackColor];
    [self.view addSubview:hourLabel];
    [hourLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(dayLabel.mas_left).offset(-space);
        make.width.mas_equalTo(20);
    }];
    
    UILabel *yearDetailLabel = [[UILabel alloc] init];
    yearDetailLabel.numberOfLines = 0;
    yearDetailLabel.textColor = [UIColor blackColor];
    yearDetailLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:yearDetailLabel];
    self.yearDetailLabel = yearDetailLabel;
    [yearDetailLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(yearLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-space);
        make.width.mas_equalTo(20);
    }];

    
    UILabel *monthDetailLabel = [[UILabel alloc] init];
    monthDetailLabel.numberOfLines = 0;
    monthDetailLabel.textColor = [UIColor blackColor];
    monthDetailLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:monthDetailLabel];
    self.monthDetalLabel = monthDetailLabel;
    [monthDetailLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(yearLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(yearLabel.mas_left).offset(-space);
        make.width.mas_equalTo(20);
    }];

    
    UILabel *dayDetailLabel = [[UILabel alloc] init];
    dayDetailLabel.numberOfLines = 0;
    dayDetailLabel.textAlignment = NSTextAlignmentCenter;
    dayDetailLabel.textColor = [UIColor blackColor];
    [self.view addSubview:dayDetailLabel];
    self.dayDetailLabel = dayDetailLabel;
    [dayDetailLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(yearLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(monthLabel.mas_left).offset(-space);
        make.width.mas_equalTo(20);
    }];
    
    UILabel *hourDetailLabel = [[UILabel alloc] init];
    hourDetailLabel.numberOfLines = 0;
    hourDetailLabel.textColor = [UIColor blackColor];
    hourDetailLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:hourDetailLabel];
    self.hourDetailLabel = hourDetailLabel;
    [hourDetailLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(yearLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(dayLabel.mas_left).offset(-space);
        make.width.mas_equalTo(20);
    }];

    [CHDatePickerView appearance].textColor = [UIColor darkGrayColor];
    [CHDatePickerView appearance].singleRowTextColor = [UIColor darkTextColor];
    [CHPickerView appearance].pickerViewSeparatorColor = [UIColor darkTextColor];
    [self caluateAndSetData];
}


- (void)beforeHourAction {
    NSTimeInterval time = [_selectDate timeIntervalSince1970] - 3600;
    _selectDate = [[NSDate alloc] initWithTimeIntervalSince1970:time];
    self.timeLabel.text = [_formatter stringFromDate:_selectDate];
    [self caluateAndSetData];
}

- (void)afterHourAction {
    NSTimeInterval time = [_selectDate timeIntervalSince1970] + 3600;
    _selectDate = [[NSDate alloc] initWithTimeIntervalSince1970:time];
    self.timeLabel.text = [_formatter stringFromDate:_selectDate];
    [self caluateAndSetData];
    
}

- (void)selectDateAction {
    CHDatePickerView *datePicker = [[CHDatePickerView alloc] init];
    datePicker.delegate = self;
    datePicker.dateTextShowType = CHDatePickerViewDateTextShowTypeSingleRow;
    datePicker.labelTitle.text = @"请选择日期";
    datePicker.date = _selectDate;
    datePicker.dateComponents = @[@(CHDatePickerViewDateComponentY) ,@(CHDatePickerViewDateComponentM) ,@(CHDatePickerViewDateComponentD) ,@(CHDatePickerViewDateComponentH) ,@(CHDatePickerViewDateComponentm)];
    [datePicker show];
}

- (void)datePickerViewDidSelectDate:(NSDate *)date dateComponents:(NSDateComponents *)dateComponents {
    NSString *dateStr = [NSString stringWithFormat:@"%ld-%ld-%ld %ld:%ld",dateComponents.year ,dateComponents.month ,dateComponents.day ,dateComponents.hour ,dateComponents.minute];
    self.timeLabel.text = dateStr;
    _selectDate = [_formatter dateFromString:dateStr];
    [self caluateAndSetData];
}

- (void)caluateAndSetData {
    if (!_selectDate) {
        _selectDate = [NSDate date];
    }
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | //年
    NSCalendarUnitMonth | //月份
    NSCalendarUnitDay | //日
    NSCalendarUnitHour |  //小时
    NSCalendarUnitMinute;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:_selectDate];
    int date_buf[5];
    date_buf[0] = (int)[dateComponent year];
    date_buf[1] = (int)[dateComponent month];
    date_buf[2] = (int)[dateComponent day];
    date_buf[3] = (int)[dateComponent hour];
    date_buf[4] = (int)[dateComponent minute];
    NSArray<XKOutputResultData *> *array = [[XKDateGanzhiCaluateUtil sharedInstance] caluateALLWithDateBuf:date_buf];
    self.yearDetailLabel.text = array[0].result;
    self.monthDetalLabel.text = array[1].result;
    self.dayDetailLabel.text = array[2].result;
    self.hourDetailLabel.text = array[3].result;
}


@end
