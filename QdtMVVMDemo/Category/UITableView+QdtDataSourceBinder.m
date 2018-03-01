//
//  UITableView+QdtDataSourceBinder.m
//  Pointer
//
//  Created by qiuzijie on 2018/2/6.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "UITableView+QdtDataSourceBinder.h"
#import <objc/runtime.h>

@interface UITableView ()
@end

@implementation UITableView (QdtDataSourceBinder)

- (void)bindRowSourceSignal:(RACSignal *)signal cellIdentifier:(NSString *)identifier{
    [self bindSourceSignal:signal cellIdentifier:identifier isSection:NO];
}

- (void)bindSectionSourceSignal:(RACSignal *)signal cellIdentifier:(NSString *)identifier{
    [self bindSourceSignal:signal cellIdentifier:identifier isSection:YES];
}

- (void)bindSourceSignal:(RACSignal *)signal cellIdentifier:(NSString *)identifier isSection:(BOOL)aFlag {
    QdtTableViewDataSourceBinder *binder = [[QdtTableViewDataSourceBinder alloc] initWithTableView:self isSectionType:aFlag cellIdentifier:identifier sourceSignal:signal];
    [self setBinder:binder];
}

- (void)setBinder:(QdtTableViewDataSourceBinder *)binder{
    const void *key = "key";
    objc_setAssociatedObject(self, key, binder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
