//
//  UIImage+QdtMethods.h
//  Pointer
//
//  Created by Qin Yuxiang on 4/21/16.
//  Copyright © 2016 GM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QdtMethods)

@property (copy, nonatomic) NSString *filePath;

+ (UIImage *)qdt_ImageWithContentsOfFile:(NSString *)path;

+ (UIImage *)imageWithColor:(UIColor *)color;

@end
