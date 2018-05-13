//
//  UIColor+FLCommon.swift
//  FLMusic_iOS
//
//  Created by 冯里 on 2018/5/13.
//  Copyright © 2018年 fengli. All rights reserved.
//

import UIKit

extension UIColor {
    static func hexColor(hex: Int64, alpha: CGFloat) -> UIColor{
        let r = (hex & 0xff0000) >> 16
        let g = (hex & 0x00ff00) >> 8
        let b = (hex & 0x0000ff);
        return UIColor.init(red: CGFloat(r)/0xff, green: CGFloat(g)/0xff, blue: CGFloat(b)/0xff, alpha: alpha)
    }
    
    static func hexColor(hex: Int64) -> UIColor{
        return self.hexColor(hex: hex, alpha: 1.0)
    }
    
    static func rgbColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
}
