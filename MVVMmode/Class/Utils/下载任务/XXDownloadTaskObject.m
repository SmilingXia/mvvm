//
//  XXDownloadTaskObject.m
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/21.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import "XXDownloadTaskObject.h"
#import "XXDownloadPathManager.h"

@interface XXDownloadTaskObject ()<NSURLSessionDataDelegate>

@property (nonatomic, strong) XXDownLoadModel           *downLoadModel;     //下载模型
@property (nonatomic, strong) NSURLSession              *session;           //会话
@property (nonatomic, strong) NSURLSessionDataTask      *dataTask;          //下载任务
@property (nonatomic, strong) NSOutputStream            *stream;            //流
//计算下载速度
@property (nonatomic, strong) NSDate                    *jianGeDate;    //回调时间间隔
@property (nonatomic, assign) float                     jianGeDateSize; //间隔的总速度
@property (nonatomic, assign) BOOL                      oneEnter;       //第一次进入


@end

@implementation XXDownloadTaskObject

- (instancetype)initWithWaitingTaskUrl:(NSURL *)taskUrl{
    self = [super init];
    if (self) {
        [self loadConfigurationInfo];
        self.downLoadModel = [[XXDownLoadModel alloc] init];
        self.downLoadModel.taskUrl          = taskUrl;
        self.downLoadModel.taskUrlString    = [taskUrl absoluteString];
        self.downLoadModel.total            = 0;
        self.downLoadModel.current          = 0;
        self.downLoadModel.downLoadStatus   = XXDownLoadStatusWaiting;
        self.downLoadModel.downloadDFileType= XXDownLoadFileTypeVideo;
        //需要回调状态
        [self createDownloadTask];
        [self.dataTask resume];
    }
    return self;
}

- (instancetype)initWithUrl:(NSURL *)taskUrl{
    self = [super init];
    if (self) {
        [self loadConfigurationInfo];
        self.downLoadModel = [[XXDownLoadModel alloc] init];
        self.downLoadModel.taskUrl          = taskUrl;
        self.downLoadModel.taskUrlString    = [taskUrl absoluteString];
        self.downLoadModel.total            = 0;
        self.downLoadModel.current          = 0;
        self.downLoadModel.downLoadStatus   = XXDownLoadStatusDownloading;
        self.downLoadModel.downloadDFileType= XXDownLoadFileTypeVideo;
    }
    return self;
}

- (instancetype)initWithDownLoadModel:(XXDownLoadModel *)downLoadModel{
    self = [super init];
    if (self) {
        [self loadConfigurationInfo];
        self.downLoadModel                  = downLoadModel;
        self.downLoadModel.downloadDFileType= XXDownLoadFileTypeVideo;
    }
    return self;
}

- (instancetype)initWithDownLoadModel:(XXDownLoadModel *)downLoadModel downloadDFileType:(XXDownLoadFileType)downloadDFileType{
    self = [super init];
    if (self) {
        [self loadConfigurationInfo];
        self.downLoadModel                  = downLoadModel;
        self.downLoadModel.downloadDFileType= downloadDFileType;
    }
    return self;
}

- (void)loadConfigurationInfo{
    self.jianGeDate     = [NSDate date];
    self.oneEnter       = NO;
    self.jianGeDateSize = 0.0;
}

- (instancetype)initWithLoadImageTaskUrl:(NSURL *)taskUrl{
    self = [super init];
    if (self) {
        [self loadConfigurationInfo];
        self.downLoadModel = [[XXDownLoadModel alloc] init];
        self.downLoadModel.taskUrl          = taskUrl;
        self.downLoadModel.taskUrlString    = [taskUrl absoluteString];
        self.downLoadModel.total            = 0;
        self.downLoadModel.current          = 0;
        self.downLoadModel.downLoadStatus   = XXDownLoadStatusDownloading;
        self.downLoadModel.downloadDFileType= XXDownLoadFileTypeImage;
    }
    return self;
}


#pragma mark -
#pragma mark  NSURLSessionDataDelegate

/**
 接收到服务器端的响应的回调

 @param session 会话对象
 @param dataTask 数据任务
 @param response 响应信息
 @param completionHandler 完成处理回调-是否继续获取数据
 */
