//
//  WKTipAlertView.m
//  WuKongAppStore
//
//  Created by ZhangJingHao2345 on 2017/3/23.
//  Copyright © 2017年 Shanghai 2345 Co., Ltd. All rights reserved.
//

#import "WKTipAlertView.h"
#import "UIImage+AMHelper.h"
#import "NSString+Codec.h"

@interface WKTipAlertView ()

@property (nonatomic, weak, readwrite) UILabel *nameLab;
@property (nonatomic, weak, readwrite) UILabel *contentLab;
@property (nonatomic, weak, readwrite) UIButton *button;
@property (nonatomic, weak, readwrite) UIView *lineView;

@end

@implementation WKTipAlertView

- (instancetype)initWithView:(UIView *)view {
    self = [super initWithView:view];
    if (self) {
        self.isShowBackCover = YES;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UILabel *nameLab = [UILabel new];
    nameLab.textAlignment = NSTextAlignmentCenter;
    nameLab.font = [UIFont fontWithName:@"Helvetica-Bold"
                                   size:SCREEN_MY_WIDTH(18)];
    nameLab.textColor = [UIColor blackColor];
    [self.contentView addSubview:nameLab];
    _nameLab = nameLab;
    
    UILabel *contentLab = [UILabel new];
    contentLab.textAlignment = NSTextAlignmentCenter;
    contentLab.textColor = [UIColor blackColor];
    contentLab.font = [UIFont systemFontOfSize:SCREEN_MY_WIDTH(15)];
    contentLab.numberOfLines = 0;
    [self.contentView addSubview:contentLab];
    _contentLab = contentLab;
    
    UIButton *confirmBtn = [UIButton new];
    [confirmBtn setTitle:@"确定"
                forState:UIControlStateNormal];
    [confirmBtn setBackgroundImage:[UIImage imageWithColor:RGB_Color(235, 235, 235)]
                          forState:UIControlStateHighlighted];
    [confirmBtn setTitleColor:RGB_Color(21, 126, 251)
              forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor grayColor]
                     forState:UIControlStateDisabled];
    [confirmBtn addTarget:self
                   action:@selector(clickConfirmBtn)
         forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:confirmBtn];
    _button = confirmBtn;
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    [self.contentView addSubview:lineView];
    _lineView = lineView;
}

- (void)showWithAnimated:(BOOL)animated {
    CGSize size = self.frame.size;
    CGFloat bgW = size.width * 0.75;
    CGFloat bgX = (size.width - bgW) / 2;
    
    CGFloat distance = SCREEN_MY_WIDTH(15);
    CGFloat nameW = bgW - distance * 2;
    CGFloat nameH = SCREEN_MY_WIDTH(50);
    _nameLab.frame = CGRectMake(distance, 0, nameW, nameH);
    
    CGFloat contentY = nameH + 5;
    CGFloat contentH = [_contentLab.text getSizeWithFontSize:_contentLab.font
                                                    maxWidth:nameW].height;
    _contentLab.frame = CGRectMake(distance, contentY, nameW, contentH);
    
    CGFloat lineY = contentY + contentH + distance * 1.2;
    _lineView.frame = CGRectMake(0, lineY - 1, bgW, 1);
    
    CGFloat btnH = SCREEN_MY_WIDTH(45);
    _button.frame = CGRectMake(0, lineY, bgW, btnH);
    
    CGFloat bgH = lineY + btnH;
    CGFloat bgY = (size.height - bgH) / 2;
    self.contentView.frame = CGRectMake(bgX, bgY, bgW, bgH);
    
    [super showWithAnimated:animated];
}

- (void)clickConfirmBtn {
    if (_confirmBlock) {
        _confirmBlock();
    }
    [self hideAnimated:YES];
}

@end
