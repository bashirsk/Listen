//
//  EpisodesController.swift
//  Listen
//
//  Created by Bashir Sentongo on 29/04/2019.
//  Copyright © 2019 Bashir Sentongo. All rights reserved.
//

import UIKit

class EpisodesController: UITableViewController {
    
    var podcast: Podcast! {
        didSet {
            self.navigationItem.title = self.podcast.trackName
        }
    }
    
    private let cellID = "cellId"
    
    struct Epiosde {
        let title: String
    }
    
    var episodes = [
        Epiosde(title: "First Episode"),
        Epiosde(title: "Second Episode")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTableView()
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

}
