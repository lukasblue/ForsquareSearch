//
//  NetworkManager.swift
//  ForsquareSearch
//
//  Created by Łukasz Wróblak on 20.10.2018.
//  Copyright © 2018 Łukasz Wróblak. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private static var sessionManager: SessionManager?
    
    static func getSessionManager() -> SessionManager {
        if sessionManager == nil {
            sessionManager = SessionManager()
        }
        return sessionManager!
    }
    
    
}

