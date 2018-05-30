//
//  FLTabBarViewController.swift
//  FLMusic_iOS
//
//  Created by 冯里 on 2018/5/30.
//  Copyright © 2018年 fengli. All rights reserved.
//

import UIKit

class FLTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.tabBar.tintColor = UIColor.hexColor(hex: 0x3c3c3c)
        self.tabBar.barTintColor = UIColor.hexColor(hex: 0x121223)
        
        
        addViewController(vc: FLFindViewController(), title: "测试", normalIcon: "nil", selectIcon: "nil")
        addViewController(vc: UIViewController(), title: "我的", normalIcon: "nil", selectIcon: "nil")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addViewController(vc: UIViewController, title: String, normalIcon: String, selectIcon: String) -> Void {
        let nav = FLNavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = UIImage(named: normalIcon)?.withRenderingMode(.alwaysOriginal)
        nav.tabBarItem.selectedImage = UIImage(named: selectIcon)?.withRenderingMode(.alwaysOriginal)
        
        self.addChildViewController(nav)
    }
}
