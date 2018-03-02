//
//  QdtTransformersHeadView.h
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/3/2.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QdtTransformersHeadViewModel.h"

@interface QdtTransformersHeadView : UIView
@property (nonatomic, strong) QdtTransformersHeadViewModel *viewModel;
- (instancetype)initWithViewModel:(QdtTransformersHeadViewModel *)viewModel;
@end
