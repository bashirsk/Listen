//
//  RSSFeed+LS.swift
//  Listen
//
//  Created by Bashir Sentongo on 01/07/2019.
//  Copyright © 2019 Bashir Sentongo. All rights reserved.
//


import FeedKit

extension RSSFeed {
    
    func ls_toEpisodes() -> [Episode] {
        let imageUrl = iTunes?.iTunesImage?.attributes?.href
        var episodes = [Episode]()
        items?.forEach({ (pRssFeedItem) in
            var episode = Episode(pFeedItem: pRssFeedItem)
            if episode.imageUrl == nil {
                episode.imageUrl = imageUrl
            }
            episodes.append(episode)
        })
        return episodes
    }
}
