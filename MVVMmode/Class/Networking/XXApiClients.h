//
//  XXApiClients.h
//  MVVMmode
//
//  Created by xia on 2018/2/8.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

//#import <XXNetworking/XXNetworking.h>
#import "XXBaseApiClient.h"

typedef void(^ReturnSuccess)(id success);
typedef void(^ReturnError)(NSString *errorString);

@interface XXApiClients : XXBaseApiClient

+ (instancetype) instance;
- (instancetype) init;

@property (nonatomic, copy) ReturnSuccess success;
@property (nonatomic, copy) ReturnError errorString;

/**
 获取笑话大全信息

 @param page 第几页
 @param content  一页显示个数
 @param success 成功返回
 @param errorString 错误返回
 */
- (void)getMainHeaderViewSource:(NSString *)page
                     andContent:(NSString *)content
                     andSuccess:(ReturnSuccess)success
                 andErrorString:(ReturnError)errorString;

/**
 获取来福岛搞笑图片信息
 */
- (void)getFukushimaFunnyPictureSuccess:(ReturnSuccess)success
                            ErrorString:(ReturnError)errorString;

@end
