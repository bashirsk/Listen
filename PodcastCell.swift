//
//  PodcastCell.swift
//  Listen
//
//  Created by Bashir Sentongo on 05/04/2019.
//  Copyright © 2019 Bashir Sentongo. All rights reserved.
//

import UIKit
import SDWebImage

class PodcastCell: UITableViewCell {
    
    @IBOutlet weak var podcastImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var episodeCountLabel: UILabel!
    
    var podcast: Podcast! {
        didSet {
            self.trackNameLabel.text = podcast.trackName
            self.artistNameLabel.text = podcast.artistName
            self.episodeCountLabel.text = "\(podcast.trackCount ?? 0) Episodes"
            self.podcastImageView.ls_downloadAndCacheImage(with: podcast.artworkUrl600 ?? "")
        }
    }
    
    
}
