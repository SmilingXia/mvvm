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
 显示图片
 */
@property (nonatomic, strong) UIImageView   *imageView;

/**
 显示标题
 */
@property (nonatomic, strong) UILabel   *titleLabel;

/**
 是否显示图片加载动画
 */
@property (nonatomic, assign) BOOL      isShowLoadImageAnimation;

/**
 设置图片地址 - 来显示图片

 @param urlImage 图片url地址
 */
- (void)setImageViewUrl:(NSURL *)urlImage;


/**
 设置文本标题

 @param titleText 标题
 */
- (void)setTitleLabelText:(NSString *)titleText;

/**
 设置数据源

 @param dataSource 数据源
 */
- (void)setDataSource:(NSDictionary *)dataSource;


@end
