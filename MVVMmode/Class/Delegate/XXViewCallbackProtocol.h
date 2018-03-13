//
//  XXViewCallbackProtocol.h
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/13.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XXViewCallbackProtocol <NSObject>

@optional
- (void)withValueTransmission:(id)model;

@end
