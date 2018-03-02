//
//  签到通无敌
//
//  Created by qiuzijie on 2018/3/1.
//Copyright © 2018年 qiuzijie. All rights reserved.
//

#import "QdtCommonUserListViewController.h"
#import "Masonry.h"
#import "MBProgressHUD.h"
#import "QdtUserCell.h"

@interface QdtCommonUserListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) QdtUserSelectedViewModel *viewModel;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation QdtCommonUserListViewController

#pragma mark- init
- (instancetype)initWithViewModel:(QdtUserSelectedViewModel *)viewModel{
    self = [super init];
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}

#pragma mark- lifeCycle
- (void)viewDidLoad{
    [super viewDidLoad];
    [self configView];
    [self bindViewModel];
    [self.viewModel.fetchUserListCommand execute:nil];
}

#pragma mark- configView
- (void)configView{
    //可以在这儿设置背景颜色呀，导航栏啥的
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.viewModel.title;
    [self addSubviews];
    [self constraintSubviews];
}

- (void)addSubviews{
    [self.view addSubview:self.tableView];
}

- (void)constraintSubviews{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark- bindViewModel
- (void)bindViewModel{
    @weakify(self);
    [[[RACObserve(self.viewModel, userViewModels) distinctUntilChanged] deliverOnMainThread] subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    
    [self.viewModel.fetchUserListCommand.executing subscribeNext:^(NSNumber *value) {
        if (value.boolValue) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        } else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
}

#pragma mark- delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QdtUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    QdtUserCellViewModel *viewModel = self.viewModel.userViewModels[indexPath.row];
    cell.viewModel = viewModel;
    cell.followBlock = ^{
        ;
    };
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.userViewModels.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark- action

#pragma mark- private

#pragma mark- getter / setter

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 60;
        [_tableView registerNib:[UINib nibWithNibName:@"QdtUserCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

@end





