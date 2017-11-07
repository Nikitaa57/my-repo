//
//  CharacterDetails.swift
//  AniAppDemo
//
//  Created by Nikita Agarwal on 06/11/17.
//  Copyright © 2017 Nikita Agarwal. All rights reserved.
//

import Foundation
import ObjectMapper

class CharacterDetails: Mappable {
    
    var id: Int?
    var nameFirst: String?
    var nameLast: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        nameFirst <- map["name_first"]
        nameLast <- map["name_last"]
    }
}

