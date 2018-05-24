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
    
    var userNameSignal: Signal<String?, NoError>
    var passWordSignal: Signal<String?, NoError>
    var vaildSignal: Signal<Bool, NoError>
    var colorSignal: Signal<UIColor, NoError>
    var loginAction : Action<(String, String), Bool, NoError>
    init(_ signal1: Signal<String?, NoError>, _ signal2: Signal<String?, NoError>) {
        
        userNameSignal = signal1
        passWordSignal = signal2
        
      
        vaildSignal = Signal.combineLatest(userNameSignal, passWordSignal).map({
            
            userName, passWord in
            return userName!.count >= 1 && passWord!.count >= 3;
        })
        let loginEnable = Property.init(initial: false, then: vaildSignal)
        colorSignal = vaildSignal.map{
            vaild in
            return vaild ? UIColor.red : UIColor.rgbColor(red: 93, green: 82, blue: 90)
        }
        loginAction = Action(enabledIf: loginEnable, execute: { (userName, passWord) -> SignalProducer<Bool, NoError> in
            return SignalProducer<Bool, NoError>{
                observer, disposable in
                let success = (userName == "fox") && (passWord == "love")
                observer.send(value: success)
                observer.sendCompleted()
            }
        })
    }
}
