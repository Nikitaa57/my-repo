//
//  MangaSearchViewController.swift
//  AniAppDemo
//
//  Created by Nikita Agarwal on 06/11/17.
//  Copyright © 2017 Nikita Agarwal. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Kingfisher

class AniSearchVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating {

    let networkManager = NetworkManager()
    var searchModel = [SearchModel]()
    var searchModelBase = [SearchModel]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var searchController: UISearchController!
    private var cache = NSCache<AnyObject, AnyObject>()
    
    private var fetchInProgressCount = 0
    private let photoPlaceholderImage = UIImage(named: "mangaPlaceholder")
    
    var singleTapInSearchModeGestureRecognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBarColor = navigationController!.navigationBar
        navBarColor.barTintColor = UIColor(red:  255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 100.0/100.0)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        tabBarController?.tabBar.barTintColor = UIColor.red
        tabBarController?.tabBar.tintColor = UIColor.white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        
        singleTapInSearchModeGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector(("singleTapInSearchMode:")))
        singleTapInSearchModeGestureRecognizer.numberOfTapsRequired = 1
        
        // Search controller
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "Search by title"
        
        tableView.tableHeaderView = searchController.searchBar
        self.definesPresentationContext = true
        
        tableView.estimatedRowHeight = 62.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        getAccessToken()
    }
    
    
    func getAccessToken() {
        networkManager.getAccessToken { accessToken in
            TokenSession.sharedInstance.accessToken = accessToken
            self.getSeries(accessToken: accessToken)
        }
    }
    
    func getSeries(accessToken: String) {
        print(accessToken)
        networkManager.getSearchData(accessToken) { (searchModel) in
            self.searchModel = searchModel
            self.searchModelBase = searchModel
            self.tableView?.reloadData()
        }
    }
    
    
    // MARK: UIGesture
    
    func singleTapInSearchMode(recognizer: UITapGestureRecognizer) {
        searchController.searchBar.resignFirstResponder()
    }
    
    // MARK: - UISearchController delegates
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchString = searchController.searchBar.text!
        
        if !searchString.isEmpty || searchModel.count > 0 {
            activityIndicator.startAnimating()
            //fetchMangas(searchString: searchString)
        }
    }
    
    
    // MARK: - TableView delegates & data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell     {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MangaSearchResultCell", for: indexPath) as! MangaTableViewCell
        //let cell: MangaTableViewCell = MangaTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "MangaSearchResultCell") as! MangaTableViewCell
    
        let searchData = searchModel[indexPath.row]
        cell.titleLabel.text = searchData.title
        let url = URL(string: searchData.imageRemotePath!)
        cell.mangaImageView.kf.setImage(with: url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0;//Choose your custom row height
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // If we haven't typed anything into the search bar then do not filter the results
        if searchController.searchBar.text! == "" {
            searchModel = self.searchModelBase
        } else {
            // Filter the results
            //searchModel = self.searchModelBase.filter{$0.contains(searchController.searchBar.text!.lowercased()) }
            searchModel = self.searchModelBase.filter {$0.title?.lowercased().contains(searchController.searchBar.text!.lowercased()) == true}
        }
        
        self.tableView.reloadData()
    }
}
