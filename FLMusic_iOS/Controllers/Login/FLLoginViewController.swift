//
//  FLLoginViewController.swift
//  FLMusic_iOS
//
//  Created by 冯里 on 2018/5/10.
//  Copyright © 2018年 fengli. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

class FLLoginViewController: FLBaseViewController {
    
    private var userField: UITextField!
    private var passwordField: UITextField!
    private var loginBtn: UIButton!
    private var errorLabel: UILabel!
    
    private lazy var viewModel: FLLoginViewModel = {
        return FLLoginViewModel(userField.reactive.continuousTextValues, passwordField.reactive.continuousTextValues)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        bindViewModel()
    }
    
    func bindViewModel() {
        
        errorLabel.reactive.text <~ Signal.combineLatest(viewModel.userNameSignal, viewModel.passWordSignal).map({ (username, password) -> String in
            return (username ?? "").count == 0 ? "请输入用户名" : ((password ?? "").count == 0 ? "请输入密码" : "")
        })
        loginBtn.reactive.isEnabled <~ viewModel.vaildSignal
        loginBtn.reactive.backgroundColor <~ viewModel.colorSignal
        loginBtn.reactive.pressed = CocoaAction<UIButton>.init(viewModel.loginAction){
            [unowned self] some in

            return (self.userField.text!, self.passwordField.text!)
        }
        viewModel.loginAction.values.observeValues { (success) in
            print("是否成功： \(success)")
        }
        viewModel.loginAction.errors.observeValues { (_) in
            print("失败")
        }

    }
    
    // MARK: - UI
    func createUI() {
        // Back
        let bgImgView = UIImageView.init(frame: self.view.bounds)
        bgImgView.contentMode = .scaleAspectFill
        self.view .addSubview(bgImgView)
        let image = UIImage.coreBlur(inputImage: #imageLiteral(resourceName: "login_bg3.jpg"), blurNumber: 8)
        bgImgView.image = image
        
        // log
        let logImage = UIImageView.init()
        self.view.addSubview(logImage)
        logImage.contentMode = .scaleAspectFit
        logImage.snp.makeConstraints { (make) in
            make.width.height.equalTo(kAutoSize(size: 100))
            make.top.equalTo(self.view).offset(kAutoSize(size: 70))
            make.centerX.equalTo(self.view)
        }
        logImage.image = #imageLiteral(resourceName: "login_music_icon")
        
        // desc
        let descLabel = UILabel.init()
        self.view.addSubview(descLabel)
        descLabel.text = "爱音乐\n更爱生活"
        descLabel.font = kAutoFont(size: 20)
        descLabel.textColor = UIColor.white
        descLabel.textAlignment = .center
        descLabel.numberOfLines = 2
        descLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(logImage)
            make.top.equalTo(logImage.snp.bottom).offset(kAutoSize(size: 15))
        }
        
        // error label
        errorLabel = UILabel()
        self.view.addSubview(errorLabel)
        errorLabel.font = kNAutoFont(size: 15)
        errorLabel.textColor = UIColor.rgbColor(red: 23, green: 200, blue: 23)
        errorLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(descLabel.snp.bottom).offset(kAutoSize(size: 10))
        }
        
