//
//  XXConstantNL.h
//  MVVMmode
//
//  Created by xia on 2018/2/8.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#pragma mark -
#pragma mark    请求相关 - 网络请求url

static NSString * const XX_APPID_KEY        =   @"showapi_appid";
static NSString * const XX_APPID_VALUE      =   @"52449";
static NSString * const XX_SIGN_KEY         =   @"showapi_sign";
static NSString * const XX_SIGN_VALUE       =   @"716cd440ca6142489330bf4adde20aaa";

static NSString * const XX_HOST_URL         =   @"http://route.showapi.com";

static NSString * const XX_XHDQ_URL         =   @"/341-1";          //笑话大全
static NSString * const XX_CYC_URL          =   @"/151-4";          //猜一猜
static NSString * const XX_LHD_GXTP_URL     =   @"/107-33";         //来福岛搞笑图片



//HTTP
static NSString* const CLOUDAPI_HTTP = @"http://";

//HTTPS
static NSString* const CLOUDAPI_HTTPS = @"https://";

/**
 * HTTP方法常量
 */


//GET
static NSString* const CLOUDAPI_GET = @"GET";

//POST
static NSString* const CLOUDAPI_POST = @"POST";

//PUT
static NSString* const CLOUDAPI_PUT = @"PUT";

//PATCH
static NSString* const CLOUDAPI_PATCH = @"PATCH";

//DELETE
static NSString* const CLOUDAPI_DELETE = @"DELETE";



#pragma mark -
#pragma mark    缓存相关

//图片缓存的plist文件名称
static NSString* const DOWNLOAD_IMAGE_PILIST_NAME = @"downloadImage.plist";

//视频缓存的plist文件名称
static NSString* const DOWNLOAD_VIDEO_PILIST_NAME = @"downloadVideo.plist";



