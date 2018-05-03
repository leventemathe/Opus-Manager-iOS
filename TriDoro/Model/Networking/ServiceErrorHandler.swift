//
//  ServiceErrorHandler.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 03..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import Foundation

struct ServiceErrorHandler {
    
    func genereateError(fromError error: NSError) -> Error {
        if error.domain == NSURLErrorDomain {
            switch error.code {
            case NSURLErrorNotConnectedToInternet:
                return ServiceError.network
            default:
                return ServiceError.other
            }
        }
        return ServiceError.other
    }
}
