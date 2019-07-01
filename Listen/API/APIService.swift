//
//  APIService.swift
//  Listen
//
//  Created by Bashir Sentongo on 04/04/2019.
//  Copyright © 2019 Bashir Sentongo. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    
    static let shared = APIService()
    
    func fetchPodcasts(searchString: String, completion pCompletion: @escaping ([Podcast], Error?) -> Void) {
        let url = "https://itunes.apple.com/search"
        let parameters = ["term": searchString, "media": "podcast"]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (pDataResponse) in
            if let error = pDataResponse.error {
                pCompletion([], error)
            }
            guard let data = pDataResponse.data else { return }
            do {
                let searchResult = try JSONDecoder().decode(Podcast.SearchResults.self, from: data)
                pCompletion(searchResult.results, nil)
            } catch let decodeError {
                pCompletion([], decodeError)
            }
        }
    }
}
