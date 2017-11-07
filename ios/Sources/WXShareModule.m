//
//  WXShareModule.m
//  WeexDemo
//
//  Created by zhanshu1 on 2017/10/9.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import "WXShareModule.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#import <ShareSDKUI/ShareSDKUI.h>
#import <WeexPluginLoader/WeexPluginLoader.h>
@implementation WXShareModule
@synthesize weexInstance;
WX_PlUGIN_EXPORT_MODULE(weexShareSdk, WXShareModule)
WX_EXPORT_METHOD(@selector(registerSDK:callback:))
WX_EXPORT_METHOD(@selector(share:callback:))
WX_EXPORT_METHOD(@selector(getUserInfo:callback:))
- (void)getUserInfo:(NSString *)param callback:(WXModuleCallback)callback
{
    [ShareSDK cancelAuthorize:param.intValue];
    [ShareSDK getUserInfo:param.intValue
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
               if(state==SSDKResponseStateSuccess)
               {
                   if(callback)
                   callback(@{@"state":@(state),@"user":user.rawData});
                   
               }
               else if (state==SSDKResponseStateFail)
              
               {
                   if(callback)
                   callback(@{@"state":@(state),@"error":error.userInfo
                              });
               }
               
               else if (state==SSDKResponseStateCancel)
               {
                   if(callback)
                   callback(@{@"state":@(state),@"error":error.userInfo});
               }
               
               
           }];
}
- (void)registerSDK:(NSDictionary *)param callback:(WXModuleKeepAliveCallback)callback
{
    self.callBack = callback;
    if(![param objectForKey:@"WeiXinAppKey"])
    {
        if(self.callBack)
        self.callBack(@{@"status":@"error",@"msg":@"微信WeiXinAppKey参数没有"},NO);
      
    }
    if(![param objectForKey:@"WeiXinAppSecret"])
    {
        if(self.callBack)
        self.callBack(@{@"status":@"error",@"msg":@"微信WeiXinAppSecret参数没有"},NO);
     
    }
    if(![param objectForKey:@"QQAppKey"])
    {
        if(self.callBack)
        self.callBack(@{@"status":@"error",@"msg":@"QQAppKey参数没有"},NO);
      
    }
    if(![param objectForKey:@"QQAppSecret"])
    {
        if(self.callBack)
        self.callBack(@{@"status":@"error",@"msg":@"QQAppSecret参数没有"},NO);
        
    }
    [ShareSDK registerActivePlatforms:@[@(SSDKPlatformSubTypeWechatSession),@(SSDKPlatformSubTypeWechatTimeline),@(SSDKPlatformSubTypeQQFriend)] onImport:^(SSDKPlatformType platformType) {
        switch (platformType)
                 {
                     case SSDKPlatformTypeWechat:
                         [ShareSDKConnector connectWeChat:[WXApi class]];
                         break;
                     case SSDKPlatformTypeQQ:
                         [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                         break;
                     default:
                         break;
                 }

    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        switch (platformType)
                 {
                     case SSDKPlatformTypeWechat:
                         [appInfo SSDKSetupWeChatByAppId:[param objectForKey:@"WeiXinAppKey"]
                                               appSecret:[param objectForKey:@"WeiXinAppSecret"]  ];
                         break;
                     case SSDKPlatformTypeQQ:
                         [appInfo SSDKSetupQQByAppId:[param objectForKey:@"QQAppKey"]
                                              appKey:[param objectForKey:@"QQAppSecret"]
                                            authType:SSDKAuthTypeBoth];
                         break;
                     default:
                         break;
                 }
    }];
    
    
}
- (void)share:(NSDictionary *)param callback:(WXModuleCallback)callback
{
    
    
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:[param objectForKey:@"text"]
                                         images:[UIImage imageNamed:[param objectForKey:@"image"]]
                                            url:[NSURL URLWithString:[param objectForKey:@"url"]]
                                          title:[param objectForKey:@"title"]
                                           type:SSDKContentTypeAuto];
        //有的平台要客户端分享需要加此方法，例如微博
        [shareParams SSDKEnableUseClientShare];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil  items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               if(callback)
                               callback(@{@"status":@"success"});
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               if(callback)
                                callback(@{@"status":@"error",@"msg":[NSString stringWithFormat:@"%@",error]});
                               break;
                           }
                           case SSDKResponseStateCancel:
                               if(callback)
                               callback(@{@"status":@"cancel",@"msg":@"取消"});
                               break;
                           default:
                               
                               break;
                       }
                   }
         ];
}
    



@end

