//
//  FLBaseViewController.swift
//  FLMusic_iOS
//
//  Created by 冯里 on 2018/5/10.
//  Copyright © 2018年 fengli. All rights reserved.
//

import UIKit

class FLBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = backColor
        createUI()
    }

    func createUI() {
        
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
