//
//  XXMainHeaderViewModel.h
//  MVVMmode
//
//  Created by xia on 2018/2/8.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXMainHeaderModel.h"

@interface XXMainHeaderViewModel : NSObject
/**
 *  message信号 -- success(数据更新成功) error(数据更新失败)
 */
@property (nonatomic, strong) NSString *message;

/**
 *  全部数据
 */
@property (nonatomic, strong) XXMainHeaderModel *mainHeaderModel;

/**
 *  内容数组
 */
@property (nonatomic, strong) NSArray *mainHeaderBodyOfContentArray;


/**
 *  当前下标对应的数据模型
 */
@property (nonatomic, strong) XXMainHeaderBodyOfContentlist *indexNumberItem;

/**
 得到单个数据模型

 @param indexNumber 列表中的下标
 @return 内容模型
 */
- (XXMainHeaderBodyOfContentlist *)getmMainHeaderBodyOfContentArrayOfobjectIndex:(int)indexNumber;


/**
 *  网络请求数据源 - 笑话
 */
- (void)getPostMainHeaderViewSource;

@end
