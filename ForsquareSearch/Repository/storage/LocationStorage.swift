//
//  LocationStorage.swift
//  ForsquareSearch
//
//  Created by Łukasz Wróblak on 20.10.2018.
//  Copyright © 2018 Łukasz Wróblak. All rights reserved.
//

import Foundation
import RxSwift

//maybe in the future we would like to have some local storage - no get location every time it's needed
class LocationStorage {
    
    func getCurrentLocation() -> Observable<LocationDataModel?> {
        return Observable.create({
            observer in
            observer.onNext(nil)
            return Disposables.create()
        })
    }
    
}
