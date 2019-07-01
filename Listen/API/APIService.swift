//
//  APIService.swift
//  Listen
//
//  Created by Bashir Sentongo on 04/04/2019.
//  Copyright © 2019 Bashir Sentongo. All rights reserved.
//

import Alamofire
import FeedKit

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
    
    func fetchEpisodes(podcast pPodcast: Podcast, completion pCompletion: @escaping (RSSFeed?, Error?) -> Void) {
        guard let feedUrl = pPodcast.feedUrl else { return }
        let secureFeedUrl = feedUrl.contains("https") ? feedUrl : feedUrl.replacingOccurrences(of: "http", with: "https")
        guard let url = URL(string: secureFeedUrl) else { return }
        let parser = FeedParser(URL: url)
        parser.parseAsync { (pResult) in
            switch pResult {
            case .rss(let rssFeed):
                pCompletion(rssFeed, nil)
                break
            case .failure(let error):
                pCompletion(nil, error)
            default:
                break
            }
        }
    }

}
