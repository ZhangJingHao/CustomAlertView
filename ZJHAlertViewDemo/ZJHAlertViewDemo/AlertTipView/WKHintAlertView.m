//
//  WKHintAlertView.m
//  AppMarket
//
//  Created by ZhangJingHao2345 on 2016/12/29.
//  Copyright © 2016年 2345 Co., Ltd. All rights reserved.
//

#import "WKHintAlertView.h"
#import "NSString+Codec.h"

@interface WKHintAlertView ()

@property (nonatomic, weak, readwrite) UILabel *label;
@property (nonatomic, weak, readwrite) UIImageView *iconView;

@end

@implementation WKHintAlertView

- (instancetype)initWithView:(UIView *)view {
    self = [super initWithView:view];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:iconView];
    _iconView = iconView;
    
    UILabel *label = [UILabel new];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"HelveticaNeue"
                                 size:SCREEN_MY_WIDTH(15)];
    label.textColor = [UIColor whiteColor];
    [self.contentView addSubview:label];
    _label = label;
    
    self.contentView.backgroundColor = [UIColor colorWithWhite:0
                                                         alpha:0.7];
}

- (void)showWithAnimated:(BOOL)animated {
    _label.hidden = _hintType == WKHintAlertTypeIcon;
    _iconView.hidden = _hintType == WKHintAlertTypeText;
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat contentW = 0;
    CGFloat contentH = 0;
    CGFloat distance = SCREEN_MY_WIDTH(15);
    
    CGFloat iconW = _iconView.image.size.width;
    CGFloat iconH = _iconView.image.size.height;
    if (iconW > width) {
        CGFloat rate = iconH / iconW;
        iconW = width * 0.7;
        iconH = iconW * rate;
    }
    
    CGFloat labH = SCREEN_MY_WIDTH(50);
    CGFloat labW = width * 0.8;
    CGSize size = [_label.text getSizeWithFontSize:_label.font
                                         maxHeight:labH];
    if (size.width > 0 && size.width < labW) {
        labW = size.width;
    }
    
    if (_hintType == WKHintAlertTypeText) {
        contentW = labW + distance * 2;
        contentH = labH;
        CGFloat labX = (contentW - labW) / 2;
        _label.frame =  CGRectMake(labX, 0, labW, labH);
    } else if (_hintType == WKHintAlertTypeIcon) {
        contentH = iconH + distance * 2;
        contentW = iconW + distance * 2;
        CGFloat iconX = (contentW - iconW) / 2;
        CGFloat iconY = (contentH - iconH) / 2;
        _iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    } else {
        if (labW > iconW) {
            contentW = labW + distance * 2;
        } else {
            contentW = iconW + distance * 2;
        }
        CGFloat iconY = distance;
        CGFloat labY = iconY + iconH ;
        contentH = labY + labH ;
        CGFloat labX = (contentW - labW) / 2;
        CGFloat iconX = (contentW - iconW) / 2;
        _iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
        _label.frame = CGRectMake(labX, labY, labW, labH);
    }

    self.contentView.layer.cornerRadius = contentH * 0.1;
    CGFloat contentX = (width - contentW) / 2;
    CGFloat contentY = (height - contentH) / 2;
    self.contentView.frame = CGRectMake(contentX, contentY, contentW, contentH);
    [super showWithAnimated:animated];
}

@end
