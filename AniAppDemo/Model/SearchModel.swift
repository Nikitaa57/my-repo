//
//  SearchModel.swift
//  AniAppDemo
//
//  Created by Nikita Agarwal on 06/11/17.
//  Copyright © 2017 Nikita Agarwal. All rights reserved.
//

import Foundation
import ObjectMapper


class SearchModel: Mappable {
    var id: Int?
    var title: String?
    var bayesianAverage: Double?
    var imageRemotePath: String?
    var plotSummary: String?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title_english"]
        bayesianAverage <- map["bayesianAverage"]
        imageRemotePath <- map["image_url_lge"]
        plotSummary <- map["plotSummary"]
    }

}
