//
//  FLLoginViewModel.swift
//  FLMusic_iOS
//
//  Created by fengli on 2018/5/14.
//  Copyright © 2018年 fengli. All rights reserved.
//
import ReactiveSwift

class FLLoginViewModel: FLBaseViewModel {
    
    let username = MutableProperty("")
    override init() {
        username.value = "Fox"
    }
}
