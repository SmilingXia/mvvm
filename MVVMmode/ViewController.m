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

#import "XXDownloadTaskObject.h"
#import "XXDownloadPathManager.h"
#import "XXDownLoadModel.h"
#import "XXVideoDownloadVC.h"
#import "XXDownloadListViewVC.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *nextButtonTwo;

@property (nonatomic, strong) UIButton *nextButton;

@property (nonatomic, strong) UIButton *nextButtonOne;


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
    [self.nextButton setTitle:@"下载界面" forState:UIControlStateNormal];
    [self.nextButton addTarget:self action:@selector(nextButtonOnclick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.nextButtonOne = [[UIButton alloc] init];
    [self.view addSubview:self.nextButtonOne];
    [self.nextButtonOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(self.nextButton);
        make.top.mas_equalTo(self.nextButton.mas_bottom).offset(20);
    }];
    self.nextButtonOne.backgroundColor = XXCOLOR(0, 125, 255);
    [self.nextButtonOne setTitle:@"查看下载" forState:UIControlStateNormal];
    [self.nextButtonOne addTarget:self action:@selector(nextButtonOnclickOne:) forControlEvents:UIControlEventTouchUpInside];
    
    self.nextButtonTwo = [[UIButton alloc] init];
    [self.view addSubview:self.nextButtonTwo];
    [self.nextButtonTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(self.nextButton);
        make.top.mas_equalTo(self.nextButtonOne.mas_bottom).offset(20);
    }];
    self.nextButtonTwo.backgroundColor = XXCOLOR(0, 125, 255);
    [self.nextButtonTwo setTitle:@"下一个界面" forState:UIControlStateNormal];
    [self.nextButtonTwo addTarget:self action:@selector(nextButtonOnclickTwo:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)nextButtonOnclick:(UIButton *)sender{
    [self gotoVC];
}

- (void)nextButtonOnclickOne:(UIButton *)sender{
    [self gotoVCOne];
}

- (void)nextButtonOnclickTwo:(UIButton *)sender{
    XXLaiFuKushimaVC *vc = [[XXLaiFuKushimaVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoVC{
//    XXMainVC *mainvc = [[XXMainVC alloc] init];
//    [self.navigationController pushViewController:mainvc animated:YES];
    
//    XXLaiFuKushimaVC *vc = [[XXLaiFuKushimaVC alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    
    XXVideoDownloadVC *vc = [[XXVideoDownloadVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoVCOne{
    XXDownloadListViewVC *vc = [[XXDownloadListViewVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
