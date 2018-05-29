//
//  FLRigesterViewController.swift
//  FLMusic_iOS
//
//  Created by fengli on 2018/5/29.
//  Copyright © 2018年 fengli. All rights reserved.
//

import UIKit

class FLRigesterViewController: FLBaseViewController {

    var userField: UITextField!
    var passwordField1: UITextField!
    var passwordField2: UITextField!
    var rigesterBtn: UIButton!
    var closeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createUI()
    }

    func createUI() {
        // back image
        let backImage = UIImageView(frame: self.view.bounds)
        self.view.addSubview(backImage)
        backImage.image = UIImage.coreBlur(inputImage: #imageLiteral(resourceName: "login_bg2.jpg"), blurNumber: 8)
        
        
        // tiplabel
        let label = UILabel.init()
        self.view.addSubview(label)
        label.font = kBAutoFont(size: 20)
        label.textColor = .white
        label.text = "欢迎注册"
        label.snp.makeConstraints { (make) in
            make.centerX.equalTo((self.view))
            make.top.equalToSuperview().offset(kAutoSize(size: 70))
        }
    }

}
