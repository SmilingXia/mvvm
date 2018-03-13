//
//  XXLaiFuKushimaVC.m
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/9.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import "XXLaiFuKushimaVC.h"
#import "XXLaiFuKushimaTC.h"
#import "XXLaiFuKushimaShowImageVC.h"

@interface XXLaiFuKushimaVC ()<XXViewCallbackProtocol>

@property(nonatomic, strong) XXLaiFuKushimaTC   *lafuTableView;//列表

@end

@implementation XXLaiFuKushimaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
}

- (void)loadUI{
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.view.backgroundColor = [UIColor whiteColor];
    self.lafuTableView = [[XXLaiFuKushimaTC alloc] init];
    [self.view addSubview:self.lafuTableView.view];
    [self.lafuTableView.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.bottom.right.mas_equalTo(0);
    }];
    self.lafuTableView.backDelegate = self;
}


- (void)withValueTransmission:(id)model{
    XXLaiFuKushimaShowImageVC *vc = [[XXLaiFuKushimaShowImageVC alloc] init];
    [vc setShowImageViewModelDataSource:model];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
