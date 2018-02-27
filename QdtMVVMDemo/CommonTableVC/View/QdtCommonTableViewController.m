//
//  签到通无敌
//
//  Created by qiuzijie on 2018/2/27.
//Copyright © 2018年 qiuzijie. All rights reserved.
//

#import "QdtCommonTableViewController.h"

@interface QdtCommonTableViewController ()
@property (nonatomic, strong) QdtCommonTableVCViewModel *viewModel;
@end

@implementation QdtCommonTableViewController

#pragma mark- init
- (instancetype)initWithViewModel:(QdtCommonTableVCViewModel *)viewModel{
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
}

#pragma mark- configView
- (void)configView{
    //可以在这儿设置背景颜色呀，导航栏啥的
    [self addSubviews];
    [self constraintSubviews];
}

- (void)addSubviews{
    
}

- (void)constraintSubviews{

}

#pragma mark- bindViewModel
- (void)bindViewModel{
    
}

#pragma mark- delegate

#pragma mark- action

#pragma mark- private

#pragma mark- getter / setter

@end

