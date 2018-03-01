//
//  ViewController.m
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/2/27.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import "ViewController.h"
#import "QdtUserListViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)tapCommonTableVCButton:(UIButton *)sender {
    QdtUserListViewModel *viewModel = [[QdtUserListViewModel alloc] initWithUserID:0];
    QdtUserListViewController *vc = [[QdtUserListViewController alloc] initWithViewModel:viewModel];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)tapComplexButton:(UIButton *)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
