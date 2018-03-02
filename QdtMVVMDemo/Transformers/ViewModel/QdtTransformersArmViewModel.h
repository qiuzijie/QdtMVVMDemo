//
//  QdtTransformersArmViewModel.h
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/3/2.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QdtTransformersArmViewModel : NSObject
@property (nonatomic, strong) RACCommand *fetchArmInfoCommand;
- (instancetype)initWithID:(NSInteger)ID;
@end
