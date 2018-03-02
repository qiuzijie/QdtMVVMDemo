//
//  QdtEmployeeModel.h
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/3/2.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QdtEmployeeModel : NSObject
@property (nonatomic, copy  ) NSString *iconName;
@property (nonatomic, assign) NSInteger userID;
@property (nonatomic, copy  ) NSString *userName;
@property (nonatomic, assign) BOOL like;
@property (nonatomic, assign) BOOL follow;
@end
