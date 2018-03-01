//
//  UITableView+QdtDataSourceBinder.h
//  Pointer
//
//  Created by qiuzijie on 2018/2/6.
//  Copyright © 2018年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QdtTableViewDataSourceBinder.h"
/**
 用于将TableView和数据源进行绑定,仅仅实现了TableViewDataSource协议里的部分方法。
 必要条件：
 1.sourceSignal返回的数据必须为单层数组，暂不支持数组嵌套数组这种
 2.数组里包含的对象必须和TableView注册的cell的viewModel保持为同一类型
 3.TableView需要提前注册cellIdentifier,cell必须遵守QdtReactiveView协议，有个viewModel属性

 */
@interface UITableView (QdtDataSourceBinder)

- (void)bindRowSourceSignal:(RACSignal *)signal cellIdentifier:(NSString *)identifier;

- (void)bindSectionSourceSignal:(RACSignal *)signal cellIdentifier:(NSString *)identifier;

@end
