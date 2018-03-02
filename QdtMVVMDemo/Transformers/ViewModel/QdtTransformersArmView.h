//
//  QdtTransformersArmView.h
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/3/2.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QdtTransformersArmViewModel.h"

typedef void(^QdtTransformersArmViewHideBlock)(void);
@interface QdtTransformersArmView : UIView
@property (nonatomic, strong) QdtTransformersArmViewModel *viewModel;
@property (nonatomic, strong) QdtTransformersArmViewHideBlock hideBlock;
- (instancetype)initWithViewModel:(QdtTransformersArmViewModel *)viewModel;
@end
