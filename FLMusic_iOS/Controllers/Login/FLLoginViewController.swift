//
//  FLLoginViewController.swift
//  FLMusic_iOS
//
//  Created by 冯里 on 2018/5/10.
//  Copyright © 2018年 fengli. All rights reserved.
//

import UIKit


class FLLoginViewController: FLBaseViewController {

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
        descLabel.font = kFont(size: 20)
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
            make.height.equalTo(kAutoSize(size: 160))
        }
        inputBack.layer.cornerRadius = kAutoSize(size: 10)
        
        // login button
        let loginBtn = UIButton.init(type: .custom)
        self.view.addSubview(loginBtn)
        loginBtn.setTitle("登  录", for: .normal)
        loginBtn.titleLabel?.font = kFont(size: 20)
//        loginBtn.backgroundColor = UIColor.rgbColor(red: 210, green: 92, blue: 109)
        loginBtn.backgroundColor = UIColor.rgbColor(red: 93, green: 82, blue: 90)
        loginBtn.snp.makeConstraints { (make) in
            make.left.right.equalTo(inputBack)
            make.height.equalTo(kAutoSize(size: 50))
            make.top.equalTo(inputBack.snp.bottom).offset(kAutoSize(size: 20))
        }
        loginBtn.layer.cornerRadius = kAutoSize(size: 10)
        
        // register tip
        let registerTip = UIButton.init(type: .custom)
        registerTip.setTitle("没有账号？", for: .normal)
        registerTip .setTitleColor(UIColor.white, for: .normal)
        registerTip.titleLabel?.font = kFont(size: 15)
        self.view.addSubview(registerTip)
        registerTip.snp.makeConstraints { (make) in
            make.left.equalTo(loginBtn)
            make.top.equalTo(loginBtn.snp.bottom).offset(kAutoSize(size: 15))
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
    }

}
