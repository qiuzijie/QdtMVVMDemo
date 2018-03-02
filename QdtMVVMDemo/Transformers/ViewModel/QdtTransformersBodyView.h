//
//  QdtTransformersBodyView.h
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/3/2.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QdtTransformersBodyViewModel.h"

@interface QdtTransformersBodyView : UIView
@property (nonatomic, strong) QdtTransformersBodyViewModel *viewModel;
- (instancetype)initWithViewModel:(QdtTransformersBodyViewModel *)viewModel;
@end
