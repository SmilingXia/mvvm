//
//  XXLaiFuKushimaTableViewModel.m
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/13.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import "XXLaiFuKushimaTableViewModel.h"

@interface XXLaiFuKushimaTableViewModel ()

@end

@implementation XXLaiFuKushimaTableViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)getFukushimaFunnyPicture{
    [[XXApiClients instance] getFukushimaFunnyPictureSuccess:^(id success) {
        XXLaiFukushimaFunnyPicture *pictureVO   = [XXLaiFukushimaFunnyPicture mj_objectWithKeyValues:(NSDictionary *)success];
        _funnyPictureModel                      = pictureVO;
        _funnyPictureBodyArray                  = pictureVO.showapi_res_body.list;
        _funnyPictureBlock(_funnyPictureBodyArray);
    } ErrorString:^(NSString *errorString) {
        _errorMessige(errorString);
    }];
}

- (XXFunnyPictureBodyList *)getFunnyPictureBodyListWithIndex:(int)index{
    XXFunnyPictureBodyList *bodyList = _funnyPictureBodyArray[index];
    return bodyList;
}

@end
