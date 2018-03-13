//
//  XXMainHeaderViewModel.m
//  MVVMmode
//
//  Created by xia on 2018/2/8.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import "XXMainHeaderViewModel.h"
#import "XXMainHeaderModel.h"
#import "XXLaiFukushimaFunnyPicture.h"

@interface XXMainHeaderViewModel()

@end

@implementation XXMainHeaderViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)getPostMainHeaderViewSource{
    [[XXApiClients instance] getMainHeaderViewSource:@"1" andContent:@"20" andSuccess:^(id success) {
        self.mainHeaderModel    = [XXMainHeaderModel mj_objectWithKeyValues:(NSDictionary *)success];
        self.mainHeaderBodyOfContentArray   = self.mainHeaderModel.showapi_res_body.contentlist;
        self.message            = @"success";
    } andErrorString:^(NSString *error) {
        self.mainHeaderModel                = nil;
        self.indexNumberItem                = nil;
        self.mainHeaderBodyOfContentArray   = nil;
        self.message                        = @"fail";
    }];
}

- (XXMainHeaderBodyOfContentlist *)getmMainHeaderBodyOfContentArrayOfobjectIndex:(int)indexNumber{
    if (indexNumber < self.mainHeaderBodyOfContentArray.count) {
        self.indexNumberItem    = self.mainHeaderBodyOfContentArray[indexNumber];
    }
    else{
        self.indexNumberItem    = [[XXMainHeaderBodyOfContentlist alloc] init];
    }
    return self.indexNumberItem;
}


@end
