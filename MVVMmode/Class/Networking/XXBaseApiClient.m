//
//  XXBaseApiClient.m
//  XXNetworking
//
//  Created by xia on 2018/2/8.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import "XXBaseApiClient.h"
typedef void(^XXBaseCompletionBlock)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error);

@interface XXBaseApiClient()<NSURLSessionDelegate>

@property (nonatomic, strong)   NSMutableData           *data;
@property (nonatomic, strong)   NSURLResponse           *response;
@property (nonatomic, strong)   NSError                 *error;
@property (nonatomic, copy)     XXBaseCompletionBlock   completionBlock;

@end

@implementation XXBaseApiClient

@synthesize  appKey;
@synthesize  appSecret;

- (instancetype)initWithKey:(NSString *)appKey appSecret:(NSString *)appSecret{
    self = [super init];
    if (self) {
        self.appKey         = appKey;
        self.appSecret      = appSecret;
    }
    return self;
}

- (void)    httpPost:(NSString *)httpSchema
                host:(NSString *)host
                path:(NSString *)path
          pathParams:(NSDictionary *)pathParams
     completionBlock:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionBlock
{
    NSString *urlString             = [NSString stringWithFormat:@"%@%@",host,path];
    NSMutableURLRequest *request    = [self requestWithMethod:@"POST" URLString:urlString parameters:pathParams];
    self.completionBlock            = completionBlock;
    NSURLSessionConfiguration *cfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSOperationQueue    *queue      = [[NSOperationQueue alloc] init];
    NSURLSession *session           = [NSURLSession sessionWithConfiguration:cfig
                                                                    delegate:self
                                                               delegateQueue:queue];
    NSURLSessionDataTask *task      = [session dataTaskWithRequest:request];
    [task resume];
}

#pragma mark - ____________________________________________________________
#pragma mark  NSURLSessionDelegate代理方法实现

#pragma mark - 当接收到服务器端的响应时的回调方法（response 第二次握手）
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    NSHTTPURLResponse *res      = (NSHTTPURLResponse *)response;
    self.response               = response;
    NSLog(@"请求URL地址 %@",response.URL);
    if(res.statusCode == 200){
        self.data = [[NSMutableData alloc]init];
        completionHandler(NSURLSessionResponseAllow);
    }
}

#pragma mark - 接收到服务器端传输的数据时的回调方法
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    [self.data appendData:data];
    NSLog(@"接收到传输数据");
}

#pragma mark - 网络请求结束
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    //id objectData = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
    //NSLog(@"请求数据    %@",objectData);
    self.completionBlock(self.data,self.response,self.error);
    //存缓存 --
    
    //防止session内存泄漏 -- 必走
    [session finishTasksAndInvalidate];
}

#pragma mark - 网络请求重定向
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler
{
    
}




#pragma mark - ____________________________________________________________
#pragma mark  组装请求NSMutableURLRequest
- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(NSDictionary *)parameters{
    NSURL *url = [NSURL URLWithString:URLString];
    NSMutableURLRequest *mutableRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    mutableRequest.HTTPMethod   = method;
    mutableRequest.HTTPBody     = [self getHTTPBody:parameters];
    if ([method isEqualToString:@"GET"]) {
        mutableRequest.cachePolicy  = NSURLRequestReturnCacheDataElseLoad;
    }
    return mutableRequest;
}

#pragma mark - 组装请求体（setHTTPBody）(body)
- (NSData *)getHTTPBody:(NSDictionary *)pathParamsDict{
    NSMutableString *str    = [NSMutableString string];
    [str appendFormat:@"%@=%@&", XX_APPID_KEY, self.appKey];
    [str appendFormat:@"%@=%@&", XX_SIGN_KEY, self.appSecret];
    for (NSString *key in pathParamsDict) {
        [str appendFormat:@"%@=%@&", key, pathParamsDict[key]];
    }
    NSData *body = [str dataUsingEncoding:NSUTF8StringEncoding];
    return body;
}



#pragma mark - ____________________________________________________________
#pragma mark 自定义请求缓存 -- 取缓存














@end
