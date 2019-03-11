//
//  SearchViewController.swift
//  AppStore
//
//  Created by Robin He on 3/11/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit


class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    fileprivate let identifier = "cellId"

    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: identifier)
        fetchitunesApps()

    }

    init(){
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var result = [Result]()
    
    fileprivate func fetchitunesApps(){
        
        Service.shared.fetchApp { (resultList,err)  in
            if err != nil {
                print("There's sth error is",err)
                return
            }
            self.result = resultList
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                
            }
            print("finish fetching from itunes")

        }
        
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! SearchResultCell
        cell.search = self.result[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.result.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 350)
    }
    
}
