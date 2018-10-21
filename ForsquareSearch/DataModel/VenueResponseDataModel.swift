//
//  VenueResponseDataModel.swift
//  ForsquareSearch
//
//  Created by Łukasz Wróblak on 20.10.2018.
//  Copyright © 2018 Łukasz Wróblak. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class VenueResponseDataModel : BaseResponse, Mappable  {
    
    var meta = VenueResponseMeta()
    var response = VenueResponseWrapper()
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.meta <- map["meta"]
        self.response <- map["response"]
    }
    
}

class VenueResponseWrapper :  Mappable {
    
    var venues = [VenueDataModel]()
//    var venues = List<VenueDataModel>() // realm cache
    
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
//        var ven = [VenueDataModel]() //realm cache
//        ven <- map["venues"]
//        self.venues.append(objectsIn: ven)
        self.venues <- map["venues"]
    }
    
}

class VenueResponseMeta :  Mappable {
    
    @objc dynamic var code: Int = 0
    @objc dynamic var requestId: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.code <- map["code"]
        self.requestId <- map["requestId"]
    }
}

