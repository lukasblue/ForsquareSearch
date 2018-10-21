//
//  VenueDataModel.swift
//  ForsquareSearch
//
//  Created by Łukasz Wróblak on 20.10.2018.
//  Copyright © 2018 Łukasz Wróblak. All rights reserved.
//

import Foundation
import ObjectMapper

class VenueDataModel:  Mappable  {
    
    @objc dynamic var id : String?
    @objc dynamic var name : String?
    var location = VenueLocationDataModel()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        location <- map["location"]
    }
}

class VenueLocationDataModel:  Mappable {
    
    @objc dynamic var address: String?
    @objc dynamic var distance: Int = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        address <- map["address"]
        distance <- map["distance"]
    }
}

