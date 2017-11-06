<template>
	<div class="conatiner">
		<text style="margin-bottom: 20px;">weex plugin examples66</text>
		<div @click="createAction" style="margin: 20px;padding:20px;background-color:#1ba1e2;color:#fff;"><text style="color:#fff">hello world</text></div>
		<div @click="getUserInfo" style="margin: 20px;padding:20px;background-color:#1ba1e2;color:#fff;"><text style="color:#fff">获取授权</text></div>
	</div>
</template>

<style>
	.container{
		flex: 1;
	}
</style>

<script>

    var WXShareModule = weex.requireModule('weexShareSdk');
    // 注册key    WeiXinAppKey：微信appkey WeiXinAppSecret:微信appSecret QQAppKey:qq appKey QQAppSecret: qq AppSecret
    WXShareModule.registerSDK({"WeiXinAppKey":"wx96405920c7dd745b","WeiXinAppSecret":"5c13ad649710aed6d9739c9bda05f5ec","QQAppKey":"101375075","QQAppSecret":"e90fa05ee1fdd96cd149811e9a800f00"},function(ret) {
        modal.toast({
            message: JSON.stringify(ret),
            duration: 0.7
        })
    });

	module.exports = {
		data: {
			value: '',
			index: 0,
			txtChange: ''
		},
		methods: {
			createAction: function() {
                //分享 title：标题  text:内容 url:链接
                WXShareModule.share({"title":"weex","text":"测试","url":"https://www.baidu.com","image":"scan"},function (ret) {
                    var modal = weex.requireModule('modal')
                    modal.toast({
                        message: JSON.stringify(ret),
                        duration: 0.7
                    })
                });

			},
			getUserInfo: function () {
                WXShareModule.getUserInfo('998',function (ret) {
                    var modal = weex.requireModule('modal')
                    modal.toast({
                        message: JSON.stringify(ret),
                        duration: 0.7
                    })
                });
            }

		}
	}
</script>