//
//  签到通无敌
//
//  Created by qiuzijie on 2018/3/2.
//Copyright © 2018年 qiuzijie. All rights reserved.
//

#import "QdtTransformersViewController.h"
#import "QdtTransformersHeadView.h"
#import "QdtTransformersArmView.h"
#import "QdtTransformersBodyView.h"
#import "QdtTransformersFootView.h"
#import "Masonry.h"

@interface QdtTransformersViewController ()
@property (nonatomic, strong) QdtTransformersViewModel *viewModel;
@property (nonatomic, strong) QdtTransformersHeadView *headView;
@property (nonatomic, strong) QdtTransformersArmView  *armView;
@property (nonatomic, strong) QdtTransformersBodyView *bodyView;
@property (nonatomic, strong) QdtTransformersFootView *footView;
@end

@implementation QdtTransformersViewController

#pragma mark- init
- (instancetype)initWithViewModel:(QdtTransformersViewModel *)viewModel{
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
    
    [self.viewModel.headViewModel.fetchHeadInfoCommand execute:nil];
    [self.viewModel.armViewModel.fetchArmInfoCommand execute:nil];
    [self.viewModel.bodyViewModel.fetchBodyInfoCommand execute:nil];
    [self.viewModel.footViewModel.fetchFootInfoCommand execute:nil];
}

#pragma mark- configView
- (void)configView{
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubviews];
    [self constraintSubviews];
}

- (void)addSubviews{
    [self.view addSubview:self.headView];
    [self.view addSubview:self.armView];
    [self.view addSubview:self.bodyView];
    [self.view addSubview:self.footView];
}

- (void)constraintSubviews{
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(10);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(80);
    }];
    
    [self.armView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headView.mas_bottom).offset(10);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(80);
    }];
    
    [self.bodyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.armView.mas_bottom).offset(10);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(80);
    }];
    
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bodyView.mas_bottom).offset(10);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
}

#pragma mark- bindViewModel
- (void)bindViewModel{
    
    
    
    [self.viewModel.fetchZipSignal subscribeNext:^(id x) {
        ;
    }];
    
}

#pragma mark- delegate

#pragma mark- action

#pragma mark- private

#pragma mark- getter / setter

- (QdtTransformersHeadView *)headView{
    if (!_headView) {
        _headView = [[QdtTransformersHeadView alloc] initWithViewModel:self.viewModel.headViewModel];
    }
    return _headView;
}

- (QdtTransformersArmView *)armView{
    if (!_armView) {
        _armView = [[QdtTransformersArmView alloc] initWithViewModel:self.viewModel.armViewModel];
//        @weakify(_armView);
//        _armView.hideBlock = ^{
//            @strongify(_armView);
//            [_armView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(0);
//            }];
//            _armView.hidden = YES;
//        };
    }
    return _armView;
}

- (QdtTransformersBodyView *)bodyView{
    if (!_bodyView) {
        _bodyView = [[QdtTransformersBodyView alloc] initWithViewModel:self.viewModel.bodyViewModel];
    }
    return _bodyView;
}

- (QdtTransformersFootView *)footView{
    if (!_footView) {
        _footView = [[QdtTransformersFootView alloc] initWithViewModel:self.viewModel.footViewModel];
    }
    return _footView;
}

@end