- (void)URLSession:(NSURLSession *)session dataTask:(nonnull NSURLSessionDataTask *)dataTask didReceiveResponse:(nonnull NSURLResponse *)response completionHandler:(nonnull void (^)(NSURLSessionResponseDisposition))completionHandler {
    
    self.downLoadModel.taskFileName     = response.suggestedFilename;
    if (self.downLoadModel.total == 0) {
        self.downLoadModel.total            = (NSInteger)response.expectedContentLength;
    }
    [self modelTheFirstinfoData];
    //得到需要保存数据的路径
    NSString *filePath = [self getFilePathWithFileName:self.downLoadModel.taskFileName];
    /*
     第一个参数:文件的路径
     第二个参数:YES 追加
     特点:如果该输出流指向的地址没有文件,那么会自动创建一个空的文件
     */
    self.stream = [[NSOutputStream alloc] initToFileAtPath:filePath append:YES];
    [self.stream open];
    if (self.downLoadModel.downLoadStatus == XXDownLoadStatusWaiting) {
        completionHandler(NSURLSessionResponseCancel);
    }else{
        completionHandler(NSURLSessionResponseAllow);
    }
}

/**
 请求的数据段

 @param session 会话对象
 @param dataTask 数据任务
 @param data 数据段 - 返回多次
 */
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    
    [self.stream write:[data bytes] maxLength:data.length];     // 写入数据到沙盒
    self.downLoadModel.current += data.length;                  // 获取下载进度，直接从沙盒中读取文件长度
    //NSLog(@"---%f",1.0 * self.downLoadModel.current / self.downLoadModel.total);
    
    NSDate *currentDate = [NSDate date];
    double time = [currentDate timeIntervalSinceDate:self.jianGeDate];
    self.jianGeDateSize = self.jianGeDateSize + (float)data.length;
    if (time >= 1 || !self.oneEnter) {
        self.oneEnter = YES;
        [self setDownloadProgressBlockInfo:currentDate];
    }
}


/**
 请求完成 -- 有可能失败

 @param session 会话对象
 @param task 任务
 @param error 异常
 */
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    
    self.dataTask = nil;                            // 清空
    [self.stream close];
    self.stream = nil;
    [session finishTasksAndInvalidate];             //防止session内存泄漏 -- 必走
    self.session = nil;
    [self setResumeDataInfo];
}


#pragma mark -
#pragma mark    方法实现


/**
 得到下载数据需要保存的路径

 @param fileName 下载文件的名称
 @return 保存的路径
 */
- (NSString *)getFilePathWithFileName:(NSString *)fileName{
    NSString *filePath = @"";
    switch (self.downLoadModel.downloadDFileType) {
        case XXDownLoadFileTypeVideo:
            filePath = [NSString stringWithFormat:@"%@%@",[XXDownloadPath getTheVideoCachePath],fileName];
            break;
        case XXDownLoadFileTypeImage:
            filePath = [NSString stringWithFormat:@"%@%@",[XXDownloadPath getTheImageCachePath],fileName];
            break;
        default:
            filePath = [NSString stringWithFormat:@"%@%@",[XXDownloadPath getTheTmpFilePathString],fileName];
            break;
    }
    return filePath;
}


/**
 创建下载任务 -- 准备下载
 */
- (void)createDownloadTask{
    NSInteger current = self.downLoadModel.current;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.downLoadModel.taskUrl];
    NSString *range = [NSString stringWithFormat:@"bytes=%zd-",current];
    [request setValue:range forHTTPHeaderField:@"Range"];
    if (!self.dataTask) {
        self.dataTask   = [self.session dataTaskWithRequest:request];
    }
}


/**
 开始下载
 */
- (void)start{
    [self updateDownLoadModelStatus:XXDownLoadStatusDownloading];       //修改模型的下载状态
    [self.dataTask resume];
}


/**
 暂停下载
 */
- (void)suspend{
    [self updateDownLoadModelStatus:XXDownLoadStatusSuspended];         //修改模型的下载状态
    [self.dataTask cancel];
}


/**
 取消下载 -- 删除任务信息
 */
- (void)cancel{
    
}


/**
 更新任务状态

 @param status 任务状态
 */
