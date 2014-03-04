//
//  UIImage+FGTAdditions.h
//  BOCMPCI
//
//  Created by TracyYih on 13-11-19.
//  Copyright (c) 2013年 ChinaMWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FGTAdditions)

- (UIImage *)fgt_imageScaledToSize:(CGSize)size;

- (UIImage *)fgt_asTemplate;

+ (UIImage *)fgt_imageWithColor:(UIColor *)color size:(CGSize)size;

@end
