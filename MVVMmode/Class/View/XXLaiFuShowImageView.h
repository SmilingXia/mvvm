//
//  XXLaiFuShowImageView.h
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/13.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXLaiFuShowImageView : UIView

/**
 图片加载动画
 */
@property (nonatomic, strong) UIActivityIndicatorView   *activityIndicatorView;

//UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//[self.imageViewss addSubview:aiv];
//[aiv mas_makeConstraints:^(MASConstraintMaker *make) {
//    make.width.height.mas_equalTo(10);
//    make.center.mas_equalTo(0);
//}];
//[aiv startAnimating];

/**
 显示图片
 */
@property (nonatomic, strong) UIImageView   *imageView;


/**
 显示标题
 */
@property (nonatomic, strong) UILabel   *titleLabel;

@end
