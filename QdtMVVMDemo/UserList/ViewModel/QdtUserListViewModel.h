//
//  QdtUserListViewModel.h
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/2/27.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QdtUserListViewModel : NSObject

- (instancetype)initWithUserID:(NSInteger)userID;
@property (nonatomic, copy  ) NSString *searchText;
@property (nonatomic, copy  , readonly) NSString *title;
@property (nonatomic, strong, readonly) NSArray *userViewModels;
@property (nonatomic, strong, readonly) RACCommand *fetchUserListCommand;
@property (nonatomic, strong, readonly) RACCommand *searchUsersCommand;
@property (nonatomic, assign, readonly) BOOL userListHasNext;
@end
