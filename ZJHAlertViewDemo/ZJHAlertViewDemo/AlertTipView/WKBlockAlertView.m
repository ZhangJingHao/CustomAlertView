//
//  WKBlockAlertView.m
//  AppMarket
//
//  Created by ZhangJingHao2345 on 2017/2/14.
//  Copyright © 2017年 2345 Co., Ltd. All rights reserved.
//

#import "WKBlockAlertView.h"
#import <objc/runtime.h>

static NSString *WKAlert_BUTTON_ASS_KEY = @"WKAlert_BUTTON_ASS_KEY";

@implementation WKBlockAlertItem

- (instancetype)initWithTitle:(NSString *)title
                       action:(void (^)())action
{
    if (self = [super init]) {
        _title = title;
        _action = action;
    }
    
    return self;
}

@end


@implementation WKBlockAlertView

- (instancetype)initWithTitle:(NSString *)inTitle
                      message:(NSString *)inMessage
             cancelButtonItem:(WKBlockAlertItem *)inCancelButtonItem
        destructiveButtonItem:(WKBlockAlertItem *)inDestructiveItem
             otherButtonItems:(WKBlockAlertItem *)inOtherButtonItems, ... 
{
    if (self = [super initWithTitle:inTitle
                            message:inMessage
                           delegate:self
                  cancelButtonTitle:inCancelButtonItem.title
                  otherButtonTitles:inDestructiveItem.title, nil]) {
        
        NSMutableArray *buttonsArray = [NSMutableArray array];
        WKBlockAlertItem *eachItem;
        va_list argumentList;
        if (inOtherButtonItems) {
            [buttonsArray addObject: inOtherButtonItems];
            va_start(argumentList, inOtherButtonItems);
            while((eachItem = va_arg(argumentList, WKBlockAlertItem *))) {
                [buttonsArray addObject: eachItem];
            }
            va_end(argumentList);
        }
        
        for (WKBlockAlertItem *item in buttonsArray){
            [self addButtonWithTitle:item.title];
        }
        
        if (inCancelButtonItem) {
            [buttonsArray insertObject:inCancelButtonItem atIndex:0];
        }
        
        objc_setAssociatedObject(self,
                                 (__bridge const void *)WKAlert_BUTTON_ASS_KEY,
                                 buttonsArray,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex >= 0) {
        NSArray *buttonsArray =
        objc_getAssociatedObject(self,
                                 (__bridge const void *)WKAlert_BUTTON_ASS_KEY);
        WKBlockAlertItem *item = [buttonsArray objectAtIndex:buttonIndex];
        if (item.action) {
            item.action();
        }
    }
    
    objc_setAssociatedObject(self,
                             (__bridge const void *)WKAlert_BUTTON_ASS_KEY,
                             nil,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end





