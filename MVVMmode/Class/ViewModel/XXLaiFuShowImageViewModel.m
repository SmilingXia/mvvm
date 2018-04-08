//
//  XXLaiFuShowImageViewModel.m
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/13.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import "XXLaiFuShowImageViewModel.h"

@interface XXLaiFuShowImageViewModel ()

/**
 * 数据模型
 */
@property (nonatomic, strong) XXFunnyPictureBodyList   *funnyPictureBodyItemModel;

@end

@implementation XXLaiFuShowImageViewModel

- (instancetype)initWitdhModel:(XXFunnyPictureBodyList *)model{
    self = [super init];
    if (self) {
        _funnyPictureBodyItemModel = model;
    }
    return self;
}

- (NSDictionary *)getViewImageUrlAndTitle{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSString *imageUrlString = _funnyPictureBodyItemModel.thumburl;
    NSURL *imageUrl = [NSURL URLWithString:imageUrlString];
    [dict setObject:imageUrl forKey:@"imageUrl"];
    [dict setObject:_funnyPictureBodyItemModel.title forKey:@"title"];
    
    return dict;
}

@end
