//
//  Episode.swift
//  AniAppDemo
//
//  Created by Nikita Agarwal on 06/11/17.
//  Copyright © 2017 Nikita Agarwal. All rights reserved.
//

import Foundation
import ObjectMapper

class Episode: Mappable {
    
    var id: Int?
    var name: String?
    var description: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        description <- map["description"]
    }
}

