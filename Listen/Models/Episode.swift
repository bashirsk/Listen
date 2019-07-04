//
//  Episode.swift
//  Listen
//
//  Created by Bashir Sentongo on 07/05/2019.
//  Copyright © 2019 Bashir Sentongo. All rights reserved.
//

import Foundation
import FeedKit

struct Episode {
    
    let title: String
    let pubDate: Date
    let description: String
    var imageUrl: String?
    var author: String
    
    init(pFeedItem: RSSFeedItem) {
        self.title = pFeedItem.title ?? ""
        self.author = pFeedItem.iTunes?.iTunesAuthor ?? ""
        self.pubDate = pFeedItem.pubDate ?? Date()
        self.description = pFeedItem.iTunes?.iTunesSubtitle ?? pFeedItem.description ?? ""
        self.imageUrl = pFeedItem.iTunes?.iTunesImage?.attributes?.href
    }
}

