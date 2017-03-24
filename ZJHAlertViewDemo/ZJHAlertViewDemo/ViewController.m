//
//  ViewController.m
//  ZJHAlertViewDemo
//
//  Created by ZhangJingHao2345 on 2017/3/24.
//  Copyright © 2017年 ZhangJingHao2345. All rights reserved.
//

#import "ViewController.h"
#import "WKBlockAlertView.h"
#import "WKHintAlertView.h"
#import "WKTipAlertView.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *nameArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _nameArr = @[@"纯文字提示",
                 @"纯图片提示",
                 @"图片文字提示",
                 @"自定义Alert弹框",
                 @"UIAlertView Block 回调，适配iOS7"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIWindow *window = [self getKeyWindow];
    
    switch (indexPath.row) {
        case 0: { // 纯文字提示
            WKHintAlertView *alert = [[WKHintAlertView alloc] initWithView:window];
            alert.hintType = WKHintAlertTypeText;
            alert.label.text = @"纯文字提示";
            [alert showWithAnimated:YES];
            [alert hideAnimated:YES afterDelay:1];
        }
            break;
        case 1: { // 纯图片提示
            WKHintAlertView *alert = [[WKHintAlertView alloc] initWithView:window];
            alert.hintType = WKHintAlertTypeIcon;
            alert.iconView.image = [UIImage imageNamed:@"networkstate_wifi"];
            [alert showWithAnimated:YES];
            [alert hideAnimated:YES afterDelay:1];
        }
            break;
        case 2: { // 图片文字提示
            WKHintAlertView *alert = [[WKHintAlertView alloc] initWithView:window];
            alert.hintType = WKHintAlertTypeIconText;
            alert.label.text = @"当前为WiFi环境";
            alert.iconView.image = [UIImage imageNamed:@"networkstate_wifi"];
            [alert showWithAnimated:YES];
            [alert hideAnimated:YES afterDelay:1];
        }
            break;
        case 3: { // 自定义Alert弹框
            WKTipAlertView *alert = [[WKTipAlertView alloc] initWithView:window];
            alert.nameLab.text = @"版本检测";
            alert.contentLab.text = @"检测中，请稍后……";
            alert.button.enabled = NO;
            [alert showWithAnimated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                alert.contentLab.text = @"已是最新版本";
                alert.button.enabled = YES;
            });
            alert.confirmBlock = ^(){
                NSLog(@"点击了确定按钮");
            };
        }
            break;
        case 4: { // UIAlertView Block 回调，适配iOS7
            WKBlockAlertItem *left =
            [[WKBlockAlertItem alloc] initWithTitle:@"左边"
                                             action:^{
                                                 NSLog(@"点击了左边");
                                             }];
            WKBlockAlertItem *right =
            [[WKBlockAlertItem alloc] initWithTitle:@"右边"
                                             action:^{
                                                 NSLog(@"点击了右边");
                                             }];
            WKBlockAlertView *alert =
            [[WKBlockAlertView alloc] initWithTitle:@"我是标题"
                                            message:@"我是内容"
                                   cancelButtonItem:left
                              destructiveButtonItem:nil
                                   otherButtonItems:right,nil];
            [alert show];
        }
            break;
            
        default:
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _nameArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_Id = @"cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_Id];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cell_Id];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = _nameArr[indexPath.row];
    
    return cell;
}

- (UIWindow *)getKeyWindow {
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
            return window;
    }
    return [UIApplication sharedApplication].keyWindow;
}

@end
