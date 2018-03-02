//
//  QdtTransformersBodyViewModel.m
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/3/2.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import "QdtTransformersBodyViewModel.h"

@implementation QdtTransformersBodyViewModel

- (instancetype)initWithID:(NSInteger)ID{
    return [super init];
}

- (RACCommand *)fetchBodyInfoCommand{
    if (!_fetchBodyInfoCommand) {
        _fetchBodyInfoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[RACScheduler scheduler] afterDelay:2 schedule:^{
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _fetchBodyInfoCommand;
}
@end
