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
    
    var episode: Episode! {
        didSet {
            self.pubDateLabel.text = episode.pubDate.ls_setUpDate
            self.titleLabel.text = episode.title
            self.descriptionLabel.text = episode.description
        }
    }
     
    


    
    
}
