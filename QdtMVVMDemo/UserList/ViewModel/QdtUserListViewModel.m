//
//  QdtUserListViewModel.m
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/2/27.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import "QdtUserListViewModel.h"
#import "QdtNetworkingUtility.h"
#import "QdtUserCellViewModel.h"
#import "QdtUserListReceiveModel.h"

@interface QdtUserListViewModel ()
@property (nonatomic, strong, readwrite) NSArray *userViewModels;
@property (nonatomic, strong, readwrite) RACCommand *fetchUserListCommand;
@property (nonatomic, strong, readwrite) RACCommand *searchUsersCommand;
@property (nonatomic, assign, readwrite) BOOL userListHasNext;
@property (nonatomic, assign) NSInteger listPage;
@property (nonatomic, assign) NSInteger userID;
@end


@implementation QdtUserListViewModel

- (instancetype)initWithUserID:(NSInteger)userID{
    self = [super init];
    if (self) {
        _userID = userID;
    }
    return self;
}

#pragma mark- getter / setter

- (RACCommand *)fetchUserListCommand{
    if (!_fetchUserListCommand) {
        _fetchUserListCommand = [[RACCommand alloc] initWithEnabled:nil signalBlock:^RACSignal *(NSNumber *isLoadMore) {
            if (isLoadMore && isLoadMore.boolValue) {//上拉加载
                self.listPage ++;
            } else {
                self.listPage = 1;
            }
            return [self signalOfFetchUserListWithUserID:self.userID page:self.listPage searchText:self.searchText];
        }];
    }
    return _fetchUserListCommand;
}

- (RACSignal *)signalOfFetchUserListWithUserID:(NSInteger)userID page:(NSInteger)page searchText:(NSString *)searchText{
    @weakify(self);
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"userID":@(userID),@"page":@(page)}];
    [dic setValue:searchText forKey:@"query"];
    RACSignal *signal = [[[QdtNetworkingUtility new] postSignalFromAPIMethod:@"获取用户列表" arguments:dic] doNext:^(QdtUserListReceiveModel *res) {
        @strongify(self);
        NSArray *array = [res.users.rac_sequence map:^id(QdtUserModel *value) {
            return [QdtUserCellViewModel viewModelWithUserModel:value];
        }].array;
        if (page == 1) {
            self.userViewModels = array;
        } else {
            NSMutableArray *mutArray = [NSMutableArray arrayWithArray:self.userViewModels];
            [mutArray addObjectsFromArray:array];
            self.userViewModels = [mutArray copy];
        }
        self.userListHasNext = res.hasNext;
    }];
    return signal;
}

- (RACCommand *)searchUsersCommand{
    if (!_searchUsersCommand) {
        _searchUsersCommand = [[RACCommand alloc] initWithEnabled:[self signalOfSearchCommandEnabled] signalBlock:^RACSignal *(id input) {
            self.listPage = 1;
            return [self signalOfFetchUserListWithUserID:self.userID page:self.listPage searchText:self.searchText];
        }];
    }
    return _searchUsersCommand;
}

- (RACSignal *)signalOfSearchCommandEnabled{
    return [RACObserve(self, searchText) map:^id(NSString *value) {
        return @(value.length > 0);
    }];
}

@end









