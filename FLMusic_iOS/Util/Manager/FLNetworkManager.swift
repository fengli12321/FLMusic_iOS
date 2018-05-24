//
//  FLNetworkManager.swift
//  FLMusic_iOS
//
//  Created by 冯里 on 2018/5/24.
//  Copyright © 2018年 fengli. All rights reserved.
//

import UIKit
import Alamofire

class FLNetworkManager {
    static let shareManager = FLNetworkManager()
    
    private let sessionManager: SessionManager
    private init() {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    static func getRequest(url: String, parameters: [String : Any]? = nil, success: ((Any) -> ())? , fail: ((Error) -> ())?) {
        
        let manager = FLNetworkManager.shareManager
        manager.sessionManager.request(url, method: .get, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let success = success {
                    success(value)
                }
            case .failure(let error):
                if let fail = fail {
                    fail(error)
                }
            }
            
        }
    }
    
    static func postRequest(url: String, parameters: [String : Any]? = nil, success: ((Any) -> ())? , fail: ((Error) -> ())?) {
        
        let manager = FLNetworkManager.shareManager
        manager.sessionManager.request(url, method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let success = success {
                    success(value)
                }
            case .failure(let error):
                if let fail = fail {
                    fail(error)
                }
            }
            
        }
    }
}
