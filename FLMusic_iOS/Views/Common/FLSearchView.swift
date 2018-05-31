//
//  FLSearchView.swift
//  FLMusic_iOS
//
//  Created by 冯里 on 2018/5/30.
//  Copyright © 2018年 fengli. All rights reserved.
//

import UIKit

class FLSearchView: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.leftView = 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.height/2.0
    }

}
