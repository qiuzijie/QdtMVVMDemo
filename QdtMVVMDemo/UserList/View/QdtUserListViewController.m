//
//  签到通无敌
//
//  Created by qiuzijie on 2018/2/27.
//Copyright © 2018年 qiuzijie. All rights reserved.
//

#import "QdtUserListViewController.h"
#import "UIImage+QdtMethods.h"
#import "UITableView+QdtDataSourceBinder.h"
#import "masonry.h"
#import "MBProgressHUD.h"
#import "QdtUserCell.h"
#import "MJRefresh.h"

static CGFloat kSearchTextFieldHeight = 40;

@interface QdtUserListViewController ()<UITableViewDelegate, UITextFieldDelegate, UITableViewDataSource>
@property (nonatomic, strong) QdtUserListViewModel *viewModel;
@property (nonatomic, strong) UIView *searchContainerView;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) UITableView *userTableView;
@end

@implementation QdtUserListViewController

#pragma mark- init
- (instancetype)initWithViewModel:(QdtUserListViewModel *)viewModel{
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
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.viewModel.title;
    [self addSubviews];
    [self constraintSubviews];
}

- (void)addSubviews{
    [self.searchContainerView addSubview:self.searchTextField];
    [self.searchContainerView addSubview:self.searchButton];
    [self.view addSubview:self.searchContainerView];
    [self.view addSubview:self.userTableView];
}

- (void)constraintSubviews{
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.equalTo(self.searchContainerView);
        make.right.equalTo(self.searchButton.mas_left).offset(-10);
        make.height.mas_equalTo(kSearchTextFieldHeight);
    }];
    
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(80);
        make.height.centerY.equalTo(self.searchTextField);
    }];
    
    [self.searchContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.height.mas_equalTo(100);
        make.left.right.equalTo(self.view);
    }];
    
    [self.userTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.searchContainerView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark- bindViewModel
- (void)bindViewModel{
    @weakify(self);
    
//    [self.userTableView bindRowSourceSignal:RACObserve(self.viewModel, userViewModels) cellIdentifier:@"cell"];
    
    [[RACObserve(self.viewModel, userViewModels) distinctUntilChanged] subscribeNext:^(id x) {
        @strongify(self);
        [self.userTableView reloadData];
    }];
    
    [self.userTableView addHeaderWithCommand:self.viewModel.fetchUserListCommand];
    [self.userTableView addFooterWithCommand:self.viewModel.fetchUserListCommand];
    RAC(self.userTableView.footer, hidden) = [[RACObserve(self.viewModel, userListHasNext) not] distinctUntilChanged];

//    [RACObserve(self.viewModel, userListHasNext) subscribeNext:^(NSNumber *value) {
//        @strongify(self);
//        if (value && value.boolValue) {
//            [self.userTableView setFooterHidden:NO];
//            if (!self.userTableView.footer) {
//                [self.userTableView addFooterWithCommand:self.viewModel.fetchUserListCommand];
//            }
//        } else {
//            [self.userTableView setFooterHidden:YES];
//        };
//    }];
    
    [self.viewModel.fetchUserListCommand.executing subscribeNext:^(NSNumber *value) {
        @strongify(self);
        if (value.boolValue && self.viewModel.userViewModels.count == 0) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        } else {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        };
    }];
    
    [self.viewModel.searchUsersCommand.executing subscribeNext:^(NSNumber *value) {
        @strongify(self);
        if (value.boolValue) {
            [self.searchTextField resignFirstResponder];
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        } else {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        };
    }];
    
    RAC(self.viewModel, searchText) = self.searchTextField.rac_textSignal;
    self.searchButton.rac_command = self.viewModel.searchUsersCommand;
}

#pragma mark- delegate

#pragma mark- UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QdtUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    QdtUserCellViewModel *viewModel = self.viewModel.userViewModels[indexPath.row];
    [[viewModel.followCommand executing] subscribeNext:^(NSNumber *value) {
        if (value.boolValue) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        } else {
            [MBProgressHUD hideHUDForView:self.view animated:NO];
        };
    }];
    cell.viewModel = viewModel;
    @weakify(self);
    cell.followBlock = ^{
        @strongify(self);
        [self followUser:viewModel];
    };
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.userViewModels.count;
}

#pragma mark- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = @"用户信息";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.searchTextField resignFirstResponder];
}

#pragma mark- action

- (void)followUser:(QdtUserCellViewModel *)viewModel{
    QdtUserModel *user = viewModel.user;
    if (user.follow) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"取消关注" message:[NSString stringWithFormat:@"确定取消关注 %@ 吗？",viewModel.userName] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            ;
        }];
        UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [viewModel.followCommand execute:nil];
        }];
        [alertController addAction:actionCancel];
        [alertController addAction:actionConfirm];
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        [viewModel.followCommand execute:nil];
    }
}

#pragma mark- private

#pragma mark- getter / setter
- (UIView *)searchContainerView{
    if (!_searchContainerView) {
        _searchContainerView = [UIView new];
        _searchContainerView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    }
    return _searchContainerView;
}

- (UITextField *)searchTextField{
    if (!_searchTextField) {
        _searchTextField = [UITextField new];
        _searchTextField.font = [UIFont systemFontOfSize:14];
        _searchTextField.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
        _searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _searchTextField;
}

- (UIButton *)searchButton{
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:87/255.0 green:163/255.0 blue:250/255.0 alpha:1]] forState:UIControlStateNormal];
        [_searchButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1]] forState:UIControlStateDisabled];
        [_searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _searchButton.layer.cornerRadius = kSearchTextFieldHeight/2;
        _searchButton.layer.masksToBounds = YES;
        [_searchButton setTitle:@"搜索 🔍" forState:UIControlStateNormal];
    }
    return _searchButton;
}

- (UITableView *)userTableView{
    if (!_userTableView) {
        _userTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _userTableView.tableFooterView = [UIView new];
        _userTableView.delegate = self;
        _userTableView.dataSource = self;
        _userTableView.rowHeight = 60;
        [_userTableView registerNib:[UINib nibWithNibName:@"QdtUserCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    }
    return _userTableView;
}

@end


















