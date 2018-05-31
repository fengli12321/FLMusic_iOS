//
//  FLFindViewController.swift
//  FLMusic_iOS
//
//  Created by 冯里 on 2018/5/30.
//  Copyright © 2018年 fengli. All rights reserved.
//

import UIKit

class FLFindViewController: FLBaseViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func createUI() {
        
        let searchView = FLSearchView(frame: CGRect(x: 0, y: 0, width: kScreenWidth*2.0/3.0, height: 30))
        searchView.placeholder = "搜索"
        searchView.delegate = self
        self.navigationItem.titleView = searchView
        
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.navigationController?.pushViewController(FLSearchViewController(), animated: false)
        return false
    }
}
