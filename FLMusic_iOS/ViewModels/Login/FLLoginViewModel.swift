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
    
    var rUserNameSignal: noErrorSignal<String?>
    var rPassword1Signal: noErrorSignal<String?>
    var rPassword2Signal: noErrorSignal<String?>
    
    var errorTip: noErrorSignal<String>

    var vaildSignal: noErrorSignal<Bool>
    var rVaildSignal: noErrorSignal<Bool>
    
    var btnColor = MutableProperty(UIColor.rgbColor(red: 93, green: 82, blue: 90))
    var rBtnColor = MutableProperty(UIColor.rgbColor(red: 93, green: 82, blue: 90))
    var loginAction : APIAction<(String, String), String>
    var registerAction: APIAction<(String, String), String>
    init(_ signal1: noErrorSignal<String?>, _ signal2: noErrorSignal<String?>,_ signal3: noErrorSignal<String?>,_ signal4: noErrorSignal<String?>,_ signal5: noErrorSignal<String?>) {
        
        userNameSignal = signal1
        passWordSignal = signal2
        
        rUserNameSignal = signal3
        rPassword1Signal = signal4
        rPassword2Signal = signal5
        
        let loginVaildSignal = Signal.combineLatest(userNameSignal, passWordSignal).map({ (username, password) -> String in
            return (username ?? "").count == 0 ? "请输入用户名" : ((password ?? "").count == 0 ? "请输入密码" : "")
        })
        let registerVaildSignal = Signal.combineLatest(rUserNameSignal, rPassword1Signal, rPassword2Signal).map { (userName, password1, password2) -> String in
            var error = ""
            if (userName ?? "").count == 0 {
                error = "请输入用户名1"
            } else if (password1 ?? "").count == 0 {
                error = "请输入密码1"
            } else if (password2 ?? "").count == 0 {
                error = "请验证密码1"
            } else if password1! != password2! {
                error = "两次输入密码不一致1"
            }
            return error
        }
        
        errorTip = Signal.merge(loginVaildSignal, registerVaildSignal)
        
      
        vaildSignal = Signal.combineLatest(userNameSignal, passWordSignal).map({
            
            userName, passWord in
            return userName!.count > 0 && passWord!.count > 0;
        })
        
        rVaildSignal = Signal.combineLatest(rUserNameSignal, rPassword1Signal, rPassword2Signal).map({ (user, pass1, pass2) -> Bool in
            return user!.count > 0 && pass1!.count > 0 && pass2!.count > 0
        })
        
        let loginEnable = Property.init(initial: false, then: vaildSignal)
        let registerEnable = Property.init(initial: false, then: vaildSignal)
       
        btnColor <~ vaildSignal.map{
            vaild in
            return vaild ? UIColor.hexColor(hex: 0xcf6966) : UIColor.rgbColor(red: 93, green: 82, blue: 90)
        }
        
        rBtnColor <~ rVaildSignal.map{
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
        
        registerAction = APIAction(enabledIf: registerEnable, execute: { (user, pass) -> SignalProducer<String, APIError> in
            
            return APISignalProducer<String>({ (observer, _) in
                
                FLNetworkManager.getRequest(url: "http:www.baidu.com", success: { (reponse) in
                    
                    observer.send(value: "success")
                    observer.sendCompleted()
                }, fail: { (error) in
                    observer.send(error: APIError(code: error._code))
                })
            })
        })
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
