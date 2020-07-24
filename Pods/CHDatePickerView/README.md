# CHDatePickerView

> 目前支持简中、繁体、英文三种语言.

> 内容支持年月日时分秒.也有12小时制的AM/PM

## 效果

### 默认为年月日

### 手动设置样式.横屏/横竖屏切换支持
![](https://github.com/MeteoriteMan/Assets/blob/master/gif/CHDatePickerView-Demo-iPhone%20Xs%20Max.gif?raw=true)

### 0.0.6新样式
> 调高了按钮背景以及row高度.以及按钮的默认大小,颜色是"自定义"的

![](https://github.com/MeteoriteMan/Assets/blob/master/gif/CHDatePickerView-Demo(0.0.6)-iPhone%20Xs%20Max.gif?raw=true)

### 0.0.7新增AM/PM样式选择
> AM/PM为国际化的(如:中文的情况下显示的是上午/下午)

![](https://github.com/MeteoriteMan/Assets/blob/master/gif/CHDatePickerView-Demo(0.0.7)-iPhone%20SE.gif?raw=true)

### 0.0.8新增row上年月日调整(绿色的线是我设置的默认没有)

**CHDatePickerViewDateTextShowTypeAllRow(默认样式)**

![](https://github.com/MeteoriteMan/Assets/blob/master/png/CHDatePickerView-Demo-0.0.8(CHDatePickerViewDateTextShowTypeAllRow)@2x.png?raw=true)

**CHDatePickerViewDateTextShowTypeNone**

![](https://github.com/MeteoriteMan/Assets/blob/master/png/CHDatePickerView-Demo-0.0.8(CHDatePickerViewDateTextShowTypeNone)@2x.png?raw=true)

**CHDatePickerViewDateTextShowTypeSingleRow**

![](https://github.com/MeteoriteMan/Assets/blob/master/png/CHDatePickerView-Demo-0.0.8(CHDatePickerViewDateTextShowTypeSingleRow)@2x.png?raw=true)

## 使用

1.起调datePickerView

```
CHDatePickerView *datePicker = [[CHDatePickerView alloc] init];	
[datePicker show];
```

2.datePickerView的显示组合设置

```
datePicker.dateStyle = CHDatePickerViewDateStyleYMDHms;
```

3.datePickerView的自定义显示组合设置

```
/// 年月日时分秒的前后是根据dateComponents内的顺序决定的.
datePicker.dateComponents = @[@(CHDatePickerViewDateComponentY) ,@(CHDatePickerViewDateComponentM) ,@(CHDatePickerViewDateComponentD) ,@(CHDatePickerViewDateComponentH) ,@(CHDatePickerViewDateComponentm) ,@(CHDatePickerViewDateComponents)];
```

4.获取数据回调的两种方式

```
// MARK: 1.block回调.
datePicker.didSelectDateBlock = ^(NSDate * _Nonnull date, NSDateComponents * _Nonnull dateComponents) {

};
    
// MARK: 2.delegate回调.
<CHDatePickerViewDelegate>
- (void)datePickerViewDidSelectDate:(NSDate *)date dateComponents:(NSDateComponents *)dateComponents {

}
```

**注意点:**
1.使用block记得要__weak typeof(xx) weakXX = xx;以免循环引用.
2.dateComponents中有年月日时分秒属性,直接.xx调用.
3.如果要获取时间戳的话使用[date timeIntervalSince1970]即可获取.

4.属性

```
一些常用的属性我已经抛在外头了.

// MARK: 0.0.1
/// 按钮背景板
@property (nonatomic ,strong) UIView *viewButtonBackground;

/// 确认按钮
@property (nonatomic ,strong) UIButton *buttonConfirm;

/// 取消按钮
@property (nonatomic ,strong) UIButton *buttonCancel;

/// 字体大小
@property (nonatomic ,strong) UIFont *textFont;

/// 文字颜色
@property (nonatomic ,strong) UIColor *textColor;

// 默认的选中时间.默认为当前时间[NSDate date]
@property (nonatomic, strong) NSDate *date;

/// 允许选中的最小时间
@property (nullable, nonatomic, strong) NSDate *minimumDate; // default is nil

/// 允许选中的最大时间
@property (nullable, nonatomic, strong) NSDate *maximumDate; // default is nil

// MARK: 0.0.2
/// 是否datePickerView显示分割线
@property (nonatomic ,assign) BOOL pickerViewSeparatorHidden;

/// datePickerView分割线颜色
@property (nonatomic ,strong) UIColor *pickerViewSeparatorColor;

// MARK: 0.0.3
/// 允许tap手势使pickerView隐藏
@property (nonatomic ,assign) BOOL allowTapToDissmiss;

// MARK: 0.0.8
/// row中间年月日显示方式
@property (nonatomic ,assign) CHDatePickerViewDateTextShowType dateTextShowType;

// MARK:SingleRow的字体(单行显示情况下可以设置这两个属性)
@property (nonatomic ,strong) UIFont *singleRowTextFont;

/// 文字颜色
@property (nonatomic ,strong) UIColor *singleRowTextColor;

```

如果想使用手动设置年月日可以使用`NSDate+CHCategory`内的方法

```
NSDate *date = [NSDate ch_setYear:year month:month day:day hour:hour minute:minute second:second];
```

## 安装

使用 [CocoaPods](http://www.cocoapods.com/) 集成.
首先在podfile中
>`pod 'CHDatePickerView'

安装一下pod

>`#import <CHDatePickerView/CHDatePickerViewHeader.h>`

## 更新记录

|版本|更新内容|
|:--|:--|
|0.2.0|支持iOS 13,不支持多窗口(multiple windows)|
|0.1.0|修复最小日期设置的一个小BUG|
|0.0.9|新增了一个标题,对于一些属性允许设置全局值|
|0.0.8|新增三种显示"年月日时分秒"的样式,详情见上图|
|0.0.7|新增12小时制的component,需要自组合的形式调用|
|0.0.6|新增繁体中文支持.稍微调整了一下UI|
|0.0.5|获取Bundle方式修正|
|0.0.4|修复本地化语言bundle不能读取的问题|
|0.0.3|直接.date设置日期未实现的BUG,0.0.3以下版本建议使用setDate: animated:方法|
|0.0.2|修复iPhoneX横屏布局遮挡问题(PS:最开始写的时候没考虑到横屏).新增一个设置分割线的属性|
|0.0.1|解决了一些bug,目前可以直接使用.|
