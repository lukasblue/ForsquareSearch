//
//  VenuePresenter.swift
//  ForsquareSearch
//
//  Created by Łukasz Wróblak on 20.10.2018.
//  Copyright © 2018 Łukasz Wróblak. All rights reserved.
//

import Foundation

class VenuePresenter {
    
    private let venueRepository: VenuesRepository
    private let locationRepository: LocationRepository
    weak private var venueView: VenueView?
    
    var currentLat: Double?
    var currentLng: Double?
    
    init(venueRepository: VenuesRepository, locationRepository: LocationRepository) {
        self.venueRepository = venueRepository
        self.locationRepository = locationRepository
    }
    
    func attachView(venueView: VenueView) {
        self.venueView = venueView
    }
    
    func detachView() {
        self.venueView = nil
    }
    
    func getCurrentLocation() {
        self.venueView?.showProgressView()
        locationRepository.getCurrentLocation().subscribe(onNext: {
            result in
            self.venueView?.hideProgressView()
            if result == nil {
                self.venueView?.showCannotFindYourLocation()
            } else if result!.latitude != nil && result!.longitude != nil {
                self.currentLat = result!.latitude!
                self.currentLng = result!.longitude!
            }
        })
    }
    
    func getVenues(searchPhrase: String) {
        self.venueView?.showProgressView()
        
        if self.currentLat != nil && self.currentLng != nil {
            venueRepository.getVenues(searchPhrase: searchPhrase, lat: currentLat!, lng: currentLng!).subscribe(onNext: {
                result in
                self.venueView?.hideProgressView()
                if result.response.venues.count > 0 {
                    self.venueView?.showVenues(venues: result)
                } else {
                    self.venueView?.showNoResults()
                }
            })
        } else {
            self.venueView?.hideProgressView()
            venueView?.showCannotFindYourLocation()
        }
    }
}
