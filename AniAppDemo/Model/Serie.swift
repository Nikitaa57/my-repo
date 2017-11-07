//
//  Serie.swift
//  AniAppDemo
//
//  Created by Nikita Agarwal on 06/11/17.
//  Copyright © 2017 Nikita Agarwal. All rights reserved.
//

import Foundation
import ObjectMapper

class Serie: Mappable {
    
    var id: Int?
    var title: String?
    var thumbImageUrl: String?
    var imageUrl: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title_english"]
        thumbImageUrl <- map["image_url_med"]
        imageUrl <- map["image_url_lge"]
    }
}

