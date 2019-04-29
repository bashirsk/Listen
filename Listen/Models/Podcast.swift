//
//  Podcast.swift
//  Listen
//
//  Created by Bashir Sentongo on 02/04/2019.
//  Copyright © 2019 Bashir Sentongo. All rights reserved.
//

import Foundation

struct Podcast: Decodable {
    var trackName: String?
    var artistName: String?
    var artworkUrl600: String?
    var trackCount: Int?
    var feedUrl: String?
    
    struct SearchResults: Decodable  {
        let results: [Podcast]
    }
}


