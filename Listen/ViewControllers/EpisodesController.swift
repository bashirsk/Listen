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
            self.navigationItem.title = self.podcast.trackName
            self.fetchEpisodes { _ in }
        }
    }
    
    private let cellID = "cellId"
    
    struct Episode {
        let title: String
    }
    
    var episodes = [Episode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTableView()
    }
    
    private func fetchEpisodes(completion pCompletion: @escaping (Error?) -> Void) {
        guard let feedUrl = self.podcast.feedUrl else { return }
        let secureFeedUrl = feedUrl.contains("https") ? feedUrl : feedUrl.replacingOccurrences(of: "http", with: "https")
        guard let url = URL(string: secureFeedUrl) else { return }
        let parser = FeedParser(URL: url)
        parser.parseAsync { (pResult) in
            switch pResult {
            case .rss(let rssFeed):
                rssFeed.items?.forEach({ (pRssFeedItem) in
                    let episode = Episode(title: pRssFeedItem.title ?? "")
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
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellID)
        self.tableView.tableFooterView = UIView()
    }
    
    //MARK:- UITableView
    
    override func tableView(_ pTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ pTableView: UITableView, cellForRowAt pIndexPath: IndexPath) -> UITableViewCell {
        let cell = pTableView.dequeueReusableCell(withIdentifier: self.cellID, for: pIndexPath)
        let episode = self.episodes[pIndexPath.row]
        cell.textLabel?.text = episode.title
        return cell
    }
    
    override func tableView(_ pTableView: UITableView, didSelectRowAt pIndexPath: IndexPath) {
        pTableView.deselectRow(at: pIndexPath, animated: true)
    }

}
