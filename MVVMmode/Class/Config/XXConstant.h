//
//  XXConstant.h
//  MVVMmode
//
//  Created by xia on 2018/2/8.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

//调试
#ifdef DEBUG
# define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//
#define WEAK_SELF __weak typeof(self) weakSelf = self
#define STRONG_SELF __strong typeof(self) strongSelf = weakSelf

//设置颜色
#define XXCOLOR(x, y, z) [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:1.0]
#define XXCOLORALPHA(x, y, z , a) [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:a]
