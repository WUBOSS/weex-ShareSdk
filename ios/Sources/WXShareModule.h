//
//  WXShareModule.h
//  WeexDemo
//
//  Created by zhanshu1 on 2017/10/9.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WeexSDK/WeexSDK.h>
@interface WXShareModule : NSObject<WXModuleProtocol>
@property(nonatomic,copy)WXModuleKeepAliveCallback callBack;


@end


