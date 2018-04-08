//
//  XXDownloadPathManager.h
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/20.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import <Foundation/Foundation.h>

#define XXDownloadPath [XXDownloadPathManager sharedDownloadPathManager]

@interface XXDownloadPathManager : NSObject

/**
 获取公共下载缓存路径

 @return 路径管理对象
 */
+ (XXDownloadPathManager *)sharedDownloadPathManager;

/**
 得到图片文件缓存路径

 @return 图片文件缓存路径
 */
- (NSString *)getTheImageCachePath;


/**
 得到图片plist缓存路径

 @return 图片plist缓存路径
 */
- (NSString *)getTheImagePlistCachePath;


/**
 得到视频文件缓存路径

 @return 视频文件缓存路径
 */
- (NSString *)getTheVideoCachePath;


/**
 得到视频plist缓存路径
 
 @return 视频plist缓存路径
 */
- (NSString *)getTheVideoPlistCachePath;



/**
 得到临时文件路径地址

 @return 临时文件路径
 */
- (NSString *)getTheTmpFilePathString;


@end
