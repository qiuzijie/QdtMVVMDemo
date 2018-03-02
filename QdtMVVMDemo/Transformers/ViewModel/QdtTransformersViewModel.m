//
//  QdtTransformersViewModel.m
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/3/2.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import "QdtTransformersViewModel.h"

@interface QdtTransformersViewModel ()

@property (nonatomic, strong, readwrite) QdtTransformersHeadViewModel *headViewModel;
@property (nonatomic, strong, readwrite) QdtTransformersArmViewModel  *armViewModel;
@property (nonatomic, strong, readwrite) QdtTransformersBodyViewModel *bodyViewModel;
@property (nonatomic, strong, readwrite) QdtTransformersFootViewModel *footViewModel;
@property (nonatomic, strong, readwrite) RACSignal *fetchZipSignal;

@end

@implementation QdtTransformersViewModel

- (instancetype)initWithHeadID:(NSInteger)head armID:(NSInteger)arm bodyID:(NSInteger)body footID:(NSInteger)foot{
    self = [super init];
    if (self) {
        self.headViewModel = [[QdtTransformersHeadViewModel alloc] initWithID:head];
        self.armViewModel  = [[QdtTransformersArmViewModel alloc] initWithID:arm];
        self.bodyViewModel = [[QdtTransformersBodyViewModel alloc] initWithID:body];
        self.footViewModel = [[QdtTransformersFootViewModel alloc] initWithID:foot];
        
        self.fetchZipSignal = [RACSignal zip:@[self.headViewModel.fetchHeadInfoCommand.executing,
                                               self.armViewModel.fetchArmInfoCommand.executing,
                                               self.bodyViewModel.fetchBodyInfoCommand.executing,
                                               self.footViewModel.fetchFootInfoCommand.executing]];

    }
    return self;
}



@end
