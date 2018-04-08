//
//  XXVideoDownloadCenter.m
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/23.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import "XXVideoDownloadCenter.h"
#import "XXDownloadPathManager.h"
#import "XXVideoDownloadModel.h"


@interface XXVideoDownloadCenter ()<XXDownloadTaskObjectDelegate>

/**
 下载状态Block回调
 */
@property (nonatomic, copy) DownloadVideoStatusBlock   downloadVideoStatusBlock;


@end

@implementation XXVideoDownloadCenter

+ (XXVideoDownloadCenter *)sharedVideoDownload{
    static  XXVideoDownloadCenter *videoDownloadCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        videoDownloadCenter = [[XXVideoDownloadCenter alloc] init];
    });
    return videoDownloadCenter;
}

- (void)downloadVideoWithUrl:(NSURL *)videoUrl downloadVideoStatusBlock:(DownloadVideoStatusBlock)block
{
    self.downloadVideoStatusBlock = block;
    if ([self isCompletedTask:videoUrl]) {          //1.判断当前任务是否完成
        self.downloadVideoStatusBlock(@"下载完成");
    }
    else if ([self doesTheTaskExist:videoUrl]){     //2.判断是否存在该任务
        self.downloadVideoStatusBlock(@"存在下载");
    }
    else{                                           //3.添加任务到队列
        XXDownloadTaskObject *taskObject = nil;
        if (VideoMaxDownloadCount > [self getCurrentDownloads]) {   //4.判断下载队列是否已满 -- (未满)
            taskObject = [[XXDownloadTaskObject alloc] initWithUrl:videoUrl];
            taskObject.downloadTaskDelegate = self;
            [taskObject createDownloadTask];
            [taskObject start];
        }else{
            taskObject = [[XXDownloadTaskObject alloc] initWithWaitingTaskUrl:videoUrl];    //满
            taskObject.downloadTaskDelegate = self;
        }
        self.downloadVideoStatusBlock(@"已添加任务");
    }
}

#pragma mark -
#pragma mark    XXDownloadTaskObjectDelegate method

/**
 下载完成保存
 */
- (void)downloadTaskObject:(XXDownloadTaskObject *)taskObject downloadTaskCompletedDataInfo:(XXDownLoadModel *)modelInfo {
    [self saveDownloadInformation:modelInfo];
    //移除数组对应的taskObject
    int indexNumber = [self getTaskObjectIndexNumber:taskObject];
    [self.taskObjectArray removeObjectAtIndex:indexNumber];
    [self.videoDownloadModelArray removeObjectAtIndex:indexNumber];
    //开始下一个任务
    BOOL onetoone = NO;
    for (XXDownloadTaskObject *taskObject in self.taskObjectArray) {
        XXDownLoadModel *modelObject = [taskObject getDownLoadModel];
        if (modelObject.downLoadStatus == XXDownLoadStatusSuspended) {
            [taskObject createDownloadTask];
            [taskObject start];
            onetoone = YES;
        }
        else if (modelObject.downLoadStatus == XXDownLoadStatusWaiting){
            if (modelObject.total > 0 && modelObject.current > 0 && modelObject.current < modelObject.total) {
                [taskObject createDownloadTask];
                [taskObject start];
                onetoone = YES;
            }
            else{
                [taskObject createDownloadTask];
                [taskObject start];
                onetoone = YES;
            }
        }else{
            NSLog(@"状态为下载中，不用理会。");
        }
        if (onetoone) {
            break;
        }
    }
    if (self.updateViewLayoutBlock) {
        self.updateViewLayoutBlock(indexNumber);
    }
}

/**
 暂停保存
 */
- (void)downloadTaskObject:(XXDownloadTaskObject *)taskObject downloadTaskSuspendDataInfo:(XXDownLoadModel *)modelInfo {
    int indexNumber = [self getTaskObjectIndexNumber:taskObject];
    [self.taskObjectArray replaceObjectAtIndex:indexNumber withObject:taskObject];
    XXVideoDownloadModel *vdModel   = self.videoDownloadModelArray[indexNumber];
    vdModel.total                   = modelInfo.total;
    vdModel.current                 = modelInfo.current;
    vdModel.progress                = 1.0 * vdModel.current/vdModel.total;
    [self saveDownloadInformation:modelInfo];
}


/**
 第一次保存
 */
