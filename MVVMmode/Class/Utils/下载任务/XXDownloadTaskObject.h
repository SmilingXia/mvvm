//
//  XXDownloadTaskObject.h
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/21.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXDownLoadModel.h"
@class XXDownloadTaskObject;


@protocol XXDownloadTaskObjectDelegate <NSObject>

/**
 完成状态下回调保存信息

 @param modelInfo 下载模型 -- 必须修改模型状态为 XXDownLoadStatusCompleted
 */
- (void)downloadTaskObject:(XXDownloadTaskObject *)taskObject downloadTaskCompletedDataInfo:(XXDownLoadModel *)modelInfo;

@optional
/**
 暂停状态下回调保存信息

 @param modelInfo 下载模型 -- 必须修改模型状态为 XXDownLoadStatusSuspended
 */
- (void)downloadTaskObject:(XXDownloadTaskObject *)taskObject downloadTaskSuspendDataInfo:(XXDownLoadModel *)modelInfo;


/**
 第一次请求回调保存信息

 @param modelInfo 下载模型 -- 必须修改模型状态为 XXDownLoadStatusSuspended
 */
- (void)downloadTaskObject:(XXDownloadTaskObject *)taskObject downloadTaskFirstDataInfo:(XXDownLoadModel *)modelInfo;


/**
 下载进度信息回调

 @param taskObject 下载任务对象
 @param schedule 下载进度
 @param downloadSize 下载大小
 @param totalSize 总大小
 @param sudu 下载速度
 */
- (void)downloadTaskObject:(XXDownloadTaskObject *)taskObject
  downloadProgressSchedule:(NSString *)schedule
              downloadSize:(NSString *)downloadSize
                 totalSize:(NSString *)totalSize
                      sudu:(NSString *)sudu;

@end


@interface XXDownloadTaskObject : NSObject

/**
 下载代理
 */
@property (nonatomic, weak) id<XXDownloadTaskObjectDelegate> downloadTaskDelegate;

#pragma mark -
#pragma mark    关于图片下载的初始方法
- (instancetype)initWithLoadImageTaskUrl:(NSURL *)taskUrl;

#pragma mark -
#pragma mark    关于视频下载的初始化方法
/**
 根据URL创建 (等待) 下载任务
 
 @param taskUrl 等待下载任务的URL
 @return 等待下载任务
 */
- (instancetype)initWithWaitingTaskUrl:(NSURL *)taskUrl;


/**
 根据URL创建下载任务

 @param taskUrl 任务的URL
 @return 下载任务
 */
- (instancetype)initWithUrl:(NSURL *)taskUrl;


/**
 根据downLoadModel恢复下载任务

 @param downLoadModel 任务模型  -- 默认下载类型为 -- XXDownLoadFileTypeVideo
 @return 下载任务
 */
- (instancetype)initWithDownLoadModel:(XXDownLoadModel *)downLoadModel;

/**
 根据downLoadModel恢复下载任务
 
 @param downLoadModel 任务模型
 @return 下载任务
 */
- (instancetype)initWithDownLoadModel:(XXDownLoadModel *)downLoadModel downloadDFileType:(XXDownLoadFileType)downloadDFileType;


/**
 创建task进行下载 -- 针对等待状态  -- 断点下载
 */
- (void)createDownloadTask;

/**
 得到当前任务的状态

 @return 任务状态
 */
- (XXDownLoadStatus)getDownLoadModelStatus;


/**
 得到当前的模型

 @return 任务模型
 */
- (XXDownLoadModel *)getDownLoadModel;
#pragma mark -


/**
 *  开始下载
 */
- (void)start;


/**
 *  暂停下载
 */
- (void)suspend;

/**
 *  取消下载
 */
- (void)cancel;


@end
