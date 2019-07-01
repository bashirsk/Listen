//
//  EpisodesController.swift
//  Listen
//
//  Created by Bashir Sentongo on 29/04/2019.
//  Copyright © 2019 Bashir Sentongo. All rights reserved.
//

import UIKit
import FeedKit

class EpisodesController: UITableViewController {
    
    var podcast: Podcast! {
        didSet {
            navigationItem.title = podcast.trackName
            fetchEpisodes { _ in }
        }
    }
    
    private let cellID = "cellId"
    
    var episodes = [Episode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    private func fetchEpisodes(completion pCompletion: @escaping (Error?) -> Void) {
        guard let feedUrl = podcast.feedUrl else { return }
        let secureFeedUrl = feedUrl.contains("https") ? feedUrl : feedUrl.replacingOccurrences(of: "http", with: "https")
        guard let url = URL(string: secureFeedUrl) else { return }
        let parser = FeedParser(URL: url)
        parser.parseAsync { (pResult) in
            switch pResult {
            case .rss(let rssFeed):
                rssFeed.items?.forEach({ (pRssFeedItem) in
                    let episode = Episode(pFeedItem: pRssFeedItem)
                    self.episodes.append(episode)
                    pCompletion(nil)
                })
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                break
            case .failure(let error):
                pCompletion(error)
            default:
                break
            }
        }
    }
    
    //MARK:- Set up TableView
    
    private func setUpTableView() {
        let nib = UINib(nibName: "EpisodeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView()
    }
    
    //MARK:- UITableView
    
    override func tableView(_ pTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ pTableView: UITableView, cellForRowAt pIndexPath: IndexPath) -> UITableViewCell {
        let cell = pTableView.dequeueReusableCell(withIdentifier: cellID, for: pIndexPath) as! EpisodeCell
        let episode = episodes[pIndexPath.row]
        cell.episode = episode
        return cell
    }
    
    override func tableView(_ pTableView: UITableView, didSelectRowAt pIndexPath: IndexPath) {
        pTableView.deselectRow(at: pIndexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
}
