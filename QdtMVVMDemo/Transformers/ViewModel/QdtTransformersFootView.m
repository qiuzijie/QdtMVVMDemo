//
//  QdtTransformersFootView.m
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/3/2.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import "QdtTransformersFootView.h"
#import "Masonry.h"
#import "MBProgressHUD.h"

@interface QdtTransformersFootView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation QdtTransformersFootView

- (instancetype)initWithViewModel:(QdtTransformersFootViewModel *)viewModel{
    self = [super init];
    if (self) {
        _viewModel = viewModel;
        [self configView];
        [self bindViewModel];
    }
    return self;
}

- (void)configView{
    
    self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)bindViewModel{
    [self.viewModel.fetchFootInfoCommand.executing subscribeNext:^(NSNumber *value) {
        if (value.boolValue) {
            [MBProgressHUD showHUDAddedTo:self animated:YES];
        } else {
            [MBProgressHUD hideHUDForView:self animated:YES];
            [self.tableView reloadData];
        };
    }];
}

#pragma mark- delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.viewModel.datas[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.datas.count;
}

#pragma mark- getter / setter

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

@end
