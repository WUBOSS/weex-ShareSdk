# weex-ShareSdk
weex-ShareSdk是一个weex分享插件， 可以通过weexpack快速集成，可以丰富weex功能

支持的weexpack版本： >= 0.2.0
支持的WeexSDK版本： >= 0.10.0

# 功能

# 快速使用
- 通过weexpack初始化一个测试工程 weextest
   ```
   weexpack create weextest
   ```
- 添加ios平台
  ```
  weexpack platform add ios
  ```
- 添加android平台
  ```
  weexpack platform add android
  ```
- 添加插件
  ```
  weexpack plugin add weex-sharesdk
  ```
# 项目地址
[github](https://github.com/WUBOSS/weex-ShareSdk.git)

# 已有工程集成
## iOS集成插件WeexShareSdk
- 命令行集成
  ```
  weexpack plugin add weex-sharesdk
  ```
- 手动集成
  在podfile 中添加
  ```
  pod 'WeexShareSdk'
  ```
- api
```
    ios项目中要配置对应的url scheme 和白名单 MOBAppKey和MOBAppSecret
```

```javascript


var WXShareModule = weex.requireModule('weexShareSdk');
// 注册key    WeiXinAppKey：微信appkey WeiXinAppSecret:微信appSecret QQAppKey:qq appKey QQAppSecret: qq AppSecret
WXShareModule.registerSDK({"WeiXinAppKey":"wxfeb76ead8897a5ae","WeiXinAppSecret":"47386f68c9627ba55cebfc98283f74b6","QQAppKey":"1105424297","QQAppSecret":"Pp45uyixguxIMhk5"},function(ret) {
        modal.toast({
            message: JSON.stringify(ret),
            duration: 0.7
        })
    });
//分享 title：标题  text:内容 url:链接 image:imagename
 WXShareModule.share({"title":"weex","text":"测试","url":"https://www.baidu.com","image":"weex"},function (ret) {
                    var modal = weex.requireModule('modal')
                    modal.toast({
                        message: JSON.stringify(ret),
                        duration: 0.7
                    })
                });
// ret {"status":"cancel","msg":"取消"}

//status: success 成功 error:错误 cancel:取消
//msg:错误信息



```
```text
    /** typedef NS_ENUM(NSUInteger, SSDKPlatformType){
        /**
         *  未知
         */
        SSDKPlatformTypeUnknown             = 0,
        /**
         *  新浪微博
         */
        SSDKPlatformTypeSinaWeibo           = 1,
        /**
         *  腾讯微博
         */
        SSDKPlatformTypeTencentWeibo        = 2,
        /**
         *  豆瓣
         */
        SSDKPlatformTypeDouBan              = 5,
        /**
         *  QQ空间
         */
        SSDKPlatformSubTypeQZone            = 6,
        /**
         *  人人网
         */
        SSDKPlatformTypeRenren              = 7,
        /**
         *  开心网
         */
        SSDKPlatformTypeKaixin              = 8,
        /**
         *  Facebook
         */
        SSDKPlatformTypeFacebook            = 10,
        /**
         *  Twitter
         */
        SSDKPlatformTypeTwitter             = 11,
        /**
         *  印象笔记
         */
        SSDKPlatformTypeYinXiang            = 12,
        /**
         *  Google+
         */
        SSDKPlatformTypeGooglePlus          = 14,
        /**
         *  Instagram
         */
        SSDKPlatformTypeInstagram           = 15,
        /**
         *  LinkedIn
         */
        SSDKPlatformTypeLinkedIn            = 16,
        /**
         *  Tumblr
         */
        SSDKPlatformTypeTumblr              = 17,
        /**
         *  邮件
         */
        SSDKPlatformTypeMail                = 18,
        /**
         *  短信
         */
        SSDKPlatformTypeSMS                 = 19,
        /**
         *  打印
         */
        SSDKPlatformTypePrint               = 20,
        /**
         *  拷贝
         */
        SSDKPlatformTypeCopy                = 21,
        /**
         *  微信好友
         */
        SSDKPlatformSubTypeWechatSession    = 22,
        /**
         *  微信朋友圈
         */
        SSDKPlatformSubTypeWechatTimeline   = 23,
        /**
         *  QQ好友
         */
        SSDKPlatformSubTypeQQFriend         = 24,
        /**
         *  Instapaper
         */
        SSDKPlatformTypeInstapaper          = 25,
        /**
         *  Pocket
         */
        SSDKPlatformTypePocket              = 26,
        /**
         *  有道云笔记
         */
        SSDKPlatformTypeYouDaoNote          = 27,
        /**
         *  Pinterest
         */
        SSDKPlatformTypePinterest           = 30,
        /**
         *  Flickr
         */
        SSDKPlatformTypeFlickr              = 34,
        /**
         *  Dropbox
         */
        SSDKPlatformTypeDropbox             = 35,
        /**
         *  VKontakte
         */
        SSDKPlatformTypeVKontakte           = 36,
        /**
         *  微信收藏
         */
        SSDKPlatformSubTypeWechatFav        = 37,
        /**
         *  易信好友
         */
        SSDKPlatformSubTypeYiXinSession     = 38,
        /**
         *  易信朋友圈
         */
        SSDKPlatformSubTypeYiXinTimeline    = 39,
        /**
         *  易信收藏
         */
        SSDKPlatformSubTypeYiXinFav         = 40,
        /**
         *  明道
         */
        SSDKPlatformTypeMingDao             = 41,
        /**
         *  Line
         */
        SSDKPlatformTypeLine                = 42,
        /**
         *  WhatsApp
         */
        SSDKPlatformTypeWhatsApp            = 43,
        /**
         *  KaKao Talk
         */
        SSDKPlatformSubTypeKakaoTalk        = 44,
        /**
         *  KaKao Story
         */
        SSDKPlatformSubTypeKakaoStory       = 45,
        /**
         *  Facebook Messenger
         */
        SSDKPlatformTypeFacebookMessenger   = 46,
        /**
         *  支付宝好友
         */
        SSDKPlatformTypeAliPaySocial        = 50,
        /**
         *  支付宝朋友圈
         */
        SSDKPlatformTypeAliPaySocialTimeline= 51,
        /**
         *  钉钉
         */
        SSDKPlatformTypeDingTalk            = 52,
        /**
         *  youtube
         */
        SSDKPlatformTypeYouTube             = 53,
        /**
         *  美拍
         */
        SSDKPlatformTypeMeiPai              = 54,
        /**
         *  易信
         */
        SSDKPlatformTypeYiXin               = 994,
        /**
         *  KaKao
         */
        SSDKPlatformTypeKakao               = 995,
        /**
         *  印象笔记国际版
         */
        SSDKPlatformTypeEvernote            = 996,
        /**
         *  微信平台,
         */
        SSDKPlatformTypeWechat              = 997,
        /**
         *  QQ平台
         */
        SSDKPlatformTypeQQ                  = 998,
        /**
         *  任意平台
         */
        SSDKPlatformTypeAny                 = 999
    };
    */

```
```javascript
// 获取授权信息
//997 :对应平台枚举 997是微信
 WXShareModule.getUserInfo('997',function (ret) {
                    var modal = weex.requireModule('modal')
                    modal.toast({
                        message: JSON.stringify(ret),
                        duration: 0.7
                    })
                });
  
//ret {"state":number,"user":josn,"error":josn}user用户信息，error:错误信息
  //  SSDKResponseStateSuccess    = 1, 成功
    
   
   // SSDKResponseStateFail       = 2,失败
    
    
  //  SSDKResponseStateCancel     = 3,取消

```



  