- (void)updateDownLoadModelStatus:(XXDownLoadStatus)status{
    self.downLoadModel.downLoadStatus = status;
}


/**
 保存下载信息数据
 */
- (void)setResumeDataInfo{
    NSInteger status = (NSInteger)1.0 * self.downLoadModel.current / self.downLoadModel.total;
    if (status == 1) {
        [self updateDownLoadModelStatus:XXDownLoadStatusCompleted];
        [self modelTheCompletedData];   //已完成
    }else{
        [self modelTheSuspendData];     //暂停中
    }
}


/**
 第一次请求回调保存信息
 */
- (void)modelTheFirstinfoData{
    if (self.downloadTaskDelegate && [self.downloadTaskDelegate respondsToSelector:@selector(downloadTaskObject:downloadTaskFirstDataInfo:)]) {
        [self.downloadTaskDelegate downloadTaskObject:self downloadTaskFirstDataInfo:self.downLoadModel];
    }
}

/**
 下载暂停启用回调
 */
- (void)modelTheSuspendData{
    if (self.downloadTaskDelegate && [self.downloadTaskDelegate respondsToSelector:@selector(downloadTaskObject:downloadTaskSuspendDataInfo:)]) {
        [self.downloadTaskDelegate downloadTaskObject:self downloadTaskSuspendDataInfo:self.downLoadModel];
    }
}

/**
 下载完成启用回调
 */
- (void)modelTheCompletedData{
    if (self.downloadTaskDelegate && [self.downloadTaskDelegate respondsToSelector:@selector(downloadTaskObject:downloadTaskCompletedDataInfo:)]) {
        [self.downloadTaskDelegate downloadTaskObject:self downloadTaskCompletedDataInfo:self.downLoadModel];
    }
}


/**
 返回当前的下载状态
 */
- (XXDownLoadStatus)getDownLoadModelStatus{
    return self.downLoadModel.downLoadStatus;
}


/**
 返回当前的模型
 */
- (XXDownLoadModel *)getDownLoadModel{
    return self.downLoadModel;
}


/**
 设置需要回调进度的函数信息

 @param currentDate 当前时间
 */
- (void)setDownloadProgressBlockInfo:(NSDate *)currentDate{
    //1. 获得文件的下载进度
    float schedule = 1.0 * self.downLoadModel.current / self.downLoadModel.total;
    NSString *scheduleString = [NSString stringWithFormat:@"%f",schedule];
    //计算总大小
    NSString *totalSize = [XXDataConversionUtil formatByteCount:(float)self.downLoadModel.total];
    //计算下载大小
    NSString *downloadSize = [XXDataConversionUtil formatByteCount:(float)self.downLoadModel.current];
    //计算下载速度
    NSString *shuduString = [XXDataConversionUtil formatByteCount:self.jianGeDateSize];
    shuduString = [NSString stringWithFormat:@"%@/s",shuduString];
    self.jianGeDateSize = 0.0;
    self.jianGeDate = currentDate;
    
    if (self.downloadTaskDelegate &&
        [self.downloadTaskDelegate respondsToSelector:@selector(downloadTaskObject:downloadProgressSchedule:downloadSize:totalSize:sudu:)])
    {
        [self.downloadTaskDelegate downloadTaskObject:self downloadProgressSchedule:scheduleString downloadSize:downloadSize totalSize:totalSize sudu:shuduString];
    }
}


/**
 得到下载的临时文件名称

 @param resumeDataString 暂停后的文件下载信息
 @return 临时文件名称
 */
- (NSString *)getTmpFilePathName:(NSString *)resumeDataString{
    
    if ([resumeDataString isEqualToString:@""] || resumeDataString == nil) {
        return @"";
    }
    NSString *tmpFilePathName = [resumeDataString componentsSeparatedByString:@"<key>NSURLSessionResumeInfoTempFileName</key>\n\t<string>"].lastObject;
    tmpFilePathName = [tmpFilePathName componentsSeparatedByString:@"</string>"].firstObject;
    
    return tmpFilePathName;
}


#pragma mark -
#pragma mark    getter/setter

- (NSURLSession *)session{
    if (_session == nil) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        //_session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"xxdownloadSessionConfiguration"] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}

@end
