//
//  LocationServer.swift
//  ForsquareSearch
//
//  Created by Łukasz Wróblak on 20.10.2018.
//  Copyright © 2018 Łukasz Wróblak. All rights reserved.
//

import Foundation
import RxSwift
import CoreLocation

class LocationServer: NSObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var locationPublishSub = PublishSubject<LocationDataModel?>()
    var timeoutObs : Observable<Bool>?
    var timeout : Double = 10
    var locationFound = false
    var disposeBag = DisposeBag()

    func getCurrentLocation() -> Observable<LocationDataModel?> {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.startUpdatingLocation()
        }

        timeoutObs = Observable.create({ observer in
            observer.onNext(false)
            return Disposables.create()
        }).delay(self.timeout, scheduler: MainScheduler.instance)
        
        timeoutObs?.subscribe(onNext : {
            result in
            self.locationPublishSub.onNext(nil)
            self.locationPublishSub.onCompleted()
        }).disposed(by: disposeBag)

        return locationPublishSub
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationManager.stopUpdatingLocation()
        let userLocation :CLLocation = locations[0] as CLLocation

        if locationFound == false {
            locationPublishSub.onNext(LocationDataModel(lat: userLocation.coordinate.latitude, lng: userLocation.coordinate.longitude))
            locationPublishSub.onCompleted()
            locationFound = true
        }
    }

}

