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
    
    var podcast = [
        Podcast(trackName: "Ruby Rogues", artistName: "Jay Maxwell"),
        Podcast(trackName: "Simple Programmer", artistName: "John Somnez")
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
        let url = "https://itunes.apple.com/search"
        let parameters = ["term": searchText, "media": "podcast"]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (pDataResponse) in
            if let error = pDataResponse.error {
                print("Failed to contact Web API", error)
            }
            guard let data = pDataResponse.data else { return }
            do {
                let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
                searchResult.results.forEach({ (pPodcast) in
                    print(pPodcast.artistName ?? "", pPodcast.trackName ?? "")
                })
                self.podcast = searchResult.results
                self.tableView.reloadData()
            } catch let decodeError {
                print("Failed to decode", decodeError)
            }
        }
    }
    
    struct SearchResults: Decodable  {
        let resultCount: Int
        let results: [Podcast]
    }
    
    //MARK:- UITableView delete methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.podcast.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt pIndexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: pIndexPath)
        let podcast = self.podcast[pIndexPath.row]
        cell.textLabel?.text = "\(podcast.trackName ?? "")\n\(podcast.artistName ?? "")"
        cell.textLabel?.numberOfLines = -1
        cell.imageView?.image = UIImage(named: "appicon")
        return cell
    }
}
