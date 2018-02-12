//
//  XXMainHeaderModel.m
//  MVVMmode
//
//  Created by xia on 2018/2/8.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import "XXMainHeaderModel.h"

@implementation XXMainHeaderModel

@end


@implementation XXMainHeaderBody

+ (NSDictionary *)objectClassInArray{
    return @{@"contentlist" : @"XXMainHeaderBodyOfContentlist"};
}

@end


@implementation XXMainHeaderBodyOfContentlist

- (NSString *)getContentlistTitle{
    return self.title;
}

- (NSString *)getContentlistContent{
    return self.text;
}

- (NSString *)getContentlistCt{
    return self.ct;
}

@end

