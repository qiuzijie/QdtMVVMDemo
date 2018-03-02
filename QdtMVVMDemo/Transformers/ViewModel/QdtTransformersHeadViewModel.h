//
//  QdtTransformersHeadViewModel.h
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/3/2.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QdtTransformersHeadViewModel : NSObject
@property (nonatomic, strong) RACCommand *fetchHeadInfoCommand;
- (instancetype)initWithID:(NSInteger)ID;
@end
