//
//  AsyncAPI.swift
//  FromAsyncToRx
//
//  Created by Vincent on 12/08/2017.
//  Copyright © 2017 Vincent. All rights reserved.
//

import Foundation
import RxSwift

enum Response<T> {
    case error(Error)
    case response(T)
}

struct BodyParameters {}

class AsyncAPI {
    
    func increment(_ arg: Int, _ completionHandler: (String) -> Void) {
        Thread.sleep(forTimeInterval: 0.2)
        
        completionHandler("\(arg + 1)")
    }
    
    func add(_ arg1: Int, _ arg2: Int, _ completionHandler: (String) -> Void) {
        Thread.sleep(forTimeInterval: 0.2)
        
        completionHandler("\(arg1 + arg2)")
    }
    
   
    func alamoRequest(_ params : BodyParameters,  _ completionHandler: (Response<Any>) -> Void) {
        Thread.sleep(forTimeInterval: 0.2)
        completionHandler(Response.response(params))
    }
    
    
    func obsRequest<T>(_ param: BodyParameters) -> Observable<T> {
        return Observable.create({ (o) -> Disposable in
            self.alamoRequest(param, { (response) in
                switch response {
                case .response(let response as T):
                    o.onNext(response)
                default:
                o.onError("error")
                }
                o.onCompleted()
            })
            return Disposables.create()
        })
    }
    
    func requestCondiment(_ type: Condiment) -> Observable<String> {
        let param = BodyParameters()
        return obsRequest(param)
    }
}

enum Condiment {
    case salt, pepper
}


extension String: Error {}

