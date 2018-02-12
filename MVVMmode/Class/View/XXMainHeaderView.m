//
//  XXMainHeaderView.m
//  MVVMmode
//
//  Created by xia on 2018/2/12.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import "XXMainHeaderView.h"

@interface XXMainHeaderView()

@property   (nonatomic, strong) UILabel *titleLabe;

@property   (nonatomic, strong) UILabel *contentLabel;

@property   (nonatomic, strong) UILabel *titmerLabel;

@end

@implementation XXMainHeaderView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self loadUI];
        [self loadSubViewLayout];
    }
    return self;
}

- (void)loadUI{
    [self addSubview:self.titleLabe];
    [self addSubview:self.contentLabel];
    [self addSubview:self.titmerLabel];
}

- (void)loadSubViewLayout{
    [self.titleLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(5);
        make.height.mas_equalTo(30);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.titleLabe.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
    [self.titmerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
    }];
}

- (void)updateViewSource{
    self.titleLabe.text     = _titleName;
    self.contentLabel.text  = _contentString;
    self.titmerLabel.text   = _timeString;
    [self updataContentLabelLayout];
}

#pragma mark - 更新当前显示内容的约束
- (void)updataContentLabelLayout{
    [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([XXMainHeaderView getHeaderViewHeight:_contentString] - 70);
    }];
    [self layoutIfNeeded];
}


- (UILabel *)titleLabe{
    if (_titleLabe == nil) {
        _titleLabe = [[UILabel alloc] init];
    }
    return _titleLabe;
}

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
    }
    return _contentLabel;
}

- (UILabel *)titmerLabel{
    if (_titmerLabel == nil) {
        _titmerLabel = [[UILabel alloc] init];
    }
    return _titmerLabel;
}

+ (float)getHeaderViewHeight:(NSString *)contentString{
    return 100;
}

@end
