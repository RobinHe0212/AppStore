//
//  SearchViewController.swift
//  AppStore
//
//  Created by Robin He on 3/11/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit


class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout ,UISearchBarDelegate {
    
    
    fileprivate let identifier = "cellId"
    
    let searchBarController = UISearchController(searchResultsController: nil)
    
    let instructionLabel : UILabel = {
        
        let label = UILabel()
        label.text = "Please enter reseach term above..."
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
        
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.addSubview(instructionLabel)
        instructionLabel.fillSuperview( padding: .init(top: 100, left: 50, bottom: 0, right: 50))
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: identifier)
        
        setUpSearchBar()

    }

    init(){
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setUpSearchBar(){
        definesPresentationContext = true
        navigationItem.searchController = searchBarController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchBarController.dimsBackgroundDuringPresentation = false
       searchBarController.searchBar.delegate = self
    }
    
    var timer : Timer?
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        //delay , so the result will not refresh everytime your text change
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            
            Service.shared.fetchApp(search: searchText) { (res, err) in
                if err != nil {
                    fatalError()
                }
                self.result = res
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            
        })
        
        
        
    }
    
    
    var result = [Result]()
    

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! SearchResultCell
        cell.search = self.result[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        instructionLabel.isHidden = self.result.count != 0
        return self.result.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 350)
    }
    
}
