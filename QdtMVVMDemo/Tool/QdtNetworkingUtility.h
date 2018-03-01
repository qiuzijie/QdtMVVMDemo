//
//  QdtNetworkingUtility.h
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/2/28.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^NetworkCompletionHandler)(NSError *error, id result);
@interface QdtNetworkingUtility : NSObject
- (RACSignal *)fetchUserListSignalWithInput:(NSDictionary *)input;
- (RACSignal *)likeUserSignalWithInput:(NSDictionary *)input;
- (RACSignal *)followUserSignalWithInput:(NSDictionary *)input;
@end
