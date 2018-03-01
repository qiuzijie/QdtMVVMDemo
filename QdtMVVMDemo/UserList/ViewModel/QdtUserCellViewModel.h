//
//  QdtUserCellViewModel.h
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/2/28.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QdtUserModel.h"

@interface QdtUserCellViewModel : NSObject
@property (nonatomic, strong, readonly) QdtUserModel *user;
@property (nonatomic, copy  , readonly) NSString *userName;
@property (nonatomic, copy  , readonly) NSString *likeText;
@property (nonatomic, copy  , readonly) NSString *followText;
@property (nonatomic, strong, readonly) UIColor *likeButtonColor;
@property (nonatomic, strong, readonly) UIColor *followButtonColor;
@property (nonatomic, strong, readonly) RACCommand *likeCommand;
@property (nonatomic, strong, readonly) RACCommand *followCommand;

+ (instancetype)viewModelWithUserModel:(QdtUserModel *)user;

@end
