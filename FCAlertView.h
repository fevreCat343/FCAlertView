//
//  FCAlertView.h
//  gitDemo
//
//  Created by John on 15/12/9.
//  Copyright © 2015年 FeverCat. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^Complation)();
typedef void (^Begin)();

@interface FCAlertView : UIView
/**
 *  显示提示
 *
 *  @param view 在view上展示
 */
- (void)showOnView:(UIView *)view;
/**
 *  显示提示N秒
 *
 *  @param view     在view上展示
 *  @param duration 显示秒数
 */
- (void)showOnView:(UIView *)view forTime:(CGFloat)duration;
/**
 *  显示提示
 *
 *  @param view       在view上展示
 *  @param begin      开始时回调
 *  @param completion 结束后回调
 */
- (void)showOnView:(UIView *)view begin:(Begin)begin completion:(Complation)completion;

/**
 *  初始化 提示框
 *
 *  @param content 提示内容
 *
 *  @return 提示框
 */
- (instancetype)initWithAlertContent:(NSString *)content;
/**
 *  初始化 提示框
 *
 *  @param content         显示内容
 *  @param textColor       显示字体颜色
 *  @param backgroundColor 显示北京颜色
 *
 *  @return 提示框
 */
- (instancetype)initWithAlertContent:(NSString *)content
                           textColor:(UIColor *)textColor
                     backgroundColor:(UIColor *)backgroundColor;
@end
