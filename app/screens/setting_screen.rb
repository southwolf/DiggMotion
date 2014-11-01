class SettingScreen < PM::GroupedTableScreen
  title "设置"

  def table_data
    User.login? ? login_data : unlogin_data
  end

  def login_data
    [{
      title: '帐户',
      cells: [
        { title: '修改资料', action: :edit_profile },
        { title: '修改密码', action: :edit_password }
      ]
    },
    {
      title: '联系',
      cells: [
        { title: '关于我们', action: :about }
      ]
    },
    {
      cells: [
        { title: '退出登录', action: :logout }
      ]
    }]
  end

  def unlogin_data
    [{
      title: '帐户',
      cells: [
        { title: '登录', action: :login }
      ]
    },
    {
      title: '联系',
      cells: [
        { title: '关于我们', action: :about }
      ]
    }]
  end

  
  def about; open AboutScreen; end;
  
  def edit_profile
    open ModifyScreen
  end

  def edit_password
    open PasswordScreen
  end
  
  def login
    open_modal LoginScreen.new(nav_bar: true, delegate: self)
  end

  def login_success
    update_table_view_data login_data
  end

  def logout
    AVUser.logOut

    update_table_view_data unlogin_data
  end

end