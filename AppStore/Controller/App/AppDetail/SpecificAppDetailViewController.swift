//
//  SpecificAppDetailViewController.swift
//  AppStore
//
//  Created by Robin He on 3/17/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit


class SpecificAppDetailViewController: BaseViewController, UICollectionViewDelegateFlowLayout {

    let specificCellId = "specificCellId"
    let previewCellId = "previewCellId"
    let screenShotCellId = "screenShotCellId"
    
    fileprivate let appid : String
    
    init(appId:Int){
        
        self.appid = String(appId)
        super.init()
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        collectionView.register(SpecificAppCell.self, forCellWithReuseIdentifier: specificCellId)
        collectionView.register(ScreenShotAppCell.self, forCellWithReuseIdentifier: screenShotCellId)
        collectionView.register(ReviewAppCell.self, forCellWithReuseIdentifier: previewCellId)
        fetchData()
        
    }
    
    func fetchData(){
        let urlString = "https://itunes.apple.com/lookup?id=\(appid ?? "")"
        Service.shared.fetchDetailedGenreHelper(url: urlString) { (result, err) in
            if err != nil {
                print(err)
                return
            }
            self.detailedResult = result?.results.first
            
            DispatchQueue.main.async {
                
                self.collectionView.reloadData()
            }
            
        }
        let reviewUrl = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appid ?? "")/sortby=mostrecent/json?l=en&cc=us"
        Service.shared.fetchGeneric(url: reviewUrl) { (result:ReviewResult?, err) in
            if err != nil {
                print("error is",err)
                return
            }
            guard let result = result else {return}
            print(result.feed.entry)
            self.review = result.feed.entry
            DispatchQueue.main.async {
                
                self.collectionView.reloadData()
            }
            
            
            
        }
        
    }
    
    var detailedResult : DetailedResult?
    var review : [ReviewDetail]?
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: specificCellId, for: indexPath) as! SpecificAppCell
            cell.appResult = detailedResult
            return cell
            
        }else if indexPath.item == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: screenShotCellId, for: indexPath) as! ScreenShotAppCell
            cell.screenshot.appResult = detailedResult
            
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewCellId, for: indexPath) as! ReviewAppCell
            if let review = self.review {
                cell.reviewCV.reviewDetail = review
            }
            
            return cell
            
        }
       
       
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            // auto-sizing
            let dummyCell = SpecificAppCell(frame: .init(x: 0, y: 0, width: self.view.frame.width, height: 1000))
            dummyCell.appResult = detailedResult
            dummyCell.layoutIfNeeded()
            
            let estimatedCellHeight = dummyCell.systemLayoutSizeFitting(.init(width: self.view.frame.width, height: 1000))
            
            return .init(width: self.view.frame.width, height: estimatedCellHeight.height)
            
        }else if indexPath.item == 1{
            
            return .init(width: self.view.frame.width, height: 500)
        }else {
            return .init(width: self.view.frame.width, height: 250)
        }
        
        
    }
}
