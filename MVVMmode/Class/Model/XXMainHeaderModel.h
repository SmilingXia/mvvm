//
//  XXMainHeaderModel.h
//  MVVMmode
//
//  Created by xia on 2018/2/8.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XXMainHeaderBody;

@interface XXMainHeaderModel : NSObject

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
@property (nonatomic, strong) XXMainHeaderBody *showapi_res_body;


@end

@interface XXMainHeaderBody : NSObject

/**
 *  所有记录数
 */
@property (nonatomic, copy) NSString *allNum;

/**
 *  所有页数。每页20条。
 */
@property (nonatomic, copy) NSString *allPages;

/**
 *  当前第几页
 */
@property (nonatomic, copy) NSString *currentPage;

/**
 *  每页最多显示几条
 */
@property (nonatomic, copy) NSString *maxResult;

/**
 *  笑话条目内容
 */
@property (nonatomic, strong) NSArray *contentlist;


@end


@interface XXMainHeaderBodyOfContentlist :NSObject

/**
 *  生成时间
 */
@property (nonatomic, copy) NSString *ct;

/**
 *  笑话正文
 */
@property (nonatomic, copy) NSString *text;

/**
 *  笑话标题
 */
@property (nonatomic, copy) NSString *title;


/**
 获取内容列表中的标题
 
 @return 标题
 */
- (NSString *)getContentlistTitle;


/**
 获取内容列表中的内容
 
 @return 内容
 */
- (NSString *)getContentlistContent;


/**
 获取内容列表中的生成时间
 
 @return 生成时间
 */
- (NSString *)getContentlistCt;

@end





