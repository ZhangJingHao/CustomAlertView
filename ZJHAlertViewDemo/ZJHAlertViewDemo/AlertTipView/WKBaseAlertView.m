//
//  WKBaseAlertView.m
//  WuKongAppStore
//
//  Created by ZhangJingHao2345 on 2017/3/20.
//  Copyright © 2017年 Shanghai 2345 Co., Ltd. All rights reserved.
//

#import "WKBaseAlertView.h"

@interface WKBaseAlertView ()

@property (nonatomic, strong) NSTimer *hideDelayTimer;

@end

@implementation WKBaseAlertView

- (instancetype)initWithView:(UIView *)view {
    self = [super initWithFrame:view.bounds];
    if (self) {
        UIView *contentView = [UIView new];
        contentView.layer.cornerRadius = SCREEN_MY_WIDTH(10);
        contentView.layer.masksToBounds = YES;
        contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:contentView];
        _contentView = contentView;
        [view addSubview:self];
        
        _removeFromSuperViewOnHide = YES;
    }
    return self;
}

- (void)showWithAnimated:(BOOL)animated {
    self.alpha = 1;
    self.hidden = NO;
    if (!animated) {
        return;
    }
    _contentView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [UIView animateWithDuration:0.22
                          delay:0
         usingSpringWithDamping:0.55
          initialSpringVelocity:10
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         _contentView.transform = CGAffineTransformIdentity;
                         if (_isShowBackCover) {
                             self.backgroundColor = [UIColor colorWithWhite:0
                                                                      alpha:0.35];
                         }
                     }
                     completion:nil];
}

- (void)hideAnimated:(BOOL)animated {
    void (^completion)(BOOL finished) = ^(BOOL finished){
        if (_removeFromSuperViewOnHide) {
            [self removeFromSuperview];
        } else {
            self.hidden = YES;
        }
        [_hideDelayTimer invalidate];
        _hideDelayTimer = nil;
    };
    
    if (animated) {
        [UIView animateWithDuration:0.15 animations:^{
            self.alpha = 0;
        } completion:completion];
    } else {
        completion(YES);
    }
}

- (void)hideAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay {
    if (_hideDelayTimer) {
        [_hideDelayTimer invalidate];
        _hideDelayTimer = nil;
    }
    _hideDelayTimer = [NSTimer timerWithTimeInterval:delay
                                             target:self
                                           selector:@selector(handleHideTimer:)
                                           userInfo:@(animated)
                                            repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:_hideDelayTimer
                                 forMode:NSRunLoopCommonModes];
}

- (void)handleHideTimer:(NSTimer *)timer {
    [self hideAnimated:[timer.userInfo boolValue]];
}

- (void)dealloc {
    [_hideDelayTimer invalidate];
    _hideDelayTimer = nil;
    
//    DebugLog(@"%@",self);
}

@end
