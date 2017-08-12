//
//  AsyncAPI.swift
//  FromAsyncToRx
//
//  Created by Vincent on 12/08/2017.
//  Copyright © 2017 Vincent. All rights reserved.
//

import Foundation
import RxSwift

class AsyncAPI {
    
    func request(_ completionHandler: (String) -> Void) {
        Thread.sleep(forTimeInterval: 0.2)
        
        completionHandler("Result")
    }
    
    func request(_ arg: Int, _ completionHandler: (String) -> Void) {
        Thread.sleep(forTimeInterval: 0.2)
        
        completionHandler("\(arg + 1)")
    }
    
    func request(_ arg1: Int, _ arg2: Int, _ completionHandler: (String) -> Void) {
        Thread.sleep(forTimeInterval: 0.2)
        
        completionHandler("\(arg1 + arg2)")
    }
}


func toRx<T, U, V>(_ asyncRequest: @escaping (T, U, CompletionHandler<V>) -> Void) -> (T, U) -> Observable<V> {
    return { (a: T, b: U) in toRx(curry(asyncRequest)(a)(b)) }
}

func toRx<T, U>(_ asyncRequest: @escaping (T, CompletionHandler<U>) -> Void) -> (T) -> Observable<U> {
    return { (a: T) in toRx(curry(asyncRequest)(a)) }
}

typealias CompletionHandler<T> = (T) -> Void

func toRx<T>(_ asyncRequest: @escaping (CompletionHandler<T>) -> Void) -> Observable<T> {
    return Observable.create({ (o) -> Disposable in
        
        asyncRequest({ (result) in
            o.onNext(result)
            o.onCompleted()
        })
        
        return Disposables.create()
    })
}
