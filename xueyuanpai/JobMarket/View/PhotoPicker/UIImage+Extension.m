//
//  UIImage+Extension.m
//  PhotoPicker
//
//  Created by yangtao on 3/1/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
- (UIImage*)imageWithScale:(CGFloat)width {

    CGFloat height = width * self.size.height / self.size.width;
    CGSize currentSize = CGSizeMake(width, height);
    UIGraphicsBeginImageContext(currentSize);

    [self drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
