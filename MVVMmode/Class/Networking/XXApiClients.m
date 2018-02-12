//
//  XXApiClients.m
//  MVVMmode
//
//  Created by xia on 2018/2/8.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import "XXApiClients.h"

@implementation XXApiClients

+ (instancetype)instance{
    static dispatch_once_t onceToken;
    static XXApiClients *api = nil;
    dispatch_once(&onceToken, ^{
        api = [XXApiClients new];
    });
    return api;
}

- (instancetype)init{
    self = [super initWithKey:XX_APPID_VALUE appSecret:XX_SIGN_VALUE];
    return self;
}

- (void)getMainHeaderViewSource:(NSString *)page
                     andContent:(NSString *)content
                     andSuccess:(ReturnSuccess)success
                 andErrorString:(ReturnError)errorString{
    
    NSString *path = XX_XHDQ_URL;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    [formParams setValue:page forKey:@"page"];
    [formParams setValue:content forKey:@"content"];
    [self httpPost:CLOUDAPI_HTTP
              host:XX_HOST_URL
              path:path
        pathParams:formParams
   completionBlock:^(NSData *data, NSURLResponse *response, NSError *error) {
       if (data == nil || data.length < 1) {
           NSLog(@"错误了，请查看error");
           return errorString(@"获取数据失败");
       }
       NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
       success(dataDict);
    }];
}


@end
