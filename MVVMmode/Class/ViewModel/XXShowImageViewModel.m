//
//  XXShowImageViewModel.m
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/16.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import "XXShowImageViewModel.h"

@interface XXShowImageViewModel ()

@property (nonatomic, strong) NSDictionary   *modelDictionary;

@end

@implementation XXShowImageViewModel

- (instancetype)initWidtDictionary:(NSDictionary *)modelDict{
    self = [super init];
    if (self) {
        _modelDictionary = modelDict.mutableCopy;
    }
    return self;
}

@end
