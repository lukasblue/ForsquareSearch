//
//  VenueView.swift
//  ForsquareSearch
//
//  Created by Łukasz Wróblak on 20.10.2018.
//  Copyright © 2018 Łukasz Wróblak. All rights reserved.
//

import Foundation

protocol VenueView : NSObjectProtocol {
    func showVenues(venues: VenueResponseDataModel)
    func showNoResults()
    func showCannotFindYourLocation()
    func showProgressView()
    func hideProgressView()
}
