class AppDelegate < PM::Delegate
  status_bar true, animation: :none

  def on_load(app, options)
    init_leancloud
    
    UINavigationBar.appearance.tintColor    = '#c6333b'.uicolor
    # UIView.appearance.setTintColor(UIColor.whiteColor)

    open HomeScreen.new(nav_bar: true)
  end

  # 初始化LeanCloud SDK
  def init_leancloud
    app_id   = "f6ox55orfj78cayhp0pgdcyoqk7vzzrm85tb2afn0fdwazm9"
    app_key  = "599j7rx6s3qs4jud6w1nis3ah2aymxnjcgiogfrh4wdx47wg" 
    
    LeanMotion::Config.init(app_id, app_key)
    LeanMotion::Config.channel 'Develop'
  end

end

