//
//  XXDataConversionUtil.h
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/26.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXDataConversionUtil : NSObject

/**
 *  计算大小KB -- MB -- GB -- 内存
 *
 *  @param KSize 数据大小
 */
+ (NSString *)formatByteCount:(float)KSize;

@end
