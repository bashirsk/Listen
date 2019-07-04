//
//  PodcastPlayer.swift
//  Listen
//
//  Created by Bashir Sentongo on 02/07/2019.
//  Copyright © 2019 Bashir Sentongo. All rights reserved.
//

import UIKit

class PodcastPlayer: UIView {
    
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var playAndPauseButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 2
        }
    }
    
    var episode: Episode! {
        didSet {
            titleLabel.text = episode.title
            authorLabel.text = episode.author
            if let imageUrl = episode.imageUrl {
                episodeImageView.ls_downloadAndCacheImage(with: imageUrl)
            }
        }
    }
    
    @discardableResult class func showPodcastPlayer(viewController pViewController: UIViewController,
                                                    completion pCompletion: @escaping (PodcastPlayer) -> Void) -> UIView {
        let window = UIApplication.shared.keyWindow
        let podcastPlayer = Bundle.main.loadNibNamed("PodcastPlayer", owner: self, options: nil)?.first as! PodcastPlayer
        podcastPlayer.frame = pViewController.view.frame
        pCompletion(podcastPlayer)
        window?.addSubview(podcastPlayer)
        return podcastPlayer
    }
    
    @IBAction func dismissButton(_ sender: UIButton) {
        removeFromSuperview()
    }
}