- (void)downloadTaskObject:(XXDownloadTaskObject *)taskObject downloadTaskFirstDataInfo:(XXDownLoadModel *)modelInfo {
    int indexNumber = [self getTaskObjectIndexNumber:taskObject];
    if (self.taskObjectArray.count > indexNumber) {
        [self.taskObjectArray replaceObjectAtIndex:indexNumber withObject:taskObject];
        XXVideoDownloadModel *vdModel   = self.videoDownloadModelArray[indexNumber];
        vdModel.total                   = modelInfo.total;
        vdModel.current                 = modelInfo.current;
        vdModel.progress                = 1.0 * vdModel.current/vdModel.total;
    }else{
        [self.taskObjectArray addObject:taskObject];
        XXVideoDownloadModel *vdModel   = [[XXVideoDownloadModel alloc] init];
        vdModel.titleFileName           = modelInfo.taskFileName;
        vdModel.total                   = modelInfo.total;
        vdModel.current                 = modelInfo.current;
        vdModel.progress                = 1.0 * vdModel.current/vdModel.total;
        [self.videoDownloadModelArray addObject:vdModel];
    }
    [self saveDownloadInformation:modelInfo];
}


/**
 下载进度回调
 */
- (void)downloadTaskObject:(XXDownloadTaskObject *)taskObject downloadProgressSchedule:(NSString *)schedule downloadSize:(NSString *)downloadSize totalSize:(NSString *)totalSize sudu:(NSString *)sudu{
    int indexNumber = [self getTaskObjectIndexNumber:taskObject];
    XXVideoDownloadModel *model = self.videoDownloadModelArray[indexNumber];
    if (model.downloadProgressBlock) {
        model.downloadProgressBlock(schedule, downloadSize, totalSize, sudu);
    }
}


/**
 得到当前下载任务对象对应的数组下标

 @param taskObject 下载任务
 */
- (int)getTaskObjectIndexNumber:(XXDownloadTaskObject *)taskObject{
    int indexNumber = 0;
    NSString *taskUrlString = [taskObject getDownLoadModel].taskUrlString;
    for (XXDownloadTaskObject *taskObject in self.taskObjectArray) {
        XXDownLoadModel *modelObject = [taskObject getDownLoadModel];
        if ([taskUrlString isEqualToString:modelObject.taskUrlString]) {
            break;
        }
        indexNumber++;
    }
    return indexNumber;
}


#pragma mark -
#pragma mark    method


/**
 持久化下载信息

 @param modelInfo 下载信息数据模型
 */
- (void)saveDownloadInformation:(XXDownLoadModel *)modelInfo{
    NSMutableDictionary *plist = [NSMutableDictionary dictionaryWithContentsOfFile:[XXDownloadPath getTheVideoPlistCachePath]];
    NSMutableDictionary *dic = [plist objectForKey:modelInfo.taskUrlString];
    dic = modelInfo.mj_keyValues;
    [plist setObject:dic forKey:modelInfo.taskUrlString];
    [plist writeToFile:[XXDownloadPath getTheVideoPlistCachePath] atomically:false];
    
    NSString *taskFilePath = [NSString stringWithFormat:@"%@%@",[XXDownloadPath getTheVideoCachePath],modelInfo.taskFileName];
    NSFileManager* manager = [NSFileManager defaultManager];
    NSLog(@"长度lenght = %llu",[[manager attributesOfItemAtPath:taskFilePath error:nil] fileSize]);
    NSLog(@"长度lenght = %ld",(long)modelInfo.current);
}


/**
 判断任务是否存在 -- 存在plist文件中

 @param taskUrl 任务URL地址
 @return YES(存在) NO(不存在)
 */
- (BOOL)doesTheTaskExist:(NSURL *)taskUrl {
    NSMutableDictionary *plist = [NSMutableDictionary dictionaryWithContentsOfFile:[XXDownloadPath getTheVideoPlistCachePath]];
    NSMutableDictionary *modelDic = [plist objectForKey:[taskUrl absoluteString]];
    if (modelDic) {
        return YES;
    }
    return NO;
}


/**
 判断任务是否存在 -- 存在TaskArr中
 
 @param taskUrlString 任务URL地址
 @return YES(存在) NO(不存在)
 */
- (BOOL)exsitUrlInSelfTaskArr:(NSString *)taskUrlString{
    BOOL exist = NO;
    for (XXDownloadTaskObject *taskObject in self.taskObjectArray) {
        if ([[taskObject getDownLoadModel].taskUrlString isEqualToString:taskUrlString]) {
            exist = YES;
        }
    }
    return exist;
}


