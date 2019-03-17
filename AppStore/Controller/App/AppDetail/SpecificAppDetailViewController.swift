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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        collectionView.register(SpecificAppCell.self, forCellWithReuseIdentifier: specificCellId)
        
        
    }
    var detailedResult : DetailedResult?
    var appid : String? {
        
        didSet{
            let urlString = "https://itunes.apple.com/lookup?id=\(appid ?? "")"
            print(urlString)
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
          
            
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: specificCellId, for: indexPath) as! SpecificAppCell
        cell.appResult = detailedResult
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // auto-sizing
        let dummyCell = SpecificAppCell(frame: .init(x: 0, y: 0, width: self.view.frame.width, height: 1000))
        dummyCell.appResult = detailedResult
        dummyCell.layoutIfNeeded()
        
        let estimatedCellHeight = dummyCell.systemLayoutSizeFitting(.init(width: self.view.frame.width, height: 1000))
 
        return .init(width: self.view.frame.width, height: estimatedCellHeight.height)
    }
}
