//
//  VenuesRepository.swift
//  ForsquareSearch
//
//  Created by Łukasz Wróblak on 20.10.2018.
//  Copyright © 2018 Łukasz Wróblak. All rights reserved.
//

import Foundation
import RxSwift

class VenuesRepository {
    
    var disposeBag = DisposeBag()
    let venueServer = VenuesServer()
    
    func getVenues(searchPhrase: String, lat: Double, lng: Double) -> Observable<VenueResponseDataModel> {
        return Observable.create({
            observer in
            
            VenuesStorage().getVenues(searchPhrase: searchPhrase)
                .flatMap { res -> Observable<VenueResponseDataModel> in
                    if res == nil {
                        return self.venueServer.getVenues(searchPhrase: searchPhrase, lat: lat, lng: lng)
                    }
                    return Observable.from([res!])
                }
                .subscribe(onNext: {
                    result in
                    observer.onNext(result)
                }).disposed(by: self.disposeBag)
            return Disposables.create()
        })
    }

}
