//
//  Observable+Extension.swift
//  FromAsyncToRx
//
//  Created by Vincent on 12/08/2017.
//  Copyright © 2017 Vincent. All rights reserved.
//

import Foundation
import RxSwift

extension Observable {
    
    static func fromAsync<T, U>(_ asyncRequest: @escaping (T, U, (Element) -> Void) -> Void) -> (T, U) -> Observable<Element> {
        return { (a: T, b: U) in Observable.fromAsync(curry(asyncRequest)(a)(b)) }
    }
    
    static func fromAsync<T>(_ asyncRequest: @escaping (T, (Element) -> Void) -> Void) -> (T) -> Observable<Element> {
        return { (a: T) in Observable.fromAsync(curry(asyncRequest)(a)) }
    }
    
    static func fromAsync(_ asyncRequest: @escaping ((Element) -> Void) -> Void) -> Observable<Element> {
        return Observable.create({ (o) -> Disposable in
            
            asyncRequest({ (result) in
                o.onNext(result)
                o.onCompleted()
            })
            
            return Disposables.create()
        })
    }
}

