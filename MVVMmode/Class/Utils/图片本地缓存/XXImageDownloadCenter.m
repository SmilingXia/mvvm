//
//  XXImageDownloadCenter.m
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/20.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import "XXImageDownloadCenter.h"
#import "XXDownloadPathManager.h"
#import "XXDownloadTaskObject.h"

@interface XXImageDownloadCenter ()<XXDownloadTaskObjectDelegate>

/**
 下载进度模型数组
 */
@property (nonatomic, strong) NSMutableArray   *imageDownloadModelArray;

@end

@implementation XXImageDownloadCenter

+ (XXImageDownloadCenter *)sharedImageDownload{
    static XXImageDownloadCenter *imageDownloadCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageDownloadCenter = [[XXImageDownloadCenter alloc] init];
    });
    return imageDownloadCenter;
}


#pragma mark -
#pragma mark    XXDownloadTaskObjectDelegate
/**
 下载完成保存
 */
- (void)downloadTaskObject:(XXDownloadTaskObject *)taskObject downloadTaskCompletedDataInfo:(XXDownLoadModel *)modelInfo {
    //3.保存下载信息
    [self setImagePlist:modelInfo.taskFileName andImageUrl:modelInfo.taskUrl];
    NSString *taskImageSavePath = [NSString stringWithFormat:@"%@%@",[XXDownloadPath getTheImageCachePath],modelInfo.taskFileName];
    UIImage *image = [UIImage imageWithContentsOfFile:taskImageSavePath];
    
    int modelIndex = [self returnModelIndex:modelInfo.taskUrlString];
    XXImageDownloadModel *imageDownloadModel = self.imageDownloadModelArray[modelIndex];
    if (imageDownloadModel.completionBlock) {
        imageDownloadModel.completionBlock(image);
        [self.imageDownloadModelArray removeObject:imageDownloadModel];
    }
}

/**
 下载进度回调
 */
- (void)downloadTaskObject:(XXDownloadTaskObject *)taskObject downloadProgressSchedule:(NSString *)schedule downloadSize:(NSString *)downloadSize totalSize:(NSString *)totalSize sudu:(NSString *)sudu{
    
    int modelIndex = [self returnModelIndex:[taskObject getDownLoadModel].taskUrlString];
    XXImageDownloadModel *imageDownloadModel = self.imageDownloadModelArray[modelIndex];
    if (imageDownloadModel.imageDownloadProgress) {
        imageDownloadModel.imageDownloadProgress([schedule floatValue], sudu);
    }
}


#pragma mark -
#pragma mark    method


/**
 判断该任务是否存在当前下载中

 @param urlString 任务地址
 @return YES\NO
 */
- (BOOL)isExistImageDownloadModelArray:(NSString *)urlString{
    BOOL exist = NO;
    for (XXImageDownloadModel *imageModel in self.imageDownloadModelArray) {
        if ([imageModel.imageUrlString isEqualToString:urlString]) {
            exist = YES;
        }
    }
    return exist;
}


/**
 得到当前下载对象的数组下标

 @param urlString 任务地址
 @return 下标
 */
- (int)returnModelIndex:(NSString *)urlString{
    int modelIndex = 0;
    for (XXImageDownloadModel *imageModel in self.imageDownloadModelArray) {
        if ([imageModel.imageUrlString isEqualToString:urlString]) {
            break;
        }
        modelIndex++;
    }
    return modelIndex;
}

/**
 设置下载的地址

 @param imageUrl 图片下载地址
 @param block 成功回调
 @param imageDownloadProgress 进度回调
 @return 单利引用
 */
- (XXImageDownloadCenter *)downloadImageWithUrl:(NSURL *)imageUrl
                                completionBlock:(DownloadImageBlock)block
                          imageDownloadProgress:(DownloadImageProgressBlock)imageDownloadProgress {
    //0.判断当前是否存在该缓存
    if ([self isExistImageDownloadModelArray:[imageUrl absoluteString]]) {
        return [XXImageDownloadCenter sharedImageDownload];
    }
    XXImageDownloadModel *imageModel    = [[XXImageDownloadModel alloc] init];
    imageModel.imageUrlString           = [imageUrl absoluteString];
    imageModel.completionBlock          = block;
    imageModel.imageDownloadProgress    = imageDownloadProgress;
    [self.imageDownloadModelArray addObject:imageModel];
    
    //1.判断是否下载过  -- 是否下载完成哦
    UIImage *image = [self completeImageFileWithUrl:imageUrl];
    if (image) {
        if (imageModel.completionBlock) {
            imageModel.completionBlock(image);
        }
        [self.imageDownloadModelArray removeObject:imageModel];
        return [XXImageDownloadCenter sharedImageDownload];
    }
    //进行下载
    XXDownloadTaskObject *taskObject = nil;
    taskObject = [[XXDownloadTaskObject alloc] initWithLoadImageTaskUrl:imageUrl];
    taskObject.downloadTaskDelegate = self;
    [taskObject createDownloadTask];
    [taskObject start];

    return [XXImageDownloadCenter sharedImageDownload];
}


/**
 根据图片本地地址 -- 网络地址 -- 缓存到本地

 @param imageFilePath 图片本地地址
 @param imageUrl 网络地址
 */
- (void)setImagePlist:(NSString *)imageFilePath andImageUrl:(NSURL *)imageUrl{
    NSMutableDictionary *plist = [NSMutableDictionary dictionaryWithContentsOfFile:[XXDownloadPath getTheImagePlistCachePath]];
    
    NSMutableDictionary *dic = [plist objectForKey:imageFilePath];
    if (!dic) {
        dic = [[NSMutableDictionary alloc] init];
    }
    [dic setObject:imageFilePath forKey:@"imageFilePath"];
    [plist setObject:dic forKey:[imageUrl absoluteString]];
    [plist writeToFile:[XXDownloadPath getTheImagePlistCachePath] atomically:false];
}

/**
 判断当前图片是否下载过

 @param imageUrl 图片URL地址
 @return image图片对象
 */
- (UIImage *)completeImageFileWithUrl:(NSURL *)imageUrl{
    UIImage *image = nil;
    NSMutableDictionary *plist = [NSMutableDictionary dictionaryWithContentsOfFile:[XXDownloadPath getTheImagePlistCachePath]];
    NSMutableDictionary *imageDict = [plist objectForKey:[imageUrl absoluteString]];
    if (imageDict) {
        NSArray *array = [[NSFileManager defaultManager] subpathsAtPath:[XXDownloadPath getTheImageCachePath]];
        for (NSString *pathStr in array) {
            if ([pathStr isEqualToString:imageDict[@"imageFilePath"]]) {
                NSString *imageSavePath = [NSString stringWithFormat:@"%@%@",[XXDownloadPath getTheImageCachePath],pathStr];
                image = [UIImage imageWithContentsOfFile:imageSavePath];
                //image = [UIImage imageNamed:imageSavePath];
                return image;
            }
        }
    }
    return image;
}


#pragma mark -
#pragma mark    getter/setter
- (NSMutableArray *)imageDownloadModelArray{
    if (_imageDownloadModelArray) {
        return _imageDownloadModelArray;
    }
    _imageDownloadModelArray = [NSMutableArray array];
    return _imageDownloadModelArray;
}


@end
