# coding: utf-8

Pod::Spec.new do |s|
  s.name         = "WeexShareSdk"
  s.version      = "0.0.2"
  s.summary      = "Weex shareSDK分享"

  s.description  = <<-DESC
                   Weex shareSDK分享
                   DESC

  s.homepage     = "https://github.com/WUBOSS/weex-ShareSdk"
  s.license = {
    :type => 'MIT',
    :text => <<-LICENSE
            copyright
    LICENSE
  }
  s.authors      = {
                     "WUBOSS" =>"1054258896@qq.com"
                   }
  s.platform     = :ios
  s.ios.deployment_target = "7.0"

  s.source       = { :git => 'https://github.com/WUBOSS/weex-ShareSdk.git', :tag => '0.0.2' }
  s.source_files  = "ios/Sources/*.{h,m,mm}"
  s.requires_arc = true
  s.dependency "WeexPluginLoader"
  s.dependency "WeexSDK"
  s.dependency "ShareSDK3/ShareSDKPlatforms/QQ"
  s.dependency "ShareSDK3/ShareSDKPlatforms/SinaWeibo"
  s.dependency "ShareSDK3/ShareSDKPlatforms/WeChat"
  s.dependency "ShareSDK3"
  s.dependency "ShareSDK3/ShareSDKUI"
end
