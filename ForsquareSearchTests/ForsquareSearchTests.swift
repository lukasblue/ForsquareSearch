//
//  ForsquareSearchTests.swift
//  ForsquareSearchTests
//
//  Created by Łukasz Wróblak on 20.10.2018.
//  Copyright © 2018 Łukasz Wróblak. All rights reserved.
//

import XCTest
import RxSwift
import RxTest

@testable import ForsquareSearch

class ForsquareSearchTests: XCTestCase {
    
    func testGotVenuesGotLocation_GetCurrentLocation()  {
        let venueViewMock = VenueViewMock()
        let venuePresenter = VenuePresenter(venueRepository: VenuesRepositoryMock(), locationRepository: LocationRepositoryMock())
        venuePresenter.attachView(venueView: venueViewMock)

        venuePresenter.getCurrentLocation() //when

        XCTAssertFalse(venueViewMock.showCannotFindYourLocationCalled) //verify
        XCTAssertTrue(venueViewMock.showProgressViewCalled) //verify
        XCTAssertTrue(venueViewMock.hideProgressViewCalled) //verify
    }
    
    func testGotVenuesNoLocation_GetCurrentLocation() {

        let venueViewMock = VenueViewMock()
        let venuePresenter = VenuePresenter(venueRepository: VenuesRepositoryMock(), locationRepository: LocationRepositoryFailMock())
        venuePresenter.attachView(venueView: venueViewMock)
        
        venuePresenter.getCurrentLocation() //when
        
        XCTAssertTrue(venueViewMock.showCannotFindYourLocationCalled) //verify
        XCTAssertTrue(venueViewMock.showProgressViewCalled) //verify
        XCTAssertTrue(venueViewMock.hideProgressViewCalled) //verify
    }
    
    
    func testNoVenuesGotLocation_GetCurrentLocation() {
        let venueViewMock = VenueViewMock()
        let venuePresenter = VenuePresenter(venueRepository: VenuesRepositoryFailMock(), locationRepository: LocationRepositoryMock())
        venuePresenter.attachView(venueView: venueViewMock)
        
        venuePresenter.getCurrentLocation() //when
        
        XCTAssertFalse(venueViewMock.showCannotFindYourLocationCalled) //verify
        XCTAssertTrue(venueViewMock.showProgressViewCalled) //verify
        XCTAssertTrue(venueViewMock.hideProgressViewCalled) //verify
    }
    
    func testNoVenuesnoLocation_GetCurrentLocation() {
        let venueViewMock = VenueViewMock()
        let venuePresenter = VenuePresenter(venueRepository: VenuesRepositoryFailMock(), locationRepository: LocationRepositoryFailMock())
        venuePresenter.attachView(venueView: venueViewMock)
        
        venuePresenter.getCurrentLocation() //when
        
        XCTAssertTrue(venueViewMock.showCannotFindYourLocationCalled) //verify
        XCTAssertTrue(venueViewMock.showProgressViewCalled) //verify
        XCTAssertTrue(venueViewMock.hideProgressViewCalled) //verify
    }
    
    func testGotVenuesGotLocation_GetVenues()  {
        let venueViewMock = VenueViewMock()
        let venuePresenter = VenuePresenter(venueRepository: VenuesRepositoryMock(), locationRepository: LocationRepositoryMock())
        venuePresenter.attachView(venueView: venueViewMock)
        
        venuePresenter.currentLat = 54.31382
        venuePresenter.currentLng = 18.643511
        venuePresenter.getVenues(searchPhrase: "test") //when
        
        XCTAssertTrue(venueViewMock.showVenuesCalled) //verify
        XCTAssertTrue(venueViewMock.showProgressViewCalled) //verify
        XCTAssertTrue(venueViewMock.hideProgressViewCalled) //verify
    }
    
