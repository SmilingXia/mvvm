//
//  XXImageBrowsing.m
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/15.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import "XXImageBrowsing.h"

//记录传入的imageView的CGRect
static CGRect imageViewFrame;

@implementation XXImageBrowsing

+ (void)showImage:(UIImageView *)imageView{
    UIImage *image = imageView.image;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0;
    imageViewFrame = [imageView convertRect:imageView.bounds toView:window];
    UIImageView *showImageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
    showImageView.image = image;
    showImageView.tag = 1;
    [backgroundView addSubview:showImageView];
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *backViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImageView:)];
    [backgroundView addGestureRecognizer:backViewTap];
    
    [UIView animateWithDuration:0.3 animations:^{
        showImageView.frame = CGRectMake(0, ([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    }];
}

+ (void)hideImageView:(UITapGestureRecognizer *)tap{
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=imageViewFrame;
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

@end
