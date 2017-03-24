//
//  WKBaseAlertView.h
//  WuKongAppStore
//
//  Created by ZhangJingHao2345 on 2017/3/20.
//  Copyright © 2017年 Shanghai 2345 Co., Ltd. All rights reserved.
//

/**
 弹框基类，处理动画添加、移除等公共部分
 */

#define SCREEN_WIDTH            ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_MY_WIDTH(a)      ((a) * SCREEN_WIDTH / 375.f)
#define RGB_Color(r, g, b)      [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define UIColorFromRGB(rgbValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]

#import <UIKit/UIKit.h>

@interface WKBaseAlertView : UIView

/** 内容视图 */
@property (nonatomic, weak) UIView *contentView;

/** 背景遮盖，默认为NO */
@property (nonatomic, assign) BOOL isShowBackCover;

/** 隐藏时从父类移除，默认为YES */
@property (nonatomic, assign) BOOL removeFromSuperViewOnHide;

/**
 初始化

 @param view 父视图
 */
- (instancetype)initWithView:(UIView *)view;

/**
 展示视图
 
 @param animated 是否动画
 */
- (void)showWithAnimated:(BOOL)animated;

/**
 隐藏视图

 @param animated 是否动画
 */
- (void)hideAnimated:(BOOL)animated;

/**
 延迟隐藏视图

 @param animated 是否动画
 @param delay 延迟时间
 */
- (void)hideAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay;

@end
