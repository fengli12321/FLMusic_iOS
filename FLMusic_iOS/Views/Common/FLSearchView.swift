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
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func createUI() {
        backgroundColor = UIColor.white.withAlphaComponent(0.3)
        layer.cornerRadius = height/2.0
        
        let searchImage = UIImageView(image: #imageLiteral(resourceName: "home_search"))
        leftView = searchImage
        leftViewMode = .always
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        
        let width: CGFloat = 18.0
        return CGRect(x: 5, y: (self.height - width)/2.0, width: width, height: width)
    }
//
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return super.textRect(forBounds: bounds)
//    }
}
