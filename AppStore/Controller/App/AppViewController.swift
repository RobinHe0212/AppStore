//
//  AppViewController.swift
//  AppStore
//
//  Created by Robin He on 3/12/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit


class AppViewController: BaseViewController, UICollectionViewDelegateFlowLayout {

    fileprivate let cellId = "cellId"
    fileprivate let headerCellId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(AppsHorizontalCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId)
       view.addSubview(activityIndicator)
        activityIndicator.fillSuperview()
        fetchData()
        
    }
    
    var groupFetch = [AppsResult]()
    var group1 : AppsResult?
    var group2 : AppsResult?
    var group3 : AppsResult?
    
    var socialResult = [SocialResult]()
    
    let activityIndicator : UIActivityIndicatorView = {
        
        let activity = UIActivityIndicatorView(style: .whiteLarge)
        activity.hidesWhenStopped = true
        activity.color = .black
        activity.startAnimating()
        return activity
    }()

    
    
    fileprivate func fetchData(){
        
        
        // help u synchronize the data fetching together
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Service.shared.fetchSocialHeader { (result, err) in
            dispatchGroup.leave()
            if err != nil {
                print("error is ", err)
                return
            }
            guard let result = result else {return}
            self.socialResult = result
        }
        
        
        
        
        dispatchGroup.enter()
        Service.shared.fetchTopGrossing { (result, err) in
            
            dispatchGroup.leave()
            if err != nil {
                print("error is ", err)
                return
            }
            
            self.group1 = result
            
        }
       
        dispatchGroup.enter()
        Service.shared.fetchTopFree { (result, err) in
            
            dispatchGroup.leave()
            if err != nil {
                print("error is ", err)
                return
            }
            
            self.group2 = result
            
        }
        
        dispatchGroup.enter()
        Service.shared.fetchNewGames { (result, err) in
            
            dispatchGroup.leave()
            if err != nil {
                print("error is ", err)
                return
            }
            
            self.group3 = result
        }
        
        dispatchGroup.notify(queue: .main) {
            self.activityIndicator.stopAnimating()
           print( "done with all 3 fetch")
            if let group = self.group1 {
                self.groupFetch.append(group)

            }
            if let group = self.group2 {
                self.groupFetch.append(group)
                
            }
            if let group = self.group3 {
                self.groupFetch.append(group)
                
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
         
            
        }
        
        
        
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellId, for: indexPath) as! AppsHorizontalCell
        cell.appsHorizontalVC.socialGroup = socialResult
        cell.appsHorizontalVC.collectionView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsCell
        cell.appResult = groupFetch[indexPath.item]
        cell.horizontalController.getNameForApp = {
            [weak self]   result  in
            let detailVC = SpecificAppDetailViewController()
            detailVC.appid = result.id
            detailVC.navigationItem.title = result.name
 
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupFetch.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
}
