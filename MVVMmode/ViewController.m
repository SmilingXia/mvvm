//
//  ViewController.m
//  MVVMmode
//
//  Created by xia on 2018/2/8.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import "ViewController.h"
#import "XXMainVC.h"
#import "XXLaiFuKushimaVC.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *nextButton;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.nextButton = [[UIButton alloc] init];
    [self.view addSubview:self.nextButton];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
        make.center.mas_equalTo(0);
    }];
    self.nextButton.backgroundColor = XXCOLOR(0, 125, 255);
    [self.nextButton setTitle:@"下一个界面" forState:UIControlStateNormal];
    [self.nextButton addTarget:self action:@selector(nextButtonOnclick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)nextButtonOnclick:(UIButton *)sender{
    [self gotoVC];
}

- (void)gotoVC{
//    XXMainVC *mainvc = [[XXMainVC alloc] init];
//    [self.navigationController pushViewController:mainvc animated:YES];
    
    XXLaiFuKushimaVC *vc = [[XXLaiFuKushimaVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
