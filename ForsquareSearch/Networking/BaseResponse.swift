//
//  BaseResponse.swift
//  ForsquareSearch
//
//  Created by Łukasz Wróblak on 20.10.2018.
//  Copyright © 2018 Łukasz Wróblak. All rights reserved.
//

import Foundation
import RealmSwift

class BaseResponse : Object, BaseResponseProtocol {
    
    var errorResponse : ErrorResponse?
    
    func isValid() -> Bool {
        if errorResponse != nil {
            return false
        }
        return true
    }
    
    func getErrorReponse() -> ErrorResponse? {
        return errorResponse
    }
    
    func setErrorResponse(errorResponse: ErrorResponse) {
        self.errorResponse = errorResponse
    }
    
}
