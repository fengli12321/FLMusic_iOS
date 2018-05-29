//
//  FLReactive.swift
//  FLMusic_iOS
//
//  Created by fengli on 2018/5/25.
//  Copyright © 2018年 fengli. All rights reserved.
//

import ReactiveSwift
import ReactiveCocoa
import Result

struct APIError : Error {
    var code: Int
    var msg = "未知错误"
    
    init(code: Int) {
        self.code = code
    }
    
    init(code: Int, msg: String) {
        self.code = code
        self.msg = msg
    }
}
typealias noErrorSignal<T> = Signal<T, NoError>
typealias APISignal<T> = Signal<T, APIError>
typealias noErrorAction<input, output> = Action<input, output, NoError>
typealias APIAction<input, output> = Action<input, output, APIError>
typealias APISignalProducer<T> = SignalProducer<T, APIError>
typealias noErrorObserver<T> = noErrorSignal<T>.Observer
typealias APIObserver<T> = APISignal<T>.Observer
