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


@interface XXLaiFuKushimaShowImageVC ()

@property (nonatomic, strong) XXLaiFuShowImageViewModel     *showImageViewModel;

@property (nonatomic, strong) XXLaiFuShowImageView          *showImageView;

@end

@implementation XXLaiFuKushimaShowImageVC

- (instancetype)initWithShowImageViewModelDataSource:(id)dataSource{
    self = [super init];
    if (self) {
        self.showImageViewModel = [[XXLaiFuShowImageViewModel alloc] initWitdhModel:(XXFunnyPictureBodyList *)dataSource];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadUI];
}

#pragma mark -
#pragma mark    eventResponse 事件响应



#pragma mark -
#pragma mark    ObjectMethod - 方法区

- (void)loadUI{
    [self.view addSubview:self.showImageView];
    [self.showImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(260);
        make.height.mas_equalTo(300);
        make.center.mas_equalTo(0);
    }];
    [self setShowImageViewDict];
}

- (void)setShowImageViewDict{
    NSDictionary *dict = [self.showImageViewModel getViewImageUrlAndTitle];
    
    [self.showImageView setDataSource:dict];
    [self.showImageView setTitleLabelText:[dict objectForKey:@"title"]];
    [self.showImageView setImageViewUrl:[dict objectForKey:@"imageUrl"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark -
#pragma mark    getter/setter

- (XXLaiFuShowImageView *)showImageView{
    if (_showImageView) {
        return _showImageView;
    }
    _showImageView = [[XXLaiFuShowImageView alloc] init];
    _showImageView.backgroundColor      = XXCOLOR(222, 222, 222);
    _showImageView.layer.cornerRadius   = 5.0;
    _showImageView.layer.borderWidth    = 0.5;
    _showImageView.clipsToBounds        = YES;
    _showImageView.layer.borderColor    = XXCOLOR(199, 199, 199).CGColor;
    _showImageView.isShowLoadImageAnimation = YES;
    
    return _showImageView;
}


@end
