//
//  XXBaseApiClient.h
//  XXNetworking
//
//  Created by xia on 2018/2/8.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXBaseApiClient : NSObject{
    /**
     *  Api绑定的的AppKey
     */
    NSString* appKey;
    
    /**
     *  Api绑定的的AppSecret
     */
    NSString* appSecret;
}

@property (nonatomic) NSString* appKey;
@property (nonatomic) NSString* appSecret;
@property (nonatomic, strong) NSURLSession *requestSession;

/**
 初始化

 @param appKey 应用的key
 @param appSecret 应用的加密
 @return 对象
 */
-(instancetype) initWithKey:(NSString *) appKey
                  appSecret:(NSString *) appSecret;


/**
 * 以POST的方法发送HTTP请求
 * 请求Body为表单数据
 
 @param httpSchema 使用HTTP还是HTTPS调用
 @param host 请传入主机域名
 @param path 域名后缀
 @param pathParams Api定义中的path参数键值对
 @param completionBlock 回调函数
 */
-(void)      httpPost:(NSString *) httpSchema
                 host:(NSString *) host
                 path:(NSString *) path
           pathParams:(NSDictionary *) pathParams
      completionBlock:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionBlock;

@end
