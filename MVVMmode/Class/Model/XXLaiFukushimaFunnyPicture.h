//
//  XXLaiFukushimaFunnyPicture.h
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/9.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XXFunnyPictureBody;

@interface XXLaiFukushimaFunnyPicture : NSObject

/**
 *  易源返回标志,0为成功，其他为失败。
 */
@property (nonatomic, copy) NSString *showapi_res_code;

/**
 *  错误信息的展示
 */
@property (nonatomic, copy) NSString *showapi_res_error;

/**
 *  内容模型
 */
@property (nonatomic, strong) XXFunnyPictureBody *showapi_res_body;

@end



@interface XXFunnyPictureBody : NSObject

/**
 * 总数
 */
@property (nonatomic, copy) NSString *totalNum;

/**
 * 成功（0）
 */
@property (nonatomic, copy) NSString *ret_code;

/**
 * 列表
 */
@property (nonatomic, strong) NSArray *list;

@end


@interface XXFunnyPictureBodyList : NSObject

/**
 * 类别
 */
@property (nonatomic, copy) NSString *CLASS;

/**
 * 大图高度
 */
@property (nonatomic, copy) NSString *height;

/**
 * 大图宽
 */
@property (nonatomic, copy) NSString *width;

/**
 * 小图地址（宽度为230的图）
 */
@property (nonatomic, copy) NSString *sourceurl;

/**
 * 大图地址
 */
@property (nonatomic, copy) NSString *thumburl;

/**
 * 标题
 */
@property (nonatomic, copy) NSString *title;

/**
 * 来源
 */
@property (nonatomic, copy) NSString *url;


@end


