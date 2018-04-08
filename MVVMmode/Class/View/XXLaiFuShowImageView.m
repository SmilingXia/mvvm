//
//  XXLaiFuShowImageView.m
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/13.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import "XXLaiFuShowImageView.h"
#import "XXImageBrowsing.h"
#import "XXShowImageViewModel.h"

@interface XXLaiFuShowImageView ()


/**
 ViewModel
 */
@property (nonatomic, strong) XXShowImageViewModel   *viewModel;

/**
 图片加载动画
 */
@property (nonatomic, strong) UIActivityIndicatorView   *activityIndicatorView;


@end

@implementation XXLaiFuShowImageView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self loadUI];
        UITapGestureRecognizer *selfTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageBigShow:)];
        [self addGestureRecognizer:selfTap];
    }
    return self;
}

#pragma mark -
#pragma mark    代理实现 - 监听实现

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"image"]) {
        //移除imageView的子视图
        [self.imageView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.imageView removeObserver:self forKeyPath:NSStringFromSelector(@selector(image))];
    }
}


#pragma mark -
#pragma mark    事件响应

- (void)imageBigShow:(UITapGestureRecognizer *)tap{
    [XXImageBrowsing showImage:self.imageView];
}

#pragma mark -
#pragma mark    方法实现

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

- (void)setDataSource:(NSDictionary *)dataSource{
    self.viewModel = [[XXShowImageViewModel alloc] initWidtDictionary:dataSource];
}

- (void)setTitleLabelText:(NSString *)titleText{
    self.titleLabel.text = titleText;
}

- (void)setImageViewUrl:(NSURL *)urlImage{
    if (_isShowLoadImageAnimation) {
        //设置监听 -- imageView的image属性
        [self.imageView addObserver:self forKeyPath:NSStringFromSelector(@selector(image)) options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.imageView addSubview:aiv];
        [aiv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(15);
            make.center.mas_equalTo(0);
        }];
        [aiv startAnimating];
    }
    //图片缓存 - 走自己的逻辑
    [[XXImageDownloadCenter sharedImageDownload] downloadImageWithUrl:urlImage completionBlock:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.imageView setImage:image];
        });
    } imageDownloadProgress:^(float schedule, NSString *sudu) {
        NSLog(@"下载进度为:%f/t下载速度为:%@",schedule,sudu);
    }];
//    "http://f.hiphotos.baidu.com/image/pic/item/9f2f070828381f305d95e4e5a3014c086f06f0ea.jpg",
//    "http://f.hiphotos.baidu.com/image/pic/item/5bafa40f4bfbfbed26ac5f3372f0f736aec31f80.jpg",
//    "http://g.hiphotos.baidu.com/image/pic/item/03087bf40ad162d94cbf0a501bdfa9ec8a13cd2d.jpg",
//    "http://a.hiphotos.baidu.com/image/pic/item/359b033b5bb5c9eae5e46bafdf39b6003af3b363.jpg",
//    "http://d.hiphotos.baidu.com/image/pic/item/aa18972bd40735fa9da426f594510fb30f240821.jpg",
//    "http://f.hiphotos.baidu.com/image/pic/item/37d12f2eb9389b505247881e8f35e5dde6116ec5.jpg",
//    "http://b.hiphotos.baidu.com/image/pic/item/b64543a98226cffc875dd7feb3014a90f603ea03.jpg"
}

#pragma mark -
#pragma mark    getter/setter

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
