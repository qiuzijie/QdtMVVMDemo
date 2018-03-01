//
//  UIImage+QdtMethods.m
//  Pointer
//
//  Created by Qin Yuxiang on 4/21/16.
//  Copyright © 2016 GM. All rights reserved.
//

#import "UIImage+QdtMethods.h"
#import <objc/runtime.h>

@implementation UIImage (QdtMethods)

- (void)setFilePath:(NSString *)filePath {
     objc_setAssociatedObject(self
                             ,@"filePath"
                             ,filePath
                             ,OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString*)filePath {
    return objc_getAssociatedObject(self, @"filePath");
}

+ (UIImage*)qdt_ImageWithContentsOfFile:(NSString *)path {
    UIImage *img = [UIImage imageWithContentsOfFile:path];
    img.filePath = path;
    return img;
}

+ (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
