//
//  XXDownLoadModel.h
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/21.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger ,XXDownLoadStatus) {
    XXDownLoadStatusWaiting = 0,        //等待中
    XXDownLoadStatusDownloading,        //下载中
    XXDownLoadStatusSuspended,          //暂停中
    XXDownLoadStatusCompleted,          //已完成
};

typedef NS_ENUM(NSInteger ,XXDownLoadFileType) {
    XXDownLoadFileTypeVideo = 0,        //视频
    XXDownLoadFileTypeImage,            //图片
    XXDownLoadFileTypePDF,              //PDF
    XXDownLoadFileTypeFile,             //其他文件
};


@interface XXDownLoadModel : NSObject

/**
 *  downloadDFileType     下载文件类型
 */
@property (nonatomic, assign) XXDownLoadFileType    downloadDFileType;

/**
 *  taskUrl     任务地址
 */
@property (nonatomic, strong) NSURL                 *taskUrl;


/**
 * 任务URL字符串 （可转化为上面的URL属性）
 */
@property (nonatomic, copy) NSString                *taskUrlString;


/**
 * 任务下载状态
 */
@property (nonatomic, assign) XXDownLoadStatus      downLoadStatus;


/**
 * 文件总大小
 */
@property (nonatomic, assign) NSInteger             total;


/**
 * 当前下载大小
 */
@property (nonatomic, assign) NSInteger             current;


/**
 *  taskFileName    任务名称 -- 下载完成保存的名字 -- 带后缀
 */
@property (nonatomic, copy) NSString                *taskFileName;



@end
