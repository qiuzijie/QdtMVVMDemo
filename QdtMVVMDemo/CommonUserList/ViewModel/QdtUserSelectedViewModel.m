//
//  QdtUserSelectedViewModel.m
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/3/1.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import "QdtUserSelectedViewModel.h"

@interface QdtUserSelectedViewModel ()

@end

@interface QdtEmployeeSelectedViewModel : QdtUserSelectedViewModel
- (instancetype)initWithEmployeeID:(NSInteger)employeeID;
@end

@implementation QdtEmployeeSelectedViewModel

- (instancetype)initWithEmployeeID:(NSInteger)employeeID{
    self = [super init];
    if (self) {
        @weakify(self);
        self.title = @"EmployeeList";
        self.fetchUserListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [[[QdtNetworkingUtility new] fetchEmployeeListSignalWithInput:nil] doNext:^(NSArray *datas) {
                self.userViewModels = [datas.rac_sequence map:^id(QdtEmployeeModel *value) {
                    return [QdtUserCellViewModel employeeViewModelWithEmployeeModel:value];
                }].array;
            }];
        }];
    }
    return self;
}
@end

@interface QdtApproverSelectedViewModel : QdtUserSelectedViewModel
- (instancetype)initWithApproverID:(NSInteger)approverID;
@end

@implementation QdtApproverSelectedViewModel

- (instancetype)initWithApproverID:(NSInteger)approverID{
    self = [super init];
    if (self) {
        @weakify(self);
        self.title = @"ApproverList";
        self.fetchUserListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [[[QdtNetworkingUtility new] fetchApproverListSignalWithInput:nil] doNext:^(NSArray *datas) {
                self.userViewModels = [datas.rac_sequence map:^id(QdtApproverModel *value) {
                    return [QdtUserCellViewModel approverViewModelWithApproverModel:value];
                }].array;
            }];
        }];
    }
    return self;
}
@end

@interface QdtPrincipalSelectedViewModel : QdtUserSelectedViewModel
- (instancetype)initWithPrincipals:(NSArray *)principals;
@end

@implementation QdtPrincipalSelectedViewModel

- (instancetype)initWithPrincipals:(NSArray *)principals{
    self = [super init];
    if (self) {
        self.title = @"PrincipalList";
        self.userViewModels = [principals.rac_sequence map:^id(QdtPrincipalModel *value) {
            return [QdtUserCellViewModel principalViewModelWithPrincipalModel:value];
        }].array;
    }
    return self;
}
@end


@implementation QdtUserSelectedViewModel

+ (instancetype)viewModelOfEmployeeID:(NSInteger)employeeID{
    return [[QdtEmployeeSelectedViewModel alloc] initWithEmployeeID:employeeID];
}

+ (instancetype)viewModelOfApproverID:(NSInteger)approverID{
    return [[QdtApproverSelectedViewModel alloc] initWithApproverID:approverID];
}

+ (instancetype)viewModelOfPrincipals:(NSArray *)principals{
    return [[QdtPrincipalSelectedViewModel alloc] initWithPrincipals:principals];
}

@end
