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
    
    
    private var errorLabel: UILabel!
    
    private var loginBack: UIView!
    private var userField: UITextField!
    private var passwordField: UITextField!
    private var loginBtn: UIButton!
    private var registerTip: UIButton!
    
    private var registerBack: UIView!
    private var rUserField: UITextField!
    private var rPasswordField1: UITextField!
    private var rPasswordField2: UITextField!
    private var registerBtn: UIButton!
    private var goToLoginBtn: UIButton!
    
    private var viewState = 0   // 0 为登录视图 1 为注册视图
    
    private lazy var viewModel: FLLoginViewModel = {
        return FLLoginViewModel(userField.reactive.continuousTextValues, passwordField.reactive.continuousTextValues)
    }()
    
    // MARK: Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        bindViewModel()
    }
    // MARK: - private
    func bindViewModel() {
        
        let loginVaildSignal = Signal.combineLatest(viewModel.userNameSignal, viewModel.passWordSignal).map({ (username, password) -> String in
            return (username ?? "").count == 0 ? "请输入用户名" : ((password ?? "").count == 0 ? "请输入密码" : "")
        })
        let registerVaildSignal = Signal.combineLatest(rUserField.reactive.continuousTextValues, rPasswordField1.reactive.continuousTextValues, rPasswordField2.reactive.continuousTextValues).map { (userName, password1, password2) -> String in
            var error = ""
            if (userName ?? "").count == 0 {
                error = "请输入用户名"
            } else if (password1 ?? "").count == 0 {
                error = "请输入密码"
            } else if (password2 ?? "").count == 0 {
                error = "请验证密码"
            } else if password1! != password2! {
                error = "两次输入密码不一致"
            }
            return error
        }
    
        errorLabel.reactive.text <~ Signal.merge(loginVaildSignal, registerVaildSignal)
        
        loginBtn.reactive.isEnabled <~ viewModel.vaildSignal
        loginBtn.reactive.backgroundColor <~ viewModel.btnColor
//        loginBtn.reactive.pressed = CocoaAction<UIButton>.init(viewModel.loginAction){
//            [unowned self] some in
//
//            return (self.userField.text!, self.passwordField.text!)
//        }
        
        // 登录
        loginBtn.reactive.controlEvents(UIControlEvents.touchUpInside).observeValues { (button) in
            self.viewModel.loginAction.apply((self.userField.text!, self.passwordField.text!)).start()
        }
        viewModel.loginAction.values.observeValues { (success) in
            print("是否成功： \(success)")
        }
        viewModel.loginAction.errors.observeValues { (error) in
            print("失败  code:\(error.code)  msg:\(error.msg)")
        }

        // 去注册
        registerTip.reactive.controlEvents(.touchUpInside).observeValues { [unowned self](button) in
            
            self.gotoRegister()
        }
        
        // 返回登录
        goToLoginBtn.reactive.controlEvents(.touchUpInside).observeValues { [unowned self](button) in
            self.gotoLogin()
        }
    }
    
    func gotoRegister() -> Void {
        if viewState == 0 {
            viewState = 1
            UIView.animate(withDuration: 0.5) {
                
                self.loginBack.x = -kScreenWidth
                self.registerBack.x = 0
            }
        }
    }
    
    func gotoLogin() -> Void {
        if viewState == 1 {
            viewState = 0
            UIView.animate(withDuration: 0.5) {
                self.loginBack.x = 0
                self.registerBack.x = kScreenWidth
            }
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
        
        // loginBack
        loginBack = UIView(frame: self.view.bounds)
        self.view.addSubview(loginBack)
        
        // input back
        let inputBack = UIView.init()
        loginBack.addSubview(inputBack)
        inputBack.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        inputBack.snp.makeConstraints { (make) in
            make.centerX.equalTo(loginBack)
            make.top.equalTo(descLabel.snp.bottom).offset(kAutoSize(size: 40))
            make.left.equalTo(loginBack).offset(kAutoSize(size: 40))
            make.height.equalTo(kAutoSize(size: kAutoSize(size: 130)))
        }
        inputBack.layer.cornerRadius = kAutoSize(size: 10)
        
        // user name
        let userIcon = createImageView(backView: inputBack, image: #imageLiteral(resourceName: "login_user"))
        userIcon.snp.makeConstraints { (make) in
            make.centerY.equalTo(inputBack.snp.bottom).multipliedBy(1/4.0)
        }
        
        
        userField = createFiled(backView: inputBack, placeholder: "请输入用户名或邮箱")
        userField.snp.makeConstraints { (make) in
            make.left.equalTo(userIcon.snp.right).offset(kAutoSize(size: 10))
            make.right.equalTo(inputBack).offset(-kAutoSize(size: 15))
            make.height.equalTo(kAutoSize(size: 40))
            make.centerY.equalTo(userIcon)
        }
        userField.keyboardType = .emailAddress
        
        // pass word
        let passwordIcon = createImageView(backView: inputBack, image: #imageLiteral(resourceName: "login_password"))
        passwordIcon.snp.makeConstraints { (make) in
            make.centerY.equalTo(inputBack.snp.bottom).multipliedBy(3/4.0)
        }
        
        passwordField = createFiled(backView: inputBack, placeholder: "请输入密码")
        passwordField.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(userField)
            make.centerY.equalTo(passwordIcon)
        }
        passwordField.isSecureTextEntry = true
        
        // sep line
        let sepLine = createSepline(backView: inputBack)
        sepLine.snp.makeConstraints { (make) in
            make.centerY.equalTo(inputBack)
            make.right.equalTo(userField)
            make.left.equalTo(userIcon)
        }
    
        
        // login button
        loginBtn = UIButton.init(type: .custom)
        loginBtn.isEnabled = false
        loginBack.addSubview(loginBtn)
        loginBtn.setTitle("登  录", for: .normal)
        loginBtn.titleLabel?.font = kAutoFont(size: 20)
        loginBtn.backgroundColor = UIColor.rgbColor(red: 93, green: 82, blue: 90)
        loginBtn.snp.makeConstraints { (make) in
            make.left.right.equalTo(inputBack)
            make.height.equalTo(kAutoSize(size: 50))
            make.top.equalTo(inputBack.snp.bottom).offset(kAutoSize(size: 20))
        }
        loginBtn.layer.cornerRadius = kAutoSize(size: 10)
        
        // register tip
        registerTip = UIButton.init(type: .custom)
        registerTip.setTitle("没有账号？", for: .normal)
        registerTip .setTitleColor(UIColor.white, for: .normal)
        registerTip.titleLabel?.font = kAutoFont(size: 15)
        loginBack.addSubview(registerTip)
        registerTip.snp.makeConstraints { (make) in
            make.left.equalTo(loginBtn)
            make.top.equalTo(loginBtn.snp.bottom).offset(kAutoSize(size: 15))
        }
        
        // forget password
        let forgetPass = UIButton.init(type: .custom)
        loginBack.addSubview(forgetPass)
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
        
        
        
        
        // register back
        registerBack = UIView(frame: CGRect(x: kScreenWidth, y: 0, width: kScreenWidth, height: kScreenHeight))
        self.view.addSubview(registerBack)
        
        // input back
        let rInputBack = UIView.init()
        registerBack.addSubview(rInputBack)
        rInputBack.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        rInputBack.snp.makeConstraints { (make) in
            make.centerX.equalTo(registerBack)
            make.top.equalTo(descLabel.snp.bottom).offset(kAutoSize(size: 40))
            make.left.equalTo(registerBack).offset(kAutoSize(size: 40))
            make.height.equalTo(kAutoSize(size: kAutoSize(size: 190)))
        }
        rInputBack.layer.cornerRadius = kAutoSize(size: 10)
        
        // userfield
        
        let rUserIcon = createImageView(backView: rInputBack, image: #imageLiteral(resourceName: "login_user"))
        rUserIcon.snp.makeConstraints { (make) in
            make.centerY.equalTo(rInputBack.snp.bottom).multipliedBy(1/6.0)
        }
        
        
        rUserField = createFiled(backView: rInputBack, placeholder: "请输入用户名")
        rUserField.snp.makeConstraints { (make) in
            make.left.equalTo(rUserIcon.snp.right).offset(kAutoSize(size: 10))
            make.right.equalTo(rInputBack).offset(-kAutoSize(size: 15))
            make.height.equalTo(kAutoSize(size: 40))
            make.centerY.equalTo(rUserIcon)
        }
        rUserField.keyboardType = .emailAddress
        
        // password
        let rPasswordIcon1 = createImageView(backView: rInputBack, image: #imageLiteral(resourceName: "login_password"))
        rPasswordIcon1.snp.makeConstraints { (make) in
            make.centerY.equalTo(rInputBack.snp.bottom).multipliedBy(1/2.0)
        }
        
        rPasswordField1 = createFiled(backView: rInputBack, placeholder: "请输入密码")
        rPasswordField1.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(rUserField)
            make.centerY.equalTo(rPasswordIcon1)
        }
        rPasswordField1.isSecureTextEntry = true
        
        
        let rPasswordIcon2 = createImageView(backView: rInputBack, image: #imageLiteral(resourceName: "login_password"))
        rPasswordIcon2.snp.makeConstraints { (make) in
            make.centerY.equalTo(rInputBack.snp.bottom).multipliedBy(5/6.0)
        }

        rPasswordField2 = createFiled(backView: rInputBack, placeholder: "请确认密码")
        rPasswordField2.snp.makeConstraints { (make) in
            make.width.left.height.equalTo(rUserField)
            make.centerY.equalTo(rPasswordIcon2)
        }
        rPasswordField2.isSecureTextEntry = true

        // sep line
        let sepLine1 = createSepline(backView: rInputBack)
        sepLine1.snp.makeConstraints { (make) in
            make.centerY.equalTo(rInputBack.snp.bottom).multipliedBy(1/3.0)
            make.right.equalTo(rUserField)
            make.left.equalTo(rUserIcon)
        }
        
        let sepLine2 = createSepline(backView: rInputBack)
        sepLine2.snp.makeConstraints { (make) in
            make.centerY.equalTo(rInputBack.snp.bottom).multipliedBy(2/3.0)
            make.right.equalTo(rUserField)
            make.left.equalTo(rUserIcon)
        }
        
        
        // register btn
        registerBtn = UIButton.init(type: .custom)
        registerBtn.isEnabled = false
        registerBack.addSubview(registerBtn)
        registerBtn.setTitle("注  册", for: .normal)
        registerBtn.titleLabel?.font = kAutoFont(size: 20)
        //        loginBtn.backgroundColor = UIColor.rgbColor(red: 210, green: 92, blue: 109)
        registerBtn.backgroundColor = UIColor.rgbColor(red: 93, green: 82, blue: 90)
        registerBtn.snp.makeConstraints { (make) in
            make.left.right.equalTo(rInputBack)
            make.height.equalTo(kAutoSize(size: 50))
            make.top.equalTo(rInputBack.snp.bottom).offset(kAutoSize(size: 20))
        }
        registerBtn.layer.cornerRadius = kAutoSize(size: 10)
        
        // back to login
        goToLoginBtn = UIButton()
        registerBack.addSubview(goToLoginBtn)
        goToLoginBtn.setTitle("已有账号？返回登录", for: .normal)
        goToLoginBtn.setTitleColor(UIColor.white, for: .normal)
        goToLoginBtn.titleLabel?.font = registerTip.titleLabel?.font
        goToLoginBtn.snp.makeConstraints { (make) in
            make.right.equalTo(rInputBack)
            make.bottom.equalTo(rInputBack.snp.top)
        }
    }
    
    func createFiled(backView: UIView, placeholder: String) -> UITextField {
        let textField = UITextField()
        backView.addSubview(textField)
        textField.font = kAutoFont(size: 18)
        let tPlaceholder = NSMutableAttributedString.init(string: placeholder, attributes: [NSAttributedStringKey.foregroundColor : UIColor.rgbColor(red: 93, green: 82, blue: 90)])
        textField.attributedPlaceholder = tPlaceholder
        textField.clearButtonMode = .whileEditing;
        return textField
    }
   
    func createSepline(backView: UIView) -> UIView {
        let line = UIView()
        backView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
        }
        line.backgroundColor = UIColor.hexColor(hex: 0xdcdcdc)
        return line
    }
    
    func createImageView(backView: UIView, image: UIImage) -> UIImageView {
        let imageView = UIImageView()
        backView.addSubview(imageView)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(kAutoSize(size: 20))
            make.left.equalTo(backView).offset(kAutoSize(size: 15))
        }
        
        return imageView
    }
}
