//
//  XXMainHeaderView.h
//  MVVMmode
//
//  Created by xia on 2018/2/12.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXMainHeaderView : UIView

/**
 *  标题
 */
@property (nonatomic, copy) NSString *titleName;

/**
 *  内容
 */
@property (nonatomic, copy) NSString *contentString;

/**
 *  时间
 */
@property (nonatomic, copy) NSString *timeString;


/**
 *  更新视图数据源
 */
- (void)updateViewSource;

/**
 *  获取内容的高度
 */
+ (float)getHeaderViewHeight:(NSString *)contentString;

@end
