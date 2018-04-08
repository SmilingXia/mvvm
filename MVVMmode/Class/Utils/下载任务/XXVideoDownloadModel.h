//
//  XXVideoDownloadModel.h
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/26.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 下载进度回调哦

 @param schedule 下载进度
 @param downloadSize 下载字节大小
 @param totalSize 文件总字节大小
 @param sudu 这一秒下载速度
 */
typedef void(^VideoDownloadProgressBlock)(NSString *schedule,NSString *downloadSize,NSString *totalSize,NSString *sudu);

@interface XXVideoDownloadModel : NSObject

/**
 * 下载进度bolock
 */
@property (nonatomic, copy) VideoDownloadProgressBlock downloadProgressBlock;

/**
 * 文件名称
 */
@property (nonatomic, copy) NSString *titleFileName;

/**
 * 文件总大小
 */
@property (nonatomic, assign) NSInteger         total;


/**
 * 当前下载大小
 */
@property (nonatomic, assign) NSInteger         current;


/**
 下载进度0.0-1.0
 */
@property (nonatomic, assign) float             progress;

@end
