//
//  FLLoginViewModel.swift
//  FLMusic_iOS
//
//  Created by fengli on 2018/5/14.
//  Copyright © 2018年 fengli. All rights reserved.
//
import ReactiveSwift
import Result

class FLLoginViewModel: FLBaseViewModel {
    
    var userNameSignal: noErrorSignal<String?>
    var passWordSignal: noErrorSignal<String?>
    var vaildSignal: noErrorSignal<Bool>
    var btnColor = MutableProperty(UIColor.rgbColor(red: 93, green: 82, blue: 90))
    var loginAction : APIAction<(String, String), String>
    init(_ signal1: noErrorSignal<String?>, _ signal2: noErrorSignal<String?>) {
        
        userNameSignal = signal1
        passWordSignal = signal2
        
      
        vaildSignal = Signal.combineLatest(userNameSignal, passWordSignal).map({
            
            userName, passWord in
            return userName!.count > 0 && passWord!.count > 0;
        })
        let loginEnable = Property.init(initial: false, then: vaildSignal)
       
        btnColor <~ vaildSignal.map{
            vaild in
            return vaild ? UIColor.hexColor(hex: 0xcf6966) : UIColor.rgbColor(red: 93, green: 82, blue: 90)
        }
        
    
        
        loginAction = APIAction(enabledIf: loginEnable, execute: { (userName, passWord) -> APISignalProducer<String> in
            return APISignalProducer<String>{
                observer, disposable in
                
                FLNetworkManager.getRequest(url: "http://www.baidu.com", success: { (response) in
                    
                    if response is [String : AnyObject] {
                        observer.send(value: "I love you,baby")
                        observer.sendCompleted()
                    } else {
                        observer.send(error: APIError(code: -1, msg: "数据解析错误"));
                    }
                    
                }, fail: { (error) in
                    
                    observer.send(error: APIError.init(code: error._code))
                })
            }
        })
//        loginAction = Action(enabledIf: loginEnable, execute: { (userName, passWord) -> SignalProducer<Bool, NoError> in
//            return SignalProducer<Bool, NoError>{
//                observer, disposable in
//                
//                FLNetworkManager.getRequest(url: "http://www.baidu.com", success: { (response) in
//                    print(response)
//                    
//                }, fail: { (error) in
//                    print(error)
//                })
//            }
//        })
    }
    
    func errorHandle(error: Error, observer: APIObserver<String>) -> () {
        var errorMsg: String = ""
        switch error._code {
        case -1001:
            errorMsg = "请求超时，请稍后重试！"
        default:
            errorMsg = "未知错误！"
        }
        observer.send(error: APIError(code: error._code, msg: errorMsg));
    }
}
