//
//  UIView+FLCommon.swift
//  FLMusic_iOS
//
//  Created by 冯里 on 2018/5/10.
//  Copyright © 2018年 fengli. All rights reserved.
//

import UIKit

extension UIView {
    var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }
    
    var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }
    
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    
    var centerX: CGFloat {
        get {
            return self.frame.midX
        }
        set {
            
            self.x = self.frame.midX - self.width/2
        }
    }
    
    var centerY: CGFloat {
        get {
            return self.frame.midY
        }
        set {
            self.y = self.frame.midY - self.height/2
        }
    }
    
    var maxX: CGFloat {
        get {
            return self.frame.maxX
        }
    }
    
    var maxY: CGFloat {
        get {
            return self.frame.maxX
        }
    }
}


