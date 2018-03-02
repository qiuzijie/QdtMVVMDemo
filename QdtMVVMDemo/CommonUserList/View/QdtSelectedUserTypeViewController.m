//
//  签到通无敌
//
//  Created by qiuzijie on 2018/3/1.
//Copyright © 2018年 qiuzijie. All rights reserved.
//

#import "QdtSelectedUserTypeViewController.h"
#import "QdtCommonUserListViewController.h"

@interface QdtSelectedUserTypeViewController ()

@end

@implementation QdtSelectedUserTypeViewController

#pragma mark- init
- (instancetype)initWithViewModel:(id)viewModel{
    self = [super init];
    if (self) {
        
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

- (IBAction)tapEmployeeButton:(UIButton *)sender {
    QdtUserSelectedViewModel *vm = [QdtUserSelectedViewModel viewModelOfEmployeeID:0];
    QdtCommonUserListViewController *vc = [[QdtCommonUserListViewController alloc] initWithViewModel:vm];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)tapApproverButton:(UIButton *)sender {
    QdtUserSelectedViewModel *vm = [QdtUserSelectedViewModel viewModelOfApproverID:0];
    QdtCommonUserListViewController *vc = [[QdtCommonUserListViewController alloc] initWithViewModel:vm];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)tapPrincipalButton:(UIButton *)sender {
    
    QdtUserSelectedViewModel *vm = [QdtUserSelectedViewModel viewModelOfPrincipals:[self principals]];
    QdtCommonUserListViewController *vc = [[QdtCommonUserListViewController alloc] initWithViewModel:vm];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSArray *)principals{
    NSMutableArray *datas = [NSMutableArray new];
    for (NSInteger i = 0; i <= 20; i++) {
        QdtPrincipalModel *user = [QdtPrincipalModel new];
        user.userName = [NSString stringWithFormat:@"XXX %ld 号",i];
        user.iconName = @"genshuo";
        [datas addObject:user];
    }
    return [datas copy];
}

#pragma mark- private

#pragma mark- getter / setter

@end

