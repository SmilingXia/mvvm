//
//  XXVideoDownloadCenter.h
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/23.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#define VideoDownloadCenter [XXVideoDownloadCenter sharedVideoDownload]
#define VideoMaxDownloadCount 3

#import <Foundation/Foundation.h>
#import "XXDownloadTaskObject.h"

typedef void(^DownloadVideoStatusBlock)(NSString *status);

typedef void(^UpdateViewLayoutBlock)(int indexPathRow);

@interface XXVideoDownloadCenter : NSObject

/**
 * 成功刷新视图BLOCK - indexPathRow(刷新的某一列)
 */
@property (nonatomic, copy) UpdateViewLayoutBlock updateViewLayoutBlock;

/**
 视频文件下载中心 ---- 单利
 
 @return 图片下载中心
 */
+ (XXVideoDownloadCenter *)sharedVideoDownload;


/**
 下载任务对象数组 -- 已完成 ，下载中 ，等待中
 */
@property (nonatomic, strong) NSMutableArray   *taskObjectArray;


/**
 下载进度模型数组
 */
@property (nonatomic, strong) NSMutableArray   *videoDownloadModelArray;

/**
 下载视频

 @param videoUrl 视频地址
 */
- (void)downloadVideoWithUrl:(NSURL *)videoUrl downloadVideoStatusBlock:(DownloadVideoStatusBlock)block;


/**
 得到所有未完成的下载队列

 @return 所有未完成的数组
 */
- (NSArray *)getUndownloadedTasksArray;


/**
 下载对象状态变更

 @param subscript 下标
 */
- (void)taskObjectChangeWithSubscript:(NSInteger)subscript downLoadStatus:(XXDownLoadStatus)downLoadStatus;

@end