        // input back
        let inputBack = UIView.init()
        self.view.addSubview(inputBack)
        inputBack.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        inputBack.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(descLabel.snp.bottom).offset(kAutoSize(size: 40))
            make.left.equalTo(self.view).offset(kAutoSize(size: 40))
            make.height.equalTo(kAutoSize(size: kAutoSize(size: 130)))
        }
        inputBack.layer.cornerRadius = kAutoSize(size: 10)
        
        // user name
        
        let userIcon = UIImageView.init()
        userIcon.image = #imageLiteral(resourceName: "login_user")
        userIcon.contentMode = .scaleAspectFit
        inputBack.addSubview(userIcon)
        userIcon.snp.makeConstraints { (make) in
            make.width.height.equalTo(kAutoSize(size: 20))
            make.centerY.equalTo(inputBack.snp.bottom).multipliedBy(1/4.0)
            make.left.equalTo(inputBack).offset(kAutoSize(size: 15))
        }
        
        
        userField = UITextField.init()
        inputBack.addSubview(userField)
        userField.snp.makeConstraints { (make) in
            make.left.equalTo(userIcon.snp.right).offset(kAutoSize(size: 10))
            make.right.equalTo(inputBack).offset(-kAutoSize(size: 15))
            make.height.equalTo(kAutoSize(size: 40))
            make.centerY.equalTo(userIcon)
        }
        userField.font = kAutoFont(size: 18)
        let placeholder = NSMutableAttributedString.init(string: "请输入用户名或邮箱", attributes: [NSAttributedStringKey.foregroundColor : UIColor.rgbColor(red: 93, green: 82, blue: 90)])
        userField.attributedPlaceholder = placeholder
        userField.keyboardType = .emailAddress
        userField.clearButtonMode = .whileEditing
        
        
        // pass word
        let passwordIcon = UIImageView()
        passwordIcon.image = #imageLiteral(resourceName: "login_password")
        passwordIcon.contentMode = .scaleAspectFit
        inputBack.addSubview(passwordIcon)
        passwordIcon.snp.makeConstraints { (make) in
            make.width.left.height.equalTo(userIcon)
            make.centerY.equalTo(inputBack.snp.bottom).multipliedBy(3/4.0)
        }
        
        passwordField = UITextField()
        inputBack.addSubview(passwordField)
        passwordField.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(userField)
            make.centerY.equalTo(passwordIcon)
        }
        passwordField.font = userField.font
        let passPlaceholder = NSMutableAttributedString.init(string: "请输入密码", attributes: [NSAttributedStringKey.foregroundColor : UIColor.rgbColor(red: 93, green: 82, blue: 90)])
        passwordField.attributedPlaceholder = passPlaceholder
        passwordField.isSecureTextEntry = true
        passwordField.clearButtonMode = .whileEditing
        
        // sep line
        let sepLine = UIView.init()
        inputBack.addSubview(sepLine)
        sepLine.backgroundColor = UIColor.hexColor(hex: 0xdcdcdc)
        sepLine.snp.makeConstraints { (make) in
            make.centerY.equalTo(inputBack)
            make.right.equalTo(userField)
            make.left.equalTo(userIcon)
            make.height.equalTo(0.5)
        }
    
        
        // login button
        loginBtn = UIButton.init(type: .custom)
        loginBtn.isEnabled = false
        self.view.addSubview(loginBtn)
        loginBtn.setTitle("登  录", for: .normal)
        loginBtn.titleLabel?.font = kAutoFont(size: 20)
//        loginBtn.backgroundColor = UIColor.rgbColor(red: 210, green: 92, blue: 109)
        loginBtn.backgroundColor = UIColor.rgbColor(red: 93, green: 82, blue: 90)
        loginBtn.snp.makeConstraints { (make) in
            make.left.right.equalTo(inputBack)
            make.height.equalTo(kAutoSize(size: 50))
            make.top.equalTo(inputBack.snp.bottom).offset(kAutoSize(size: 20))
        }
        loginBtn.layer.cornerRadius = kAutoSize(size: 10)
        loginBtn.reactive.controlEvents(.touchUpInside).observeValues { (button) in
            print("登录事件")
        }
        
        // register tip
        let registerTip = UIButton.init(type: .custom)
        registerTip.setTitle("没有账号？", for: .normal)
        registerTip .setTitleColor(UIColor.white, for: .normal)
        registerTip.titleLabel?.font = kAutoFont(size: 15)
        self.view.addSubview(registerTip)
        registerTip.snp.makeConstraints { (make) in
            make.left.equalTo(loginBtn)
            make.top.equalTo(loginBtn.snp.bottom).offset(kAutoSize(size: 15))
        }
        registerTip.reactive.controlEvents(.touchUpInside).observeValues { (button) in
            print("没有账号")
        }
        
        // forget password
        let forgetPass = UIButton.init(type: .custom)
        self.view.addSubview(forgetPass)
        forgetPass.setTitle("忘记密码？", for: .normal)
        forgetPass.setTitleColor(UIColor.white, for: .normal)
        forgetPass.titleLabel?.font = registerTip.titleLabel?.font
        forgetPass.snp.makeConstraints { (make) in
            make.right.equalTo(loginBtn)
            make.top.equalTo(registerTip)
        }
        forgetPass.reactive.controlEvents(.touchUpInside).observeValues { (button) in
            print("忘记密码")
        }
    }
    
    
   
}
