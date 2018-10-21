//
//  LocationDataModel.swift
//  ForsquareSearch
//
//  Created by Łukasz Wróblak on 20.10.2018.
//  Copyright © 2018 Łukasz Wróblak. All rights reserved.
//

import Foundation
import ObjectMapper

class LocationDataModel {
    
    var latitude: Double?
    var longitude: Double?
    
    convenience init(lat: Double, lng: Double) {
        self.init()
        self.latitude = lat
        self.longitude = lng
    }
    
}
