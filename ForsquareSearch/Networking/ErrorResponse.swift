//
//  ErrorResponse.swift
//  ForsquareSearch
//
//  Created by Łukasz Wróblak on 20.10.2018.
//  Copyright © 2018 Łukasz Wróblak. All rights reserved.
//

import Foundation

class ErrorResponse {
    
    var errorMessage: String?
    
    convenience init(errorMessage: String) {
        self.init()
        self.errorMessage = errorMessage
    }
 
}
