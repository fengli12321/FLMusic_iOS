//
//  FLFindViewController.swift
//  FLMusic_iOS
//
//  Created by 冯里 on 2018/5/30.
//  Copyright © 2018年 fengli. All rights reserved.
//

import UIKit

class FLFindViewController: FLBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        creatUI()
    }

    func creatUI() {
//        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
//        searchBar.placeholder = "找一首好听的歌曲"
        let searchBar = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 30))
        searchBar.backgroundColor = UIColor.red
        self.navigationItem.titleView = searchBar
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .search, target: self, action: nil)
        
        let search = UISearchBar(frame: CGRect(x: 0, y: 100, width: 200, height: 30))
        search.placeholder = "找一首好听的歌曲"
        self.view.addSubview(search)
    }
}
