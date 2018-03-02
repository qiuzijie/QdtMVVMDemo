//
//  QdtNetworkingUtility.m
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/2/28.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import "QdtNetworkingUtility.h"

@implementation QdtNetworkingUtility

- (RACSignal *)fetchEmployeeListSignalWithInput:(NSDictionary *)input{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self requestAPIMethod:@"FetchEmployeeList" arguments:input completionHandler:^(NSError *error, id result) {
            if (error) {
                [subscriber sendError:error];
            } else {
                NSMutableArray *datas = [NSMutableArray new];
                for (NSInteger i = 0; i <= 20; i++) {
                    QdtEmployeeModel *user = [QdtEmployeeModel new];
                    user.userName = [NSString stringWithFormat:@"XXX %ld 号",i];
                    user.iconName = @"z";
                    [datas addObject:user];
                }
                [subscriber sendNext:[datas copy]];
                [subscriber sendCompleted];
            };
        }];
        return nil;
    }];
}

- (RACSignal *)fetchApproverListSignalWithInput:(NSDictionary *)input{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self requestAPIMethod:@"FetchApproverList" arguments:input completionHandler:^(NSError *error, id result) {
            if (error) {
                [subscriber sendError:error];
            } else {
                NSMutableArray *datas = [NSMutableArray new];
                for (NSInteger i = 0; i <= 20; i++) {
                    QdtApproverModel *user = [QdtApproverModel new];
                    user.userName = [NSString stringWithFormat:@"XXX %ld 号",i];
                    user.iconName = @"weige";
                    [datas addObject:user];
                }
                [subscriber sendNext:[datas copy]];
                [subscriber sendCompleted];
            };
        }];
        return nil;
    }];
}

- (RACSignal *)fetchPrincipalListSignalWithInput:(NSDictionary *)input{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self requestAPIMethod:@"FetchPrincipalList" arguments:input completionHandler:^(NSError *error, id result) {
            if (error) {
                [subscriber sendError:error];
            } else {
                NSMutableArray *datas = [NSMutableArray new];
                for (NSInteger i = 0; i <= 20; i++) {
                    QdtPrincipalModel *user = [QdtPrincipalModel new];
                    user.userName = [NSString stringWithFormat:@"XXX %ld 号",i];
                    user.iconName = @"genshuo";
                    [datas addObject:user];
                }
                [subscriber sendNext:[datas copy]];
                [subscriber sendCompleted];
            };
        }];
        return nil;
    }];
}

- (RACSignal *)fetchUserListSignalWithInput:(NSDictionary *)input{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self requestAPIMethod:@"获取用户列表" arguments:input completionHandler:^(NSError *error, id result) {
            if (error) {
                [subscriber sendError:error];
            } else {
                NSMutableArray *datas = [NSMutableArray new];
                NSInteger page = [[input objectForKey:@"page"] integerValue];
                NSString *query = [input objectForKey:@"query"];
                for (NSInteger i = (page-1)*10+1; i <= page*10; i++) {
                    QdtUserModel *user = [QdtUserModel new];
                    if (query.length > 0) {
                        user.userName = [NSString stringWithFormat:@"%@ %ld 号",query,i];
                    } else {
                        user.userName = [NSString stringWithFormat:@"XXX %ld 号",i];
                    }
                    [datas addObject:user];
                }
                QdtUserListReceiveModel *model = [QdtUserListReceiveModel new];
                model.users = [datas copy];
                model.hasNext = (page < 3 && query.length == 0) ? YES : NO;
                [subscriber sendNext:model];
                [subscriber sendCompleted];
            };
        }];
        return nil;
    }];
}

- (RACSignal *)likeUserSignalWithInput:(NSDictionary *)input{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self requestAPIMethod:@"点赞用户" arguments:input completionHandler:^(NSError *error, id result) {
            if (error) {
                [subscriber sendError:error];
            } else {
                BOOL isLike = [input[@"isLike"] boolValue];;
                [subscriber sendNext:@(!isLike)];
                [subscriber sendCompleted];
            };
        }];
        return nil;
    }];
}

- (RACSignal *)followUserSignalWithInput:(NSDictionary *)input{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self requestAPIMethod:@"关注用户" arguments:input completionHandler:^(NSError *error, id result) {
            if (error) {
                [subscriber sendError:error];
            } else {
                BOOL isFollow = [input[@"isFollow"] boolValue];
                [subscriber sendNext:@(!isFollow)];
                [subscriber sendCompleted];
            };
        }];
        return nil;
    }];
}

- (void)requestAPIMethod:(NSString *)method arguments:(NSDictionary *)args completionHandler:(NetworkCompletionHandler)completionHandler{
    [[RACScheduler scheduler] afterDelay:2 schedule:^{
        if (completionHandler) {
            completionHandler(nil,nil);
        };
    }];
}

@end
