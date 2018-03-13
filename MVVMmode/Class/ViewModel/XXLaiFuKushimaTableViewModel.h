//
//  XXLaiFuKushimaTableViewModel.h
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/13.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXLaiFukushimaFunnyPicture.h"

typedef void(^FunnyPictureBodyArrayBlock)(NSArray *funnyPictureBodyListModel);

typedef void(^ErrorMessige)(NSString *errormessige);

@interface XXLaiFuKushimaTableViewModel : NSObject

/**
 * 异常block
 */
@property (nonatomic, copy) ErrorMessige errorMessige;

/**
 * 数据模型-数组block
 */
@property (nonatomic, copy) FunnyPictureBodyArrayBlock   funnyPictureBlock;

/**
 * 数据模型-数组
 */
@property (nonatomic, strong) NSArray   *funnyPictureBodyArray;

/**
 * 数据模型
 */
@property (nonatomic, strong) XXLaiFukushimaFunnyPicture   *funnyPictureModel;


/**
 网络请求获取 - 来福岛搞笑图片
 */
- (void)getFukushimaFunnyPicture;


/**
 根据下标获取指定的模型

 @param index 下标
 @return 数据模型
 */
- (XXFunnyPictureBodyList *)getFunnyPictureBodyListWithIndex:(int)index;



@end
