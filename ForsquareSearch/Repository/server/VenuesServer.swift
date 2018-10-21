//
//  VenuesServer.swift
//  ForsquareSearch
//
//  Created by Łukasz Wróblak on 20.10.2018.
//  Copyright © 2018 Łukasz Wróblak. All rights reserved.
//

import Foundation
import RxSwift

//venues server
class VenuesServer {
    
    func getVenues(searchPhrase: String, lat: Double, lng: Double) -> Observable<VenueResponseDataModel> {
        return BaseConnection<VenueResponseDataModel>().connect(urlString: "venues/search?query=\(searchPhrase)&ll=\(lat),\(lng)&client_id=\(ServerUrls.clientId)&client_secret=\(ServerUrls.clientSecret)&v=20181010", method: .get)
    }
    
}
