//
//  EpisodeCell.swift
//  Listen
//
//  Created by Bashir Sentongo on 07/05/2019.
//  Copyright © 2019 Bashir Sentongo. All rights reserved.
//

import UIKit

class EpisodeCell: UITableViewCell {
    
    @IBOutlet weak var pubDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var episodeImageView: UIImageView!
    
    var episode: Episode! {
        didSet {
            pubDateLabel.text = episode.pubDate.ls_setUpDate
            titleLabel.text = episode.title
            descriptionLabel.text = episode.description
            if let imageUrl = episode.imageUrl?.ls_toSecureHTTPS {
                episodeImageView.ls_downloadAndCacheImage(with: imageUrl)
            }
        }
    }
}
