//
//  UIManager.h
//  Pets
//
//  Created by dengqiang on 3/31/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIManager : NSObject

+ (UIButton *)buttonWithImage:(UIImage *)image;
+ (UIButton *)buttonWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage;
+ (UIButton *)buttonWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage disabledImage:(UIImage *)disabledImage;

+ (UIButton *)buttonWithColor:(UIColor *)color size:(CGSize)size;
+ (UIButton *)buttonWithColor:(UIColor *)color title:(NSString *)title;
+ (UIButton *)buttonWithColor:(UIColor *)color title:(NSString *)title cornerRadius:(CGFloat)cornerRadius;

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action;

@end
