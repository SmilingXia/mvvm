//
//  XXLaiFukushimaFunnyPicture.m
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/9.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import "XXLaiFukushimaFunnyPicture.h"

@implementation XXLaiFukushimaFunnyPicture

@end

@implementation XXFunnyPictureBody

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : @"XXFunnyPictureBodyList"};
}

@end


@implementation XXFunnyPictureBodyList


+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"CLASS" : @"class"};
}

@end
