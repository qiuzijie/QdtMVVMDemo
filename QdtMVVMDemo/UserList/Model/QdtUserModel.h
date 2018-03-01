//
//  QdtUserModel.h
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/2/28.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QdtUserModel : NSObject
@property (nonatomic, assign) NSInteger userID;
@property (nonatomic, copy  ) NSString *userName;
@property (nonatomic, assign) BOOL like;
@property (nonatomic, assign) BOOL follow;
@end
