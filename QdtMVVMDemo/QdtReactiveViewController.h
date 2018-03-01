//
//  QdtReactiveViewController.h
//  Pointer
//
//  Created by qiuzijie on 2017/12/3.
//  Copyright © 2017年 GM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QdtBaseVM.h"

@protocol QdtReactiveViewController <NSObject>
@required
- (instancetype)initWithViewModel:(QdtBaseVM *)viewModel;
@end
