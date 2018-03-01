//
//  QdtNetworkingUtility.h
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/2/28.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QdtNetworkingUtility : NSObject
- (RACSignal *)postSignalFromAPIMethod:(NSString *)method arguments:(NSDictionary *)args;
@end
