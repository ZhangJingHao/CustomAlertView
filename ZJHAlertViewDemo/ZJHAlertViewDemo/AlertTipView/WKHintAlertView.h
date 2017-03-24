//
//  WKHintAlertView.h
//  AppMarket
//
//  Created by ZhangJingHao2345 on 2016/12/29.
//  Copyright © 2016年 2345 Co., Ltd. All rights reserved.
//

/**
 中间黑色提示框
 */

#import "WKBaseAlertView.h"

/// 弹窗类型
typedef NS_ENUM(NSInteger, WKHintAlertType) {
    WKHintAlertTypeText,      // 纯文字
    WKHintAlertTypeIcon,      // 纯图片
    WKHintAlertTypeIconText,  // 图片文字
};

@interface WKHintAlertView : WKBaseAlertView

/** 弹框类型 */
@property (nonatomic, assign) WKHintAlertType hintType;

/** 文字标签 */
@property (nonatomic, weak, readonly) UILabel *label;

/** 图片视图 */
@property (nonatomic, weak, readonly) UIImageView *iconView;

@end
