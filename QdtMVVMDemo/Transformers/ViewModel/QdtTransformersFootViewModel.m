//
//  QdtTransformersFootViewModel.m
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/3/2.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import "QdtTransformersFootViewModel.h"

@implementation QdtTransformersFootViewModel

- (instancetype)initWithID:(NSInteger)ID{
    return [super init];
}

- (RACCommand *)fetchFootInfoCommand{
    if (!_fetchFootInfoCommand) {
        _fetchFootInfoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[RACScheduler scheduler] afterDelay:1.5 schedule:^{
                    NSMutableArray *array = [NSMutableArray new];
                    for (NSInteger i = 0; i < 20; i++) {
                        [array addObject:[NSString stringWithFormat:@"xxxx___%ld 号",i]];
                    };
                    self.datas = [array copy];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _fetchFootInfoCommand;
}
@end
