//
//  XXDownloadPathManager.m
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/20.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import "XXDownloadPathManager.h"

@interface XXDownloadPathManager ()

/**
 * 缓存图片文件路径
 */
@property (nonatomic, copy) NSString *downloadImagePath;

/**
 * 缓存图片plist路径
 */
@property (nonatomic, copy) NSString *downloadImagePlistPath;

/**
 * 缓存视频文件路径
 */
@property (nonatomic, copy) NSString *downloadVideoPath;

/**
 * 缓存视频plist路径
 */
@property (nonatomic, copy) NSString *downloadVideoPlistPath;

@end

@implementation XXDownloadPathManager

+ (XXDownloadPathManager *)sharedDownloadPathManager{
    static XXDownloadPathManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XXDownloadPathManager alloc] init];
    });
    return manager;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSString *)getTheImageCachePath{
    if (_downloadImagePath == nil) {
        _downloadImagePath = [NSString stringWithFormat:@"%@/Library/%@/", NSHomeDirectory(),@"DownloadImage"];
        [[NSFileManager defaultManager] createDirectoryAtPath:_downloadImagePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return _downloadImagePath;
}

- (NSString *)getTheImagePlistCachePath{
    if (_downloadImagePlistPath == nil) {
        NSString *record = [NSString stringWithFormat:@"%@/Library/DownloadImage/",NSHomeDirectory()];
        _downloadImagePlistPath = [record stringByAppendingString:DOWNLOAD_IMAGE_PILIST_NAME];
        if (![[NSFileManager defaultManager] fileExistsAtPath:record]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:record withIntermediateDirectories:YES attributes:nil error:nil];
        }
        if (![[NSFileManager defaultManager] fileExistsAtPath:_downloadImagePlistPath]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic writeToFile:_downloadImagePlistPath atomically:YES];
        }
    }
    return _downloadImagePlistPath;
}


- (NSString *)getTheVideoCachePath{
    if (_downloadVideoPath == nil) {
        _downloadVideoPath = [NSString stringWithFormat:@"%@/Library/%@/", NSHomeDirectory(),@"DownloadVideo"];
        [[NSFileManager defaultManager] createDirectoryAtPath:_downloadVideoPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return _downloadVideoPath;
}

- (NSString *)getTheVideoPlistCachePath{
    if (_downloadVideoPlistPath == nil) {
        NSString *record = [NSString stringWithFormat:@"%@/Library/DownloadVideo/",NSHomeDirectory()];
        _downloadVideoPlistPath = [record stringByAppendingString:DOWNLOAD_VIDEO_PILIST_NAME];
        if (![[NSFileManager defaultManager] fileExistsAtPath:record]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:record withIntermediateDirectories:YES attributes:nil error:nil];
        }
        if (![[NSFileManager defaultManager] fileExistsAtPath:_downloadVideoPlistPath]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic writeToFile:_downloadVideoPlistPath atomically:YES];
        }
    }
    return _downloadVideoPlistPath;
}

#pragma mark - 返回临时文件夹
- (NSString *)getTheTmpFilePathString{
    return [NSString stringWithFormat:@"%@/%@/", NSHomeDirectory(), @"tmp"];
}


@end
