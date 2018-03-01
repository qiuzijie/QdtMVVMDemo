//
//  QdtUserCellViewModel.m
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/2/28.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import "QdtUserCellViewModel.h"

@interface QdtUserCellViewModel ()
@property (nonatomic, strong, readwrite) QdtUserModel *user;
@property (nonatomic, copy  , readwrite) NSString *userName;
@property (nonatomic, copy  , readwrite) NSString *likeText;
@property (nonatomic, copy  , readwrite) NSString *followText;
@property (nonatomic, strong, readwrite) UIColor *likeButtonColor;
@property (nonatomic, strong, readwrite) UIColor *followButtonColor;
@property (nonatomic, strong, readwrite) RACCommand *likeCommand;
@property (nonatomic, strong, readwrite) RACCommand *followCommand;
@end


@implementation QdtUserCellViewModel

+ (instancetype)viewModelWithUserModel:(QdtUserModel *)user{
    return [[QdtUserCellViewModel alloc] initWithUserModel:user];
}

- (instancetype)initWithUserModel:(QdtUserModel *)user{
    self = [super init];
    if (self) {
        _user = user;
        _userName = user.userName;
        [self bindModel];
    }
    return self;
}

- (void)bindModel{
    [[RACObserve(self, user.like) distinctUntilChanged] subscribeNext:^(NSNumber *value) {
        if (value.boolValue) {
            self.likeText = @"Dislike";
            self.likeButtonColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
        } else {
            self.likeText = @"Like";
            self.likeButtonColor = [UIColor colorWithRed:243/255.0 green:185/255.0 blue:93/255.0 alpha:1];
        };
    }];
    
    [[RACObserve(self, user.follow) distinctUntilChanged] subscribeNext:^(NSNumber *value) {
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
- (RACCommand *)likeCommand{
    if (!_likeCommand) {
        _likeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[RACScheduler scheduler] afterDelay:2 schedule:^{
                    self.user.like = !self.user.like;
                    self.likeText = self.user.like ? @"Dislike":@"Like";
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _likeCommand;
}


@end












