//
//  XXLaiFuKushimaShowImageVC.m
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/13.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import "XXLaiFuKushimaShowImageVC.h"
#import "XXLaiFuShowImageViewModel.h"
#import "XXLaiFuShowImageView.h"
#import <AFNetworking/UIImageView+AFNetworking.h>


@interface XXLaiFuKushimaShowImageVC ()

@property (nonatomic, strong) XXLaiFuShowImageViewModel     *showImageViewModel;

@property (nonatomic, strong) XXLaiFuShowImageView          *showImageView;

@end

@implementation XXLaiFuKushimaShowImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadUI];
}

- (void)loadUI{
    self.showImageView = [[XXLaiFuShowImageView alloc] init];
    [self.view addSubview:self.showImageView];
    [self.showImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(260);
        make.height.mas_equalTo(300);
        make.center.mas_equalTo(0);
    }];
    self.showImageView.backgroundColor = XXCOLOR(222, 222, 222);
    self.showImageView.layer.cornerRadius = 5.0;
    self.showImageView.layer.borderWidth = 0.5;
    self.showImageView.layer.borderColor = XXCOLOR(199, 199, 199).CGColor;
    
    NSString *imageUrlString = self.showImageViewModel.funnyPictureBodyItemModel.thumburl;
    NSURL *imageUrl = [NSURL URLWithString:imageUrlString];
    [self.showImageView.imageView setImageWithURL:imageUrl];
    
    self.showImageView.titleLabel.text = self.showImageViewModel.funnyPictureBodyItemModel.title;
}

- (void)setShowImageViewModelDataSource:(id)dataSource{
    self.showImageViewModel = [[XXLaiFuShowImageViewModel alloc] init];
    self.showImageViewModel.funnyPictureBodyItemModel = (XXFunnyPictureBodyList *)dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
