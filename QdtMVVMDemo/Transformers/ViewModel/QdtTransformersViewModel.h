//
//  QdtTransformersViewModel.h
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/3/2.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QdtTransformersHeadViewModel.h"
#import "QdtTransformersArmViewModel.h"
#import "QdtTransformersBodyViewModel.h"
#import "QdtTransformersFootViewModel.h"

@interface QdtTransformersViewModel : NSObject

- (instancetype)initWithHeadID:(NSInteger)head armID:(NSInteger)arm bodyID:(NSInteger)body footID:(NSInteger)foot;

@property (nonatomic, strong, readonly) QdtTransformersHeadViewModel *headViewModel;
@property (nonatomic, strong, readonly) QdtTransformersArmViewModel  *armViewModel;
@property (nonatomic, strong, readonly) QdtTransformersBodyViewModel *bodyViewModel;
@property (nonatomic, strong, readonly) QdtTransformersFootViewModel *footViewModel;
@property (nonatomic, strong, readonly) RACSignal *fetchZipSignal;

@end
