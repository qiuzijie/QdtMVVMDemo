//
//  QdtUserListReceiveModel.h
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/2/28.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QdtUserModel.h"

@interface QdtUserListReceiveModel : NSObject
@property (nonatomic, assign) BOOL hasNext;
@property (nonatomic, strong) NSArray<QdtUserModel *> *users;
@end
