//
//  QdtTransformersArmView.m
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/3/2.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import "QdtTransformersArmView.h"

@interface QdtTransformersArmView ()

@end

@implementation QdtTransformersArmView

- (instancetype)initWithViewModel:(QdtTransformersArmViewModel *)viewModel{
    self = [super init];
    if (self) {
        _viewModel = viewModel;
        [self bindViewModel];
    }
    return self;
}

- (void)bindViewModel{
    [self.viewModel.fetchArmInfoCommand.executing subscribeNext:^(NSNumber *value) {
        if (!value.boolValue) {
            self.backgroundColor = [UIColor brownColor];
        } else {
            self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        };
    }];
    
    [[self.viewModel.fetchArmInfoCommand.executionSignals.switchToLatest deliverOnMainThread] subscribeNext:^(id x) {
        if (self.hideBlock) {
            self.hideBlock();
        };
    }];
}

@end
