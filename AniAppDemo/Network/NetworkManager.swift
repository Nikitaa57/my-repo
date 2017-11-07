//
//  NetworkManager.swift
//  AniAppDemo
//
//  Created by Nikita Agarwal on 06/11/17.
//  Copyright © 2017 Nikita Agarwal. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class NetworkManager {
    
    func getAccessToken(completion: @escaping ((String) -> Void)) {
        let parameters = [
            "grant_type": "client_credentials",
            "client_id": clientId,
            "client_secret": clientSecret
        ]
        Alamofire.request("\(baseUrl)/auth/access_token", method: .post, parameters: parameters).responseJSON { response in
            if let json = response.result.value as? [String : Any] {
                let accessToken = json["access_token"] as! String
                completion(accessToken)
            }
        }
    }
    
    func getSeries(_ accessToken: String, completion: @escaping (([Serie]) -> Void)) {
        let url = "\(baseUrl)/browse/anime?access_token=\(accessToken)"
        Alamofire.request(url).responseArray { (response: DataResponse<[Serie]>) in
            if response.error != nil {
                print("Error")
            }
            let seriesArray = response.result.value
            if let seriesArray = seriesArray {
                completion(seriesArray)
            }
        }
    }
    
    func getSerieDetails(_ serieId: Int, completion: @escaping ((SerieDetails) -> Void)) {
        let url = "\(baseUrl)/anime/\(serieId)/page?access_token=\(TokenSession.sharedInstance.accessToken!)"
        Alamofire.request(url).responseObject { (response: DataResponse<SerieDetails>) in
            if response.error != nil {
                print("Error")
            }
            let seriesArray = response.result.value
            if let seriesArray = seriesArray {
                completion(seriesArray)
            }
        }
    }
    
    
    
    func getSearchData(_ accessToken: String, completion: @escaping (([SearchModel]) -> Void)) {
        let url = "\(baseUrl)/browse/anime?access_token=\(accessToken)"
        Alamofire.request(url).responseArray { (response: DataResponse<[SearchModel]>) in
            if response.error != nil {
                print("Error")
            }
            let searchArray = response.result.value
            if let searchResultArray = searchArray {
                completion(searchResultArray)
            }
        }
    }
    
}
