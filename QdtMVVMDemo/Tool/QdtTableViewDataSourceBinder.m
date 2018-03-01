//
//  QdtTableViewDataSourceBinder.m
//  Pointer
//
//  Created by qiuzijie on 2017/11/21.
//  Copyright © 2017年 GM. All rights reserved.
//

#import "QdtTableViewDataSourceBinder.h"
#import "MJRefresh.h"
#import "QdtReactiveView.h"
#import <objc/runtime.h>

@interface QdtTableViewDataSourceBinder ()
@property (nonatomic, weak  ) NSArray *sources;
@property (nonatomic, weak  ) UITableView *tableView;
@property (nonatomic, strong) NSString *cellIdentifier;
@property (nonatomic, strong) RACSignal *sourceSignal;
@property (nonatomic, assign) BOOL sectionTableView;
@end

@implementation QdtTableViewDataSourceBinder

- (instancetype)initWithRowTableView:(UITableView *)tableView
                      cellIdentifier:(NSString *)Identifier
                        sourceSignal:(RACSignal *)signal{
    return [self initWithTableView:tableView isSectionType:NO cellIdentifier:Identifier sourceSignal:signal];
}

- (instancetype)initWithSectionTableView:(UITableView *)tableView
                          cellIdentifier:(NSString *)Identifier
                            sourceSignal:(RACSignal *)signal{
    return [self initWithTableView:tableView isSectionType:YES cellIdentifier:Identifier sourceSignal:signal];
}

- (instancetype)initWithTableView:(UITableView *)tableView
                    isSectionType:(BOOL)flag
                   cellIdentifier:(NSString *)Identifier
                     sourceSignal:(RACSignal *)signal{
    self = [super init];
    if (self) {
        self.tableView            = tableView;
        self.tableView.dataSource = self;
        self.cellIdentifier       = Identifier;
        self.sourceSignal         = signal;
        self.sectionTableView     = flag;
        [self bind];
    }
    return self;
}

- (void)bind{
    @weakify(self);
    [[self.sourceSignal deliverOnMainThread] subscribeNext:^(id value) {
        @strongify(self);
        if (value && ![value isKindOfClass:[NSArray class]]) {
            NSCAssert(NO, @"数据源必须为数组");
        }
        self.sources = value;
        [self.tableView reloadData];
    }];
}

#pragma mark- DataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(tableView:cellAtIndexPath:)]) {
        return [self.delegate tableView:tableView cellAtIndexPath:indexPath];
    }
    
    id<QdtReactiveView> cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    id viewModel;
    if (self.sectionTableView) {
        viewModel = self.sources[indexPath.section];
    } else {
        viewModel = self.sources[indexPath.row];
    }
    objc_property_t p = class_getProperty([cell class], "viewModel");
    NSParameterAssert(p);
    NSParameterAssert([viewModel isMemberOfClass:[self getPropertyType:p]]);
    NSParameterAssert([[cell class] instancesRespondToSelector:@selector(setViewModel:)]);
    
    cell.viewModel = viewModel;
    return (UITableViewCell *)cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.sectionTableView) {
        return 1;
    }
    return self.sources.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.sectionTableView) {
        return self.sources.count;
    }
    return 1;
}

- (Class)getPropertyType:(objc_property_t)property{
    NSString * typeString = [NSString stringWithUTF8String:property_getAttributes(property)];
    NSArray * attributes = [typeString componentsSeparatedByString:@","];
    NSString * typeAttribute = [attributes objectAtIndex:0];
    if ([typeAttribute hasPrefix:@"T@"] && [typeAttribute length] > 1) {
        NSString * typeClassName = [typeAttribute substringWithRange:NSMakeRange(3, [typeAttribute length]-4)];
        Class typeClass = NSClassFromString(typeClassName);
        return typeClass;
    }
    return nil;
}

@end
