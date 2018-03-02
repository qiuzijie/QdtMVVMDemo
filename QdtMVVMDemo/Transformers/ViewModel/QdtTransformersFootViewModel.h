//
//  QdtTransformersFootViewModel.h
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/3/2.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QdtTransformersFootViewModel : NSObject
@property (nonatomic, strong) RACCommand *fetchFootInfoCommand;
@property (nonatomic, strong) NSArray<NSString *> *datas;
- (instancetype)initWithID:(NSInteger)ID;
@end
