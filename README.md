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
    ios项目中要配置对应的url scheme 和白名单
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
//分享 title：标题  text:内容 url:链接
WXShareModule.share({"title":"weex","text":"测试","url":"https://www.baidu.com"},function (ret) {
                var modal = weex.requireModule('modal')
                modal.toast({
                    message: JSON.stringify(ret),
                    duration: 0.7
                })
            });

```

  
