//
//  FLSearchViewController.swift
//  FLMusic_iOS
//
//  Created by fengli on 2018/5/31.
//  Copyright © 2018年 fengli. All rights reserved.
//

import UIKit

class FLSearchViewController: FLBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func createUI() {
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.cancel))
        
        let searchView = FLSearchView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 30))
        searchView.placeholder = "搜索"
        self.navigationItem.titleView = searchView
    }
    
    @objc func cancel() {
        self.navigationController?.popViewController(animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
