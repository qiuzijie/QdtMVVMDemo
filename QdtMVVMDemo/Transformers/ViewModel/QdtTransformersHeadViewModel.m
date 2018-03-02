//
//  QdtTransformersHeadViewModel.m
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/3/2.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import "QdtTransformersHeadViewModel.h"

@implementation QdtTransformersHeadViewModel

- (instancetype)initWithID:(NSInteger)ID{
    return [super init];
}

- (RACCommand *)fetchHeadInfoCommand{
    if (!_fetchHeadInfoCommand) {
        _fetchHeadInfoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[RACScheduler scheduler] afterDelay:1 schedule:^{
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _fetchHeadInfoCommand;
}
@end
