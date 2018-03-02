//
//  QdtUserSelectedViewModel.h
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/3/1.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QdtUserCellViewModel.h"
#import "QdtNetworkingUtility.h"

@interface QdtUserSelectedViewModel : NSObject

+ (instancetype)viewModelOfApproverID:(NSInteger)approverID;
+ (instancetype)viewModelOfEmployeeID:(NSInteger)employeeID;
+ (instancetype)viewModelOfPrincipals:(NSArray *)principals;

@property (nonatomic, strong) NSArray<QdtUserCellViewModel *> *userViewModels;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) RACCommand *fetchUserListCommand;

@end
