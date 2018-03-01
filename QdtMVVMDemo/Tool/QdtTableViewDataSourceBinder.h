//
//  QdtTableViewDataSourceBinder.h
//  Pointer
//
//  Created by qiuzijie on 2017/11/21.
//  Copyright © 2017年 GM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QdtReactiveView;
@class QdtTableViewDataSourceBinder;

@protocol QdtTableViewBinderProtocol <NSObject>
@optional
- (UITableViewCell *)tableView:(UITableView *)tableView cellAtIndexPath:(NSIndexPath *)indexPath;
@end

/**
 不建议直接使用，请使用UITableView的QdtDataSourceBinder分类方法
 */
@interface QdtTableViewDataSourceBinder : NSObject<UITableViewDataSource>

@property (nonatomic, weak  ) id<QdtTableViewBinderProtocol> delegate;

/**
 将TableView和数据源进行绑定 用于单个section多row的情况
 
 @param tableView 待绑定的TableView
 @param Identifier TableView已经注册的UITableViewCell标识符
 @param signal 数据源signal
 */
- (instancetype)initWithRowTableView:(UITableView *)tableView
                      cellIdentifier:(NSString *)Identifier
                        sourceSignal:(RACSignal *)signal;

/**
 将TableView和数据源进行绑定 用于多个section单row的情况
 
 @param tableView 待绑定的 TableView
 @param Identifier TableView已经注册的UITableViewCell标识符
 @param signal 数据源signal
 */
- (instancetype)initWithSectionTableView:(UITableView *)tableView
                          cellIdentifier:(NSString *)Identifier
                            sourceSignal:(RACSignal *)signal;

- (instancetype)initWithTableView:(UITableView *)tableView
                    isSectionType:(BOOL)flag
                   cellIdentifier:(NSString *)Identifier
                     sourceSignal:(RACSignal *)signal;
@end
