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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        collectionView.register(SpecificAppCell.self, forCellWithReuseIdentifier: specificCellId)
        collectionView.register(ScreenShotAppCell.self, forCellWithReuseIdentifier: previewCellId)
       // collectionView.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellWithReuseIdentifier: <#T##String#>)
        
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
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: specificCellId, for: indexPath) as! SpecificAppCell
            cell.appResult = detailedResult
            return cell
            
        }else  {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewCellId, for: indexPath) as! ScreenShotAppCell
            cell.screenshot.appResult = detailedResult
            
            return cell
        }
       
       
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            // auto-sizing
            let dummyCell = SpecificAppCell(frame: .init(x: 0, y: 0, width: self.view.frame.width, height: 1000))
            dummyCell.appResult = detailedResult
            dummyCell.layoutIfNeeded()
            
            let estimatedCellHeight = dummyCell.systemLayoutSizeFitting(.init(width: self.view.frame.width, height: 1000))
            
            return .init(width: self.view.frame.width, height: estimatedCellHeight.height)
            
        }else {
            
            return .init(width: self.view.frame.width, height: 500)
        }
        
        
    }
}
