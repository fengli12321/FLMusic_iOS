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

    let viewModel = FLLoginViewModel.init()
    override func viewDidLoad() {
        super.viewDidLoad()
                self.createUI()
    }
    
    // MARK: - UI
    func createUI() {
        // Back
        let bgImgView = UIImageView.init(frame: self.view.bounds)
        bgImgView.contentMode = .scaleAspectFill
        self.view .addSubview(bgImgView)
        var image = UIImage.init(named: "login_bg3.jpg")!
        image = UIImage.coreBlur(inputImage: image, blurNumber: 8)
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
        logImage.image = UIImage.init(named: "login_music_icon")
        
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
        
        // input back
        let inputBack = UIView.init()
        self.view.addSubview(inputBack)
        inputBack.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        inputBack.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(descLabel.snp.bottom).offset(kAutoSize(size: 30))
            make.left.equalTo(self.view).offset(kAutoSize(size: 40))
            make.height.equalTo(kAutoSize(size: kAutoSize(size: 130)))
        }
        inputBack.layer.cornerRadius = kAutoSize(size: 10)
        
        // user name
        
        let userIcon = UIImageView.init()
        userIcon.image = UIImage.init(named: "login_user")
        userIcon.contentMode = .scaleAspectFit
        inputBack.addSubview(userIcon)
        userIcon.snp.makeConstraints { (make) in
            make.width.height.equalTo(kAutoSize(size: 20))
            make.centerY.equalTo(inputBack.snp.bottom).multipliedBy(1/4.0)
            make.left.equalTo(inputBack).offset(kAutoSize(size: 15))
        }
        
        
        let userField = UITextField.init()
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
        passwordIcon.image = UIImage.init(named: "login_password")
        passwordIcon.contentMode = .scaleAspectFit
        inputBack.addSubview(passwordIcon)
        passwordIcon.snp.makeConstraints { (make) in
            make.width.left.height.equalTo(userIcon)
            make.centerY.equalTo(inputBack.snp.bottom).multipliedBy(3/4.0)
        }
        
        let passwordField = UITextField()
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
        let loginBtn = UIButton.init(type: .custom)
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
