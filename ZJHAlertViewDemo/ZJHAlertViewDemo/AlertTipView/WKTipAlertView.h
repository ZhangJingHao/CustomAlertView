//
//  WKTipAlertView.h
//  WuKongAppStore
//
//  Created by ZhangJingHao2345 on 2017/3/23.
//  Copyright © 2017年 Shanghai 2345 Co., Ltd. All rights reserved.
//

/**
 版本检测中提示框
 */

#import "WKBaseAlertView.h"

@interface WKTipAlertView : WKBaseAlertView

/** 标题标签 */
@property (nonatomic, weak, readonly) UILabel *nameLab;
/** 内容标签 */
@property (nonatomic, weak, readonly) UILabel *contentLab;
/** 确定按钮标 */
@property (nonatomic, weak, readonly) UIButton *button;

/** 确定回调 */
@property (nonatomic, copy) void (^confirmBlock)();

@end
