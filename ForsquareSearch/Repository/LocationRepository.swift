//
//  LocationRepository.swift
//  ForsquareSearch
//
//  Created by Łukasz Wróblak on 20.10.2018.
//  Copyright © 2018 Łukasz Wróblak. All rights reserved.
//

import Foundation
import RxSwift

class LocationRepository {
    
    var disposeBag = DisposeBag()
    var locationServ = LocationServer()
    
    func getCurrentLocation() -> Observable<LocationDataModel?> {
        return Observable.create({
            observer in
            
            LocationStorage().getCurrentLocation()
                .flatMap { res -> Observable<LocationDataModel?> in
                    if res == nil {
                        return self.locationServ.getCurrentLocation()
                    }
                    return Observable.just(res)
                }.subscribe(onNext: {
                    result in
                    observer.onNext(result)
                }).disposed(by: self.disposeBag)
            return Disposables.create()
        })
    }
    
}
