//
//  HomeVC.swift
//  AniAppDemo
//
//  Created by Nikita Agarwal on 06/11/17.
//  Copyright © 2017 Nikita Agarwal. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class HomeVC: UICollectionViewController {
    
    let networkManager = NetworkManager()
    var series = [Serie]()
    
    fileprivate let reuseIdentifier = "AniColCell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    fileprivate let itemsPerRow: CGFloat = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBarColor = navigationController!.navigationBar
        navBarColor.barTintColor = UIColor(red:  255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 100.0/100.0)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        tabBarController?.tabBar.barTintColor = UIColor.red
        tabBarController?.tabBar.tintColor = UIColor.white
       
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
        networkManager.getSeries(accessToken) { (series) in
            self.series = series
            self.collectionView?.reloadData()
        }
    }
}

extension HomeVC {
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return series.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SerieCell
        
        let url = URL(string: series[indexPath.row].thumbImageUrl!)
        cell.image.kf.setImage(with: url)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        let controller = storyboard?.instantiateViewController(withIdentifier: "AniDetailsVC") as! AniDetailsVC
        controller.serie = series[index]
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension HomeVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = view.frame.width
        let widthPerItem = (availableWidth / 3) - 10.5
        let heightPeritem = (widthPerItem * 1.3)
        return CGSize(width: widthPerItem, height: heightPeritem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

