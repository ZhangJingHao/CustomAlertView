//
//  WKBlockAlertView.h
//  AppMarket
//
//  Created by ZhangJingHao2345 on 2017/2/14.
//  Copyright © 2017年 2345 Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKBlockAlertItem : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) void (^action)();

- (instancetype)initWithTitle:(NSString *)title
                       action:(void (^)())action;

@end


@interface WKBlockAlertView : UIAlertView

- (instancetype)initWithTitle:(NSString *)inTitle
                      message:(NSString *)inMessage
             cancelButtonItem:(WKBlockAlertItem *)inCancelButtonItem
        destructiveButtonItem:(WKBlockAlertItem *)inDestructiveItem
             otherButtonItems:(WKBlockAlertItem *)inOtherButtonItems, ... NS_REQUIRES_NIL_TERMINATION;

@end
