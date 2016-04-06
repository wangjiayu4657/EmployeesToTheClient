//
//  UIManager.m
//  Pets
//
//  Created by dengqiang on 3/31/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "UIManager.h"
#import "UIImage+Utilities.h"

@implementation UIManager

+ (UIButton *)buttonWithImage:(UIImage *)image
{
    return [self buttonWithImage:image highlightedImage:nil disabledImage:nil];
}

+ (UIButton *)buttonWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    return [self buttonWithImage:image highlightedImage:highlightedImage disabledImage:nil];
}

+ (UIButton *)buttonWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage disabledImage:(UIImage *)disabledImage
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    [button setBackgroundImage:disabledImage forState:UIControlStateDisabled];
    
    return button;
}

+ (UIButton *)buttonWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius
{
    UIButton *button = [self buttonWithColor:color size:size];
    button.layer.cornerRadius = cornerRadius;
    
    return button;
}

+ (UIButton *)buttonWithColor:(UIColor *)color size:(CGSize)size
{
    UIButton *button = [self buttonWithImage:[[UIImage imageWithColor:color] scaleToSize:size] highlightedImage:nil disabledImage:nil];
    button.layer.masksToBounds = YES;
    return button;
}

+ (UIButton *)buttonWithColor:(UIColor *)color title:(NSString *)title cornerRadius:(CGFloat)cornerRadius
{
    UIButton *button = [[UIButton alloc] init];
    button.backgroundColor = color;
    [button setTitle:title forState:UIControlStateNormal];
    button.layer.cornerRadius = cornerRadius;
    button.layer.masksToBounds = YES;
    
    return button;
}

+ (UIButton *)buttonWithColor:(UIColor *)color title:(NSString *)title
{
    return [self buttonWithColor:color title:title cornerRadius:0];
}

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    return [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
}

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
