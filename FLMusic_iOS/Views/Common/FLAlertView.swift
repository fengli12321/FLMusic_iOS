//
//  FLAlertView.swift
//  FLMusic_iOS
//
//  Created by 冯里 on 2018/5/10.
//  Copyright © 2018年 fengli. All rights reserved.
//

import UIKit

class FLAlertView: UIView {
    
    
    static func showAlert(title: String, message: String, cancelButtonTitle: String?, otherButtonTitles: Array<String>?, inView: UIView?, clickCallback: ((Int) -> Void)? = nil) -> UIAlertController {
        
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        
        if let cancelTitle = cancelButtonTitle {
            let alertAction = UIAlertAction.init(title: cancelTitle, style: .cancel) { (action) in
                
                if let callback = clickCallback {
                    callback(0)
                }
            }
            alert.addAction(alertAction)
        }
        if let otherTitles = otherButtonTitles {
            for i in 0...otherTitles.count {
                
                let otherTitle = otherTitles[i]
                let alertAction = UIAlertAction.init(title: otherTitle, style: .cancel) { (action) in
                    
                    if let _ = cancelButtonTitle {
                        if let callback = clickCallback {
                            callback(i + 1)
                        }
                    } else {
                        if let callback = clickCallback {
                            callback(i)
                        }
                    }
                }
                alert.addAction(alertAction)
            }
        }
        if let view = inView {
            
            if let vc = findVC(view: view) {
                vc.present(alert, animated: true, completion: nil)
            }
        } else {
            let window = UIApplication.shared.keyWindow
            window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
        
        return alert;
    }
    
    static func findVC(view: UIView) -> UIViewController? {
        
        if let responder = view.next {
            if (responder.isKind(of: UIViewController.self)){
                return responder as? UIViewController
            } else {
                return findVC(view:responder as! UIView)
            }
        } else {
            return nil
        }
    }

}


