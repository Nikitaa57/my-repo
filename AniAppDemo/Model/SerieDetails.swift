//
//  SerieDetails.swift
//  AniAppDemo
//
//  Created by Nikita Agarwal on 06/11/17.
//  Copyright © 2017 Nikita Agarwal. All rights reserved.
//

import Foundation
import ObjectMapper

class SerieDetails: Mappable {
    
    var id: Int?
    var description: String?
    var characters: [CharacterDetails]?
    var episodes: [Episode]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        description <- map["description"]
        characters <- map["characters"]
        episodes <- map["tags"]
    }
}

