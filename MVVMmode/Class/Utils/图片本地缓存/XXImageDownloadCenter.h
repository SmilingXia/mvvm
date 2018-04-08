//
//  XXImageDownloadCenter.h
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/20.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXImageDownloadModel.h"


@interface XXImageDownloadCenter : NSObject

/**
 图片下载中心 ---- 单利

 @return 图片下载中心
 */
+ (XXImageDownloadCenter *)sharedImageDownload;


- (XXImageDownloadCenter *)downloadImageWithUrl:(NSURL *)imageUrl
                                completionBlock:(DownloadImageBlock)block
                          imageDownloadProgress:(DownloadImageProgressBlock)imageDownloadProgress;



@end
