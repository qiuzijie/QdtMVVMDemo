//
//  QdtNetworkingUtility.h
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/2/28.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QdtUserListReceiveModel.h"
#import "QdtEmployeeModel.h"
#import "QdtApproverModel.h"
#import "QdtPrincipalModel.h"

typedef void(^NetworkCompletionHandler)(NSError *error, id result);
@interface QdtNetworkingUtility : NSObject
- (RACSignal *)fetchUserListSignalWithInput:(NSDictionary *)input;
- (RACSignal *)fetchEmployeeListSignalWithInput:(NSDictionary *)input;
- (RACSignal *)fetchApproverListSignalWithInput:(NSDictionary *)input;
- (RACSignal *)fetchPrincipalListSignalWithInput:(NSDictionary *)input;
- (RACSignal *)likeUserSignalWithInput:(NSDictionary *)input;
- (RACSignal *)followUserSignalWithInput:(NSDictionary *)input;
@end
