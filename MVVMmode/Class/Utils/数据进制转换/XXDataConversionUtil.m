//
//  XXDataConversionUtil.m
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/26.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import "XXDataConversionUtil.h"

@implementation XXDataConversionUtil


const int GB = 1024 * 1024 * 1024;//定义GB的计算常量
const int MB = 1024 * 1024;//定义MB的计算常量
const int KB = 1024;//定义KB的计算常量
/**
 *  计算大小KB -- MB -- GB
 *
 *  @param KSize 文件的总大小
 */
+ (NSString *)formatByteCount:(float)KSize{
    NSString *zhSize;
    if (KSize / GB >= 1){
        zhSize = [NSString stringWithFormat:@"%0.2fGB",KSize/GB];
    }
    else if (KSize / MB >= 1){
        zhSize = [NSString stringWithFormat:@"%0.2fMB",KSize/MB];
    }
    else if (KSize / KB >= 1){
        zhSize = [NSString stringWithFormat:@"%0.2fKB",KSize/KB];
    }
    else{
        zhSize = [NSString stringWithFormat:@"%0.2fByte",KSize];
    }
    return zhSize;//显示Byte值
}

@end
