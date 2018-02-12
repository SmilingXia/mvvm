//
//  XXMainVC.m
//  MVVMmode
//
//  Created by xia on 2018/2/8.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import "XXMainVC.h"
#import "XXMainHeaderViewModel.h"
#import "XXMainHeaderView.h"

@interface XXMainVC ()

@property (nonatomic, strong) XXMainHeaderView          *mainHeaderView;
@property (nonatomic, strong) XXMainHeaderViewModel     *headerViewModel;

@end

@implementation XXMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerViewModel = [[XXMainHeaderViewModel alloc] init];
    [self loadUI];
    [self setupKVO];
    [self loadDataSource];
}

- (void)loadUI{
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.view.backgroundColor = [UIColor whiteColor];
    self.mainHeaderView = [[XXMainHeaderView alloc] init];
    [self.view addSubview:self.mainHeaderView];
    self.mainHeaderView.layer.cornerRadius  = 10;
    self.mainHeaderView.clipsToBounds       = YES;
    self.mainHeaderView.backgroundColor     = XXCOLOR(99, 99, 99);
    [self.mainHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(70);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(100);
    }];
}

- (void)setupKVO{
    [self.headerViewModel addObserver:self forKeyPath:@"message" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
}

- (void)loadDataSource{
    [self.headerViewModel getPostMainHeaderViewSource];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"message"]) {
        if ([self.headerViewModel.message isEqualToString:@"success"]) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.mainHeaderView.backgroundColor     = XXCOLOR(0, 125, 255);
                [self updateHeaderViewSource];
            });
        }else{
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.mainHeaderView.backgroundColor     = XXCOLOR(99, 99, 99);
            });
        }
    }
}

- (void)updateHeaderViewSource{
    self.mainHeaderView.titleName  = [self.headerViewModel getmMainHeaderBodyOfContentArrayOfobjectIndex:0].title;
    self.mainHeaderView.contentString  = [self.headerViewModel getmMainHeaderBodyOfContentArrayOfobjectIndex:0].text;
    self.mainHeaderView.timeString  = [self.headerViewModel getmMainHeaderBodyOfContentArrayOfobjectIndex:0].ct;
    [self.mainHeaderView updateViewSource];
}

- (void)dealloc{
    [self.headerViewModel removeObserver:self forKeyPath:@"message"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
