//
//  QdtTransformersFootView.h
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/3/2.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QdtTransformersFootViewModel.h"

@interface QdtTransformersFootView : UIView
@property (nonatomic, strong) QdtTransformersFootViewModel *viewModel;
- (instancetype)initWithViewModel:(QdtTransformersFootViewModel *)viewModel;
@end
