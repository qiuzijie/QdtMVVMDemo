//
//  QdtTransformersArmViewModel.m
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/3/2.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import "QdtTransformersArmViewModel.h"

@implementation QdtTransformersArmViewModel

- (instancetype)initWithID:(NSInteger)ID{
    return [super init];
}

- (RACCommand *)fetchArmInfoCommand{
    if (!_fetchArmInfoCommand) {
        _fetchArmInfoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[RACScheduler scheduler] afterDelay:3 schedule:^{
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _fetchArmInfoCommand;
}
@end
