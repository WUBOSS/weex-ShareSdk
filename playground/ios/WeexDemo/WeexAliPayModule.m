//
//  WeexAliPayModule.m
//  WeexDemo
//
//  Created by zhanshu on 2017/11/6.
//  Copyright © 2017年 taobao. All rights reserved.
//

#import "WeexAliPayModule.h"
#import "APOrderInfo.h"
#import "APRSASigner.h"
#import <AlipaySDK/AlipaySDK.h>
NSString * const WeexAliPayNotification=@"WeexAliPayNotification";
static NSString *appID;
static NSString *MprivateKey;
static NSString *appScheme;
@implementation WeexAliPayModule

@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(config:))
WX_EXPORT_METHOD(@selector(alipay:callBack:))
+(void)handleOpenURL:(NSURL *)url{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:WeexAliPayNotification object:self userInfo:resultDic];
        }];
        
       
    }
}
-(void)config:(NSDictionary *)dic
{
    if([dic isKindOfClass:[NSDictionary class]])
    {
        appID=[dic objectForKey:@"appID"];
        MprivateKey=[dic objectForKey:@"MprivateKey"];
        appScheme=[dic objectForKey:@"appScheme"];
    }
}

-(void)alipay:(NSDictionary *)param callBack:(WXModuleCallback)callBack
{
    self.callBack = callBack;
    if(![param isKindOfClass:[NSDictionary class]])
    {
        
        if(self.callBack)
            callBack(@{@"status":@"error",@"msg":@"参数不是josn"});
        
        return;
        
    }
    
    // 重要说明
    // 这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    // 真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    // 防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    
    
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = MprivateKey;
    NSString *rsaPrivateKey = @"";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
    {
        
        if(self.callBack)
            callBack(@{@"status":@"error",@"msg":@"缺少appId或者私钥,请检查参数设置"});
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    APOrderInfo* order = [APOrderInfo new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [APBizContent new];
    order.biz_content.body = [param objectForKey:@"body"];;
    order.biz_content.subject = [param objectForKey:@"title"];
    order.biz_content.out_trade_no = [param objectForKey:@"orderID"]; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount =[param objectForKey:@"price"]; //商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    APRSASigner* signer = [[APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
       
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payResult:) name:WeexAliPayNotification object:nil];
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            [self parseResult:resultDic];
        }];
    }
    else
    {
        if(self.callBack)
            callBack(@{@"status":@"error",@"msg":@"签名失败"});
    }
    
    
}
-(void)payResult:(NSNotification *)result
{
    [self parseResult:result.userInfo];
}
-(void)parseResult:(NSDictionary *)dic
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
     int state=[[dic objectForKey:@"resultStatus"] intValue];
    NSString *statestring;
    if (state == 9000) {
        statestring= @"支付成功";
        if(self.callBack)
        {
            self.callBack(@{@"status":@"success",@"msg":statestring});
            
        }
        //支付成功跳转到我的订单页面
    }else if (state==4000)
    {
        statestring= @"系统异常";
        if(self.callBack)
        {
            self.callBack(@{@"status":@"error",@"msg":statestring});
            
        }
    }
    else if (state==4001)
    {
        statestring= @"订单参数错误";
        if(self.callBack)
        {
            self.callBack(@{@"status":@"error",@"msg":statestring});
            
        }
    }
    else if (state ==6001)
    {
        statestring= @"用户取消支付";
        if(self.callBack)
        {
            self.callBack(@{@"status":@"error",@"msg":statestring});
            
        }
    }
    else if( state ==6002)
    {
        statestring= @"网络连接异常";
        if(self.callBack)
        {
            self.callBack(@{@"status":@"error",@"msg":statestring});
            
        }
    }else
    {
        statestring= @"未知错误";
        if(self.callBack)
        {
            self.callBack(@{@"status":@"error",@"msg":statestring});
            
        }
        
    }
    
    
}
-(void)dealloc
{
    NSLog(@"%s",__func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
