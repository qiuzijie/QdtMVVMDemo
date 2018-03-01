//
//  QdtNetworkingUtility.m
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/2/28.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import "QdtNetworkingUtility.h"
#import "QdtUserListReceiveModel.h"

@implementation QdtNetworkingUtility

- (RACSignal *)postSignalFromAPIMethod:(NSString *)method arguments:(NSDictionary *)args{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //模拟网络请求
        [[RACScheduler scheduler] afterDelay:2 schedule:^{
            NSMutableArray *datas = [NSMutableArray new];
            NSInteger page = [[args objectForKey:@"page"] integerValue];
            NSString *query = [args objectForKey:@"query"];
            for (NSInteger i = (page-1)*10+1; i <= page*10; i++) {
                QdtUserModel *user = [QdtUserModel new];
                if (query.length > 0) {
                    user.userName = [NSString stringWithFormat:@"%@ %ld 号",query,i];
                } else {
                    user.userName = [NSString stringWithFormat:@"用户 %ld 号",i];
                }
                [datas addObject:user];
            }
            QdtUserListReceiveModel *model = [QdtUserListReceiveModel new];
            model.users = [datas copy];
            model.hasNext = (page < 3 && query.length == 0) ? YES : NO;
            [subscriber sendNext:model];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}

@end
