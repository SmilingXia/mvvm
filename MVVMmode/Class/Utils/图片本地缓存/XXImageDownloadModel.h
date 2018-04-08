//
//  XXImageDownloadModel.h
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/28.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DownloadImageBlock)(UIImage *image);

typedef void(^DownloadImageProgressBlock)(float schedule ,NSString *sudu);

@interface XXImageDownloadModel : NSObject

/**
 * 任务URL字符串
 */
@property (nonatomic, copy) NSString                    *imageUrlString;


/**
 成功回调
 */
@property (nonatomic, copy) DownloadImageBlock          completionBlock;

/**
 下载进度回调
 */
@property (nonatomic, copy) DownloadImageProgressBlock  imageDownloadProgress;

@end