    func testGotVenuesNoLocation_GetVenues() {
        
        let venueViewMock = VenueViewMock()
        let venuePresenter = VenuePresenter(venueRepository: VenuesRepositoryMock(), locationRepository: LocationRepositoryFailMock())
        venuePresenter.attachView(venueView: venueViewMock)
        
        venuePresenter.getVenues(searchPhrase: "test") //when
        
        XCTAssertTrue(venueViewMock.showCannotFindYourLocationCalled) //verify
        XCTAssertTrue(venueViewMock.showProgressViewCalled) //verify
        XCTAssertTrue(venueViewMock.hideProgressViewCalled) //verify
    }
    
    
    func testNoVenuesGotLocation_GetVenues() {
        let venueViewMock = VenueViewMock()
        let venuePresenter = VenuePresenter(venueRepository: VenuesRepositoryFailMock(), locationRepository: LocationRepositoryMock())
        venuePresenter.attachView(venueView: venueViewMock)
        
        venuePresenter.currentLat = 54.31382
        venuePresenter.currentLng = 18.643511
        venuePresenter.getVenues(searchPhrase: "test") //when
        
        XCTAssertTrue(venueViewMock.showNoResultsCalled) //verify
        XCTAssertTrue(venueViewMock.showProgressViewCalled) //verify
        XCTAssertTrue(venueViewMock.hideProgressViewCalled) //verify
    }
    
    func testNoVenuesnoLocation_GetVenues() {
        let venueViewMock = VenueViewMock()
        let venuePresenter = VenuePresenter(venueRepository: VenuesRepositoryFailMock(), locationRepository: LocationRepositoryFailMock())
        venuePresenter.attachView(venueView: venueViewMock)
        
        venuePresenter.getVenues(searchPhrase: "test") //when
        
        XCTAssertTrue(venueViewMock.showCannotFindYourLocationCalled) //verify
        XCTAssertTrue(venueViewMock.showProgressViewCalled) //verify
        XCTAssertTrue(venueViewMock.hideProgressViewCalled) //verify
    }

}

class VenueViewMock : NSObject, VenueView  {
    var showVenuesCalled = false
    var showNoResultsCalled = false
    var showCannotFindYourLocationCalled = false
    var showProgressViewCalled = false
    var hideProgressViewCalled = false
    
    func showVenues(venues: VenueResponseDataModel) {
        showVenuesCalled = true
    }
    
    func showNoResults() {
        showNoResultsCalled = true
    }

    func showCannotFindYourLocation() {
        showCannotFindYourLocationCalled = true
    }
    
    func showProgressView() {
        showProgressViewCalled = true
    }
    
    func hideProgressView() {
        hideProgressViewCalled = true
    }
    
}

class LocationRepositoryMock : LocationRepository {
    override func getCurrentLocation() -> Observable<LocationDataModel?> {
        return Observable.create({
            observer in
            observer.onNext(LocationDataModel(lat: 54, lng: 18))
            return Disposables.create()
        })
    }
}

class LocationRepositoryFailMock : LocationRepository {
    override func getCurrentLocation() -> Observable<LocationDataModel?> {
        return Observable.create({
            observer in
            observer.onNext(nil)
            return Disposables.create()
        })
    }
}

class VenuesRepositoryMock : VenuesRepository {
    
    override func getVenues(searchPhrase: String, lat: Double, lng: Double) -> Observable<VenueResponseDataModel> {
        return Observable.create({
            observer in
            let result = VenueResponseDataModel()
            let venue = VenueDataModel()
            venue.id = "test id"
            venue.name = "test name"
            result.response.venues.append(venue)
            observer.onNext(result)
            return Disposables.create()
        })
    }
}

class VenuesRepositoryFailMock : VenuesRepository {
    
    override func getVenues(searchPhrase: String, lat: Double, lng: Double) -> Observable<VenueResponseDataModel> {
        return Observable.create({
            observer in
            let result = VenueResponseDataModel()
            observer.onNext(result)
            return Disposables.create()
        })
    }
}


