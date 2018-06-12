//
//  FLFindViewController.swift
//  FLMusic_iOS
//
//  Created by 冯里 on 2018/5/30.
//  Copyright © 2018年 fengli. All rights reserved.
//

import UIKit

class FLFindViewController: FLBaseViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    var searchView: FLSearchView!
    var tableView: UITableView!
    var carouselView: UIView! // 轮播图
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - UI
    override func createUI() {
        
        // navigationItem
        searchView = FLSearchView(frame: CGRect(x: 0, y: 0, width: kScreenWidth*2.0/3.0, height: 30))
        searchView.placeholder = "搜索"
        searchView.textColor = .white
        searchView.font = kAutoFont(size: 17)
        searchView.delegate = self
        self.navigationItem.titleView = searchView
        
        // tableView
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = createTableHeaderView()
        tableView.backgroundColor = backColor
    }
    
    func createTableHeaderView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kAutoSize(size: 250)))
        headerView.backgroundColor = backColor
        
        // 轮播图
        carouselView = UIView()
        carouselView.backgroundColor = UIColor.red
        headerView.addSubview(carouselView)
        carouselView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(kAutoSize(size: 150))
        }
        
        // 
        
        // 分割线
        let sepLine = UIView()
        sepLine.backgroundColor = sepColor
        headerView.addSubview(sepLine)
        sepLine.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        return headerView
    }
    
    
    
    @objc func cancelSearch() {
        searchView.resignFirstResponder()
        self.navigationItem.rightBarButtonItem = nil
        UIView.animate(withDuration: 0.3) {
            self.navigationItem.titleView?.frame = CGRect(x: 0, y: 0, width: kScreenWidth*2.0/3.0, height: 30)
        }
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(FLFindViewController.cancelSearch))
        UIView.animate(withDuration: 0.3) {
            self.navigationItem.titleView?.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 30)
        }
        return true
    }
    
    // MARK: - UITableViewDataSource
    
    let cellIdentifier = "cell"
    let headerIdentifier = "header"
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        cell?.backgroundColor = backColor
        return cell!
    }
    // MARK: - UITableViewDelegate
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier)
//    }
}
