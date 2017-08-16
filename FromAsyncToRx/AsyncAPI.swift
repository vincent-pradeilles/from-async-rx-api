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
    
    func increment(_ arg: Int, _ completionHandler: @escaping (String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completionHandler("\(arg + 1)")
        }
    }
    
    func add(_ arg1: Int, _ arg2: Int, _ completionHandler: @escaping (String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completionHandler("\(arg1 + arg2)")
        }
    }
}
