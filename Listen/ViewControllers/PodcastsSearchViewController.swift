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
    
    var podcasts = [Podcast]()
    let cellID = "cellID"
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        setupTableView()
    }
    
    //MARK:- Set up
    
    private func setupTableView() {
        let nib = UINib(nibName: "PodcastCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView()
    }
    
    private func setUpSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.definesPresentationContext = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        APIService.shared.fetchPodcasts(searchString: searchText) { pPodcast, _ in
            self.podcasts = pPodcast
            self.tableView.reloadData()
        }
    }
    
    
    //MARK:- UITableView delete methods
    
    override func tableView(_ pTableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Please enter a Search Term"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .purple
        return label
    }
    
    override func tableView(_ pTableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  podcasts.count > 0 ? 0 : 250
    }
    
    override func tableView(_ pTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ pTableView: UITableView, cellForRowAt pIndexPath: IndexPath) -> UITableViewCell {
        let cell = pTableView.dequeueReusableCell(withIdentifier: cellID, for: pIndexPath) as! PodcastCell
        let podcast = podcasts[pIndexPath.row]
        cell.podcast = podcast
        return cell
    }
    
    override func tableView(_ pTableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132 
    }
    
    override func tableView(_ pTableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pTableView.deselectRow(at: indexPath, animated: true)
        let episodesController = EpisodesController()
        let podcast = podcasts[indexPath.row]
        episodesController.podcast = podcast
        navigationController?.pushViewController(episodesController, animated: true)
    }
}
