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
    
    init(pFeedItem: RSSFeedItem) {
        self.title = pFeedItem.title ?? ""
        self.pubDate = pFeedItem.pubDate ?? Date()
        self.description = pFeedItem.description ?? ""
    }
}

