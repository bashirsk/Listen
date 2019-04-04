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
    
    let podcasts = [
        Podcast(name: "Ruby Rogues", artistName: "Jay Maxwell"),
        Podcast(name: "Simple Programmer", artistName: "John Somnez")
    ]
    
    let cellID = "cellID"
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpSearchBar()
        self.setupTableView()
    }
    
    
    //MARK:- Set up
    
    private func setupTableView() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    private func setUpSearchBar() {
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let url = "https://itunes.apple.com/search?term=\(searchText)"
        Alamofire.request(url).responseData { (pDataResponse) in
            if let error = pDataResponse.error {
                print("Failed to contact Yahoo", error)
            }
            
            guard let data = pDataResponse.data else { return }
            let dummyString = String(data: data, encoding: .utf8)
            print(dummyString)
        }
    }
    
    //MARK:- UITableView delete methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt pIndexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: pIndexPath)
        let podcast = self.podcasts[pIndexPath.row]
        cell.textLabel?.text = "\(podcast.name)\n\(podcast.artistName)"
        cell.textLabel?.numberOfLines = -1
        cell.imageView?.image = UIImage(named: "appicon")
        return cell
    }
}
