//
//  FLConst.swift
//  FLMusic_iOS
//
//  Created by 冯里 on 2018/5/10.
//  Copyright © 2018年 fengli. All rights reserved.
//

import UIKit

let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height
let kNotificationCenter = NotificationCenter.default
let kUserDefault = UserDefaults.standard
let kKeyWindow = UIApplication.shared.delegate!.window!
let STATUS_BAR_HEIGHT = isIphoneX() ? 44.0 : 20.0
let NAVIGATION_BAR_HEIGHT = isIphoneX() ? 88.0 : 64.0
let TAB_BAR_HEIGHT = isIphoneX() ? (49.0 + 34.0) : 49.0
let HOME_INDICATOR_HEIGHT = isIphoneX() ? 34.0 : 0.0


func kAutoSize(size: CGFloat) -> CGFloat {
    return size*kScreenWidth/375
}
func kFont(size: CGFloat) -> UIFont {
    return UIFont(name: "PingFangSC-Ultralight", size: size)!
}

func kAutoFont(size: CGFloat) -> UIFont {
    return kFont(size: kAutoSize(size: size))
}

func isIphoneX() -> Bool {
    return kScreenHeight == 812
}
