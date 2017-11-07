//
//  WeexAliPayModule.h
//  WeexDemo
//
//  Created by zhanshu on 2017/11/6.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WeexSDK/WeexSDK.h>
CG_EXTERN NSString * const WeexAliPayNotification;
@interface WeexAliPayModule : NSObject<WXModuleProtocol>
+(void)handleOpenURL:(NSURL *)url;

@property(nonatomic,copy)WXModuleCallback callBack;
@end


