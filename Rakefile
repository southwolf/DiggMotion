# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'DiggMotion'

  app.version                = '0.1'
  app.short_version          = '0.1'
  app.identifier             = "com.domain.app_name"

  app.device_family                           = :iphone
  app.interface_orientations                  = [:portrait]
  # app.deployment_target                       = '8.0'
  app.icons                                   = ['icon.png', 'icon@2x.png', "icon-40@2x.png", "icon-60@2x.png", "icon-76@2x.png"]
  app.info_plist['CFBundleDevelopmentRegion'] = 'zh_CN'

  # push-notification
  app.entitlements['aps-environment'] = 'development'
  
  app.pods do
     pod 'SDWebImage'
     pod 'SVProgressHUD'
     # Bootstrop Style Button
     pod 'BButton'

  end
    
end
