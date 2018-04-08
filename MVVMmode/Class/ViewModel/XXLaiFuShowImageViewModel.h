//
//  XXLaiFuShowImageViewModel.h
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/13.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXLaiFukushimaFunnyPicture.h"

@interface XXLaiFuShowImageViewModel : NSObject


- (instancetype)initWitdhModel:(XXFunnyPictureBodyList *)model;


/**
 组装View显示的图片（imageUrl）标题（title）

 @return 字典
 */
- (NSDictionary *)getViewImageUrlAndTitle;


@end