/**
 判断任务是否完成

 @param taskUrl 任务URL地址
 @return YES(完成) NO(未完成)
 */
- (BOOL)isCompletedTask:(NSURL *)taskUrl {
    NSMutableDictionary *plist  = [NSMutableDictionary dictionaryWithContentsOfFile:[XXDownloadPath getTheVideoPlistCachePath]];
    NSMutableDictionary *modelDic = [plist objectForKey:[taskUrl absoluteString]];
    if (modelDic) {
        XXDownLoadModel *model  = [XXDownLoadModel mj_objectWithKeyValues:modelDic];
        if (model.downLoadStatus == XXDownLoadStatusCompleted) {
            return YES;
        }
    }
    return NO;
}


/**
 得到所有未完成的下载队列
 */
- (NSArray *)getUndownloadedTasksArray {
    NSMutableDictionary *plist  = [NSMutableDictionary dictionaryWithContentsOfFile:[XXDownloadPath getTheVideoPlistCachePath]];
    
    for (NSString *taskUrlString in [plist allKeys]) {
        if (![self exsitUrlInSelfTaskArr:taskUrlString]) {
            NSDictionary *modelDict = [plist objectForKey:taskUrlString];
            XXDownLoadModel *model = [XXDownLoadModel mj_objectWithKeyValues:modelDict];
            if (model.downLoadStatus == XXDownLoadStatusCompleted) {
                continue;
            }
            //得到数据源的二进制长度
            NSFileManager* manager = [NSFileManager defaultManager];
            NSString *taskFilePath = [NSString stringWithFormat:@"%@%@",[XXDownloadPath getTheVideoCachePath],model.taskFileName];
            NSLog(@"当前长度%llu",[[manager attributesOfItemAtPath:taskFilePath error:nil] fileSize]);
            model.current = (NSInteger)[[manager attributesOfItemAtPath:taskFilePath error:nil] fileSize];
            XXDownloadTaskObject *taskObject = nil;
            taskObject = [[XXDownloadTaskObject alloc] initWithDownLoadModel:model];
            taskObject.downloadTaskDelegate = self;
            [taskObject createDownloadTask];
            if (model.downLoadStatus == XXDownLoadStatusDownloading) {
                [taskObject start];
            }
            [self.taskObjectArray addObject:taskObject];
            
            XXVideoDownloadModel *vdModel       = [[XXVideoDownloadModel alloc] init];
            vdModel.titleFileName               = model.taskFileName;
            vdModel.total                       = model.total;
            vdModel.current                     = model.current;
            [self.videoDownloadModelArray addObject:vdModel];
        }
    }
    return self.videoDownloadModelArray;
}


/**
 当前队列并发下载数

 @return 当前队列并发数
 */
- (int)getCurrentDownloads {
    int number = 0;
    for (XXDownloadTaskObject *taskObject in self.taskObjectArray) {
        if ([taskObject getDownLoadModelStatus] == XXDownLoadStatusDownloading) {
            number++;
        }
    }
    return number;
}

- (void)taskObjectChangeWithSubscript:(NSInteger)subscript downLoadStatus:(XXDownLoadStatus)downLoadStatus{
    XXDownloadTaskObject *taskObject = self.taskObjectArray[subscript];
    if (downLoadStatus == XXDownLoadStatusDownloading) {
        if (VideoMaxDownloadCount > [self getCurrentDownloads]){
            [taskObject createDownloadTask];
            [taskObject start];
        }else{
            NSLog(@"达到最大下载");
        }
    }else if (downLoadStatus == XXDownLoadStatusSuspended){
        [taskObject suspend];
    }else{
        NSLog(@"不用关心这个状态了");
    }
}


#pragma mark -
#pragma mark    getter/setter

- (NSMutableArray *)taskObjectArray{
    if (_taskObjectArray) {
        return _taskObjectArray;
    }
    _taskObjectArray = [NSMutableArray array];
    return _taskObjectArray;
}

- (NSMutableArray *)videoDownloadModelArray{
    if (_videoDownloadModelArray) {
        return _videoDownloadModelArray;
    }
    _videoDownloadModelArray = [NSMutableArray array];
    return _videoDownloadModelArray;
}


@end
