package org.weex.plugin.weexsharesdk;

import com.alibaba.weex.plugin.annotation.WeexModule;
import com.taobao.weex.annotation.JSMethod;
import com.taobao.weex.bridge.JSCallback;
import com.taobao.weex.common.WXModule;

@WeexModule(name = "weexShareSdk")
public class WeexShareSdkModule extends WXModule {
    
    //sync ret example
    @JSMethod
    public String syncRet(String param) {
        return param;
    }

    //async ret example
    @JSMethod
    public void asyncRet(String param, JSCallback callback) {
        callback.invoke(param);
    }
}