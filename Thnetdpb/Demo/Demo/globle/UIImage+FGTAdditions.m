//
//  UIImage+FGTAdditions.m
//  BOCMPCI
//
//  Created by TracyYih on 13-11-19.
//  Copyright (c) 2013年 ChinaMWorld. All rights reserved.
//

#import "UIImage+FGTAdditions.h"
#import "MBConstant.h"
@implementation UIImage (FGTAdditions)

- (UIImage *)fgt_imageScaledToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)fgt_asTemplate
{
    if (IOS7_OR_LATER) {
        return [self imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    return self;
}

+ (UIImage *)fgt_imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:0];
    path.lineWidth = 0;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [color setFill];
    [path fill];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
