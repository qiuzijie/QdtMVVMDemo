//
//  QdtUserCell.m
//  QdtMVVMDemo
//
//  Created by qiuzijie on 2018/2/28.
//  Copyright © 2018年 qiuzijie. All rights reserved.
//

#import "QdtUserCell.h"

@interface QdtUserCell ()
@property (weak, nonatomic) IBOutlet UILabel  *userNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *followButton;
@end

@implementation QdtUserCell

- (void)setViewModel:(QdtUserCellViewModel *)viewModel{
    _viewModel = viewModel;
    [self bindViewModel];
}

- (void)bindViewModel{
    self.userNameLabel.text = self.viewModel.userName;
    
    @weakify(self);
    [[[RACObserve(self.viewModel, likeText) takeUntil:self.rac_prepareForReuseSignal] deliverOnMainThread] subscribeNext:^(id x) {
        @strongify(self);
        [self.likeButton setTitle:x forState:UIControlStateNormal];
    }];
    
    [[[RACObserve(self.viewModel, followText) takeUntil:self.rac_prepareForReuseSignal] deliverOnMainThread] subscribeNext:^(id x) {
        @strongify(self);
        [self.followButton setTitle:x forState:UIControlStateNormal];
    }];
    
    RAC(self.likeButton, backgroundColor) = [[RACObserve(self.viewModel, likeButtonColor) deliverOnMainThread] takeUntil:self.rac_prepareForReuseSignal];
    RAC(self.followButton, backgroundColor) = [[RACObserve(self.viewModel, followButtonColor) deliverOnMainThread] takeUntil:self.rac_prepareForReuseSignal];
    
//    RAC(self.likeButton.titleLabel, text) = [[RACObserve(self.viewModel, likeText) takeUntil:self.rac_prepareForReuseSignal] deliverOnMainThread];
//    RAC(self.followButton.titleLabel, text) = [[RACObserve(self.viewModel, followText) takeUntil:self.rac_prepareForReuseSignal] deliverOnMainThread];
    
    self.likeButton.rac_command = self.viewModel.likeCommand;

    [[self.followButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        if (self.followBlock) {
            self.followBlock();
        }
    }];
}

@end










