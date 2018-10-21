//
//  BaseConnection.swift
//  ForsquareSearch
//
//  Created by Łukasz Wróblak on 20.10.2018.
//  Copyright © 2018 Łukasz Wróblak. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

protocol BaseResponseProtocol {
    init()
    func isValid() -> Bool
    func getErrorReponse() -> ErrorResponse?
    func setErrorResponse(errorResponse: ErrorResponse)
}

class BaseConnection<T> where T:BaseMappable, T:BaseResponseProtocol {

    func connect(urlString: String, method: HTTPMethod, headers: [String: String]? = nil) -> Observable<T> {
        return Observable.create({
            observer in

            print("URL \(ServerUrls.baseIUrl + urlString)")
            
            NetworkManager.getSessionManager().request(ServerUrls.baseIUrl + urlString, method: method, parameters: nil, encoding: JSONEncoding.default, headers: nil)
//                .response {
//                    response in
//                    print("Request: \(response.request)")
//                    print("Response: \(response.response)")
//                    print("Error: \(response.error)")
//                }
            
                .responseObject {
                    (response: DataResponse<T>) in
                    switch response.result {
                    case .success :
                        guard let _ = response.value else { break }
                        observer.onNext(response.value!)
                    case .failure(let error) :
                        let res = T()
                        res.setErrorResponse(errorResponse: ErrorResponse(errorMessage: error.localizedDescription))
                        observer.onNext(res)
                    }
                }
            return Disposables.create()
        })
    }

}

