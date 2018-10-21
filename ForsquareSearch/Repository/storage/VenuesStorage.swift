//
//  VenuesStorage.swift
//  ForsquareSearch
//
//  Created by Łukasz Wróblak on 20.10.2018.
//  Copyright © 2018 Łukasz Wróblak. All rights reserved.
//

import Foundation
import RxSwift

//local venues storage
class VenuesStorage {

    func getVenues(searchPhrase: String) -> Observable<VenueResponseDataModel?> {
        return Observable.create({
            observer in
            observer.onNext(nil)
            return Disposables.create()
        })
    }
}
