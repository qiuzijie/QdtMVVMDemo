//
//  QdtTransformersHeadView.m
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/3/2.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import "QdtTransformersHeadView.h"

@interface QdtTransformersHeadView ()

@end

@implementation QdtTransformersHeadView

- (instancetype)initWithViewModel:(QdtTransformersHeadViewModel *)viewModel{
    self = [super init];
    if (self) {
        _viewModel = viewModel;
        [self bindViewModel];
    }
    return self;
}

- (void)bindViewModel{
    [self.viewModel.fetchHeadInfoCommand.executing subscribeNext:^(NSNumber *value) {
        if (!value.boolValue) {
            self.backgroundColor = [UIColor orangeColor];
        } else {
            self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        };
    }];
}

@end
