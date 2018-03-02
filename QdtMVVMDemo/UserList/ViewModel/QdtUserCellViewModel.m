//
//  QdtUserCellViewModel.m
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/2/28.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import "QdtUserCellViewModel.h"


@interface QdtUserCellViewModel ()
@property (nonatomic, strong, readwrite) id user;
@property (nonatomic, copy  , readwrite) NSString *userName;
@property (nonatomic, copy  , readwrite) NSString *likeText;
@property (nonatomic, copy  , readwrite) NSString *followText;
@property (nonatomic, strong, readwrite) UIColor *likeButtonColor;
@property (nonatomic, strong, readwrite) UIColor *followButtonColor;
@property (nonatomic, strong, readwrite) RACCommand *likeCommand;
@property (nonatomic, strong, readwrite) RACCommand *followCommand;
@property (nonatomic, copy  , readwrite) UIImage *iconImage;
@property (nonatomic, assign, readwrite) BOOL operationButtonHide;
@end

@interface QdtEmployeeUserCellViewModel : QdtUserCellViewModel
- (instancetype)initWithEmployee:(QdtEmployeeModel *)employee;
@end

@implementation QdtEmployeeUserCellViewModel
- (instancetype)initWithEmployee:(QdtEmployeeModel *)employee{
    self = [super init];
    if (self) {
        self.user = employee;
        self.userName = [NSString stringWithFormat:@"Employee___%@",employee.userName];
        self.likeText = @"Like";
        self.followText = @"Follow";
        self.iconImage = [UIImage imageNamed:employee.iconName];
        self.likeButtonColor = [UIColor colorWithRed:243/255.0 green:185/255.0 blue:93/255.0 alpha:1];
        self.followButtonColor = [UIColor colorWithRed:251/255.0 green:98/255.0 blue:47/255.0 alpha:1];
    }
    return self;
}
@end

@interface QdtApproverUserCellViewModel : QdtUserCellViewModel
- (instancetype)initWithApprover:(QdtApproverModel *)approver;
@end

@implementation QdtApproverUserCellViewModel
- (instancetype)initWithApprover:(QdtApproverModel *)approver{
    self = [super init];
    if (self) {
        self.user = approver;
        self.userName = [NSString stringWithFormat:@"Approver___%@",approver.userName];
        self.likeText = @"喜  欢";
        self.followText = @"关  注";
        self.iconImage = [UIImage imageNamed:approver.iconName];
        self.likeButtonColor = [UIColor colorWithRed:243/255.0 green:185/255.0 blue:93/255.0 alpha:1];
        self.followButtonColor = [UIColor colorWithRed:251/255.0 green:98/255.0 blue:47/255.0 alpha:1];
    }
    return self;
}
@end

@interface QdtPrincipalUserCellViewModel : QdtUserCellViewModel
- (instancetype)initWithPrincipal:(QdtPrincipalModel *)principal;
@end

@implementation QdtPrincipalUserCellViewModel
- (instancetype)initWithPrincipal:(QdtPrincipalModel *)principal{
    self = [super init];
    if (self) {
        self.user = principal;
        self.userName = [NSString stringWithFormat:@"Principal___%@",principal.userName];
        self.iconImage = [UIImage imageNamed:principal.iconName];
        self.operationButtonHide = YES;
    }
    return self;
}
@end


@implementation QdtUserCellViewModel

+ (instancetype)viewModelWithUserModel:(QdtUserModel *)user{
    return [[QdtUserCellViewModel alloc] initWithUserModel:user];
}

+ (instancetype)employeeViewModelWithEmployeeModel:(QdtEmployeeModel *)user{
    return [[QdtEmployeeUserCellViewModel alloc] initWithEmployee:user];
}

+ (instancetype)approverViewModelWithApproverModel:(QdtApproverModel *)user{
    return [[QdtApproverUserCellViewModel alloc] initWithApprover:user];
}

+ (instancetype)principalViewModelWithPrincipalModel:(QdtPrincipalModel *)user{
    return [[QdtPrincipalUserCellViewModel alloc] initWithPrincipal:user];
}

- (instancetype)initWithUserModel:(QdtUserModel *)user{
    self = [super init];
    if (self) {
        _user = user;
        _userName = user.userName;
        [self bindModel:user];
        
        self.likeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            QdtUserModel *user = self.user;
            user.like = !user.like;
            return [[[QdtNetworkingUtility new] likeUserSignalWithInput:@{@"userID":@(user.userID),@"isLike":@(!user.like)}] doNext:^(NSNumber *x) {
                user.like = x.boolValue;
            }];
        }];

        self.followCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            QdtUserModel *user = self.user;
            return [[[QdtNetworkingUtility new] followUserSignalWithInput:@{@"userID":@(user.userID),@"isFollow":@(user.follow)}] doNext:^(NSNumber *x) {
                user.follow = x.boolValue;
            }];
        }];
    }
    return self;
}

- (void)bindModel:(QdtUserModel *)user{

    [[RACObserve(user, like) distinctUntilChanged] subscribeNext:^(NSNumber *value) {
        if (value.boolValue) {
            self.likeText = @"Dislike";
            self.likeButtonColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
        } else {
            self.likeText = @"Like";
            self.likeButtonColor = [UIColor colorWithRed:243/255.0 green:185/255.0 blue:93/255.0 alpha:1];
        };
    }];
    
    [[RACObserve(user, follow) distinctUntilChanged] subscribeNext:^(NSNumber *value) {
        if (value.boolValue) {
            self.followText = @"Unfollow";
            self.followButtonColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
        } else {
            self.followText = @"Follow";
            self.followButtonColor = [UIColor colorWithRed:251/255.0 green:98/255.0 blue:47/255.0 alpha:1];
        };
    }];
}

#pragma mark getter / setter
//- (RACCommand *)likeCommand{
//    if (!_likeCommand) {
//        _likeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//            QdtUserModel *user = self.user;
//            user.like = !user.like;
//            return [[[QdtNetworkingUtility new] likeUserSignalWithInput:@{@"userID":@(user.userID),@"isLike":@(!user.like)}] doNext:^(NSNumber *x) {
//                user.like = x.boolValue;
//            }];
//        }];
//    }
//    return _likeCommand;
//}
//
//- (RACCommand *)followCommand{
//    if (!_followCommand) {
//        _followCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//            QdtUserModel *user = self.user;
//            return [[[QdtNetworkingUtility new] followUserSignalWithInput:@{@"userID":@(user.userID),@"isFollow":@(user.follow)}] doNext:^(NSNumber *x) {
//                user.follow = x.boolValue;
//            }];
//        }];
//    }
//    return _followCommand;
//}

@end












