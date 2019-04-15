//
//  PodcastsSearchViewController.swift
//  Listen
//
//  Created by Bashir Sentongo on 02/04/2019.
//  Copyright © 2019 Bashir Sentongo. All rights reserved.
//

import UIKit
import Alamofire

class PodcastsSearchViewController: UITableViewController, UISearchBarDelegate {
    
    var podcast = [Podcast]()
    
    let cellID = "cellID"
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpSearchBar()
        self.setupTableView()
    }
    
    
    //MARK:- Set up
    
    private func setupTableView() {
        let nib = UINib(nibName: "PodcastCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: cellID)
    }
    
    private func setUpSearchBar() {
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.delegate = self
        self.searchController.definesPresentationContext = true 
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        APIService.shared.fetchPodcasts(searchString: searchText) { (pPodcast) in
            self.podcast = pPodcast
            self.tableView.reloadData()
        }
    }
    
    
    //MARK:- UITableView delete methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.podcast.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt pIndexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: pIndexPath) as! PodcastCell
        let podcast = self.podcast[pIndexPath.row]
        cell.podcast = podcast
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132 
    }
}
