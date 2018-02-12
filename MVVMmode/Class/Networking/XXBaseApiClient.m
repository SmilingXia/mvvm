//
//  XXBaseApiClient.m
//  XXNetworking
//
//  Created by xia on 2018/2/8.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import "XXBaseApiClient.h"

@implementation XXBaseApiClient

@synthesize  appKey;
@synthesize  appSecret;

- (instancetype)initWithKey:(NSString *)appKey appSecret:(NSString *)appSecret{
    self = [super init];
    if (self) {
        self.appKey = appKey;
        self.appSecret = appSecret;
    }
    return self;
}

- (void)    httpPost:(NSString *)httpSchema
                host:(NSString *)host
                path:(NSString *)path
          pathParams:(NSDictionary *)pathParams
     completionBlock:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionBlock{
    
    NSMutableString *str    = [NSMutableString string];
    [str appendFormat:@"%@=%@&", @"showapi_appid", self.appKey];
    [str appendFormat:@"%@=%@&", @"showapi_sign", self.appSecret];
    for (NSString * key in pathParams) {
        [str appendFormat:@"%@=%@&", key, pathParams[key]];
    }
    NSData *body            = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSString *urlString     = [NSString stringWithFormat:@"%@%@",host,path];
    NSURL *URL              = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:body];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",object);
            completionBlock(data,response,error);
        }else {
            NSLog(@"请求失败");
            completionBlock(nil,response,error);
        }
    }];
    [task resume];
}


@end
