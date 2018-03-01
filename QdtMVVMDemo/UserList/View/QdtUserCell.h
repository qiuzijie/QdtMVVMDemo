//
//  QdtUserCell.h
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/2/28.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QdtReactiveView.h"
#import "QdtUserCellViewModel.h"

typedef void(^QdtUserCellBlock)(void);
@interface QdtUserCell : UITableViewCell<QdtReactiveView>
@property (nonatomic, strong) QdtUserCellViewModel *viewModel;
@property (nonatomic, strong) QdtUserCellBlock followBlock;
@end
