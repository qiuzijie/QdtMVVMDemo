//
//  QdtTransformersBodyView.m
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/3/2.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import "QdtTransformersBodyView.h"

@interface QdtTransformersBodyView ()

@end

@implementation QdtTransformersBodyView

- (instancetype)initWithViewModel:(QdtTransformersBodyViewModel *)viewModel{
    self = [super init];
    if (self) {
        _viewModel = viewModel;
        [self bindViewModel];
    }
    return self;
}

- (void)bindViewModel{
    [self.viewModel.fetchBodyInfoCommand.executing subscribeNext:^(NSNumber *value) {
        if (!value.boolValue) {
            self.backgroundColor = [UIColor blueColor];
        } else {
            self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        };
    }];
}

@end
