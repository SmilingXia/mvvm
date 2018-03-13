//
//  XXLaiFuShowImageView.m
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/13.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import "XXLaiFuShowImageView.h"

@interface XXLaiFuShowImageView ()

@end

@implementation XXLaiFuShowImageView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self loadUI];
    }
    return self;
}


- (void)loadUI{
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(self.mas_width);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.imageView.mas_bottom);
    }];
}


- (UIImageView *)imageView{
    if (_imageView) {
        return _imageView;
    }
    _imageView = [[UIImageView alloc] init];
    return _imageView;
}

- (UILabel *)titleLabel{
    if (_titleLabel) {
        return _titleLabel;
    }
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    return _titleLabel;
}





@end
