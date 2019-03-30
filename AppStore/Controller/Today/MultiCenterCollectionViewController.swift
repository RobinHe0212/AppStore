//
//  MultiCenterCollectionViewController.swift
//  AppStore
//
//  Created by Robin He on 3/27/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit


class MultiCenterCollectionViewController: BaseViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if model == .fullScreen{
            navigationController?.navigationBar.isHidden = true
            dismissBtn.constrainWidth(constant: 44)
            dismissBtn.constrainHeight(constant: 44)
            self.view.addSubview(dismissBtn)
            
            dismissBtn.anchor(top: self.collectionView.topAnchor, leading: nil, bottom: nil, trailing: self.collectionView.trailingAnchor,padding: .init(top: 24, left: 0, bottom: 0, right: 24))
        }else {
            collectionView.isScrollEnabled = false
        }
        collectionView.backgroundColor = .white
        collectionView.register(MultipleInsideCell.self, forCellWithReuseIdentifier: cellId)

        
    }
    
    lazy var dismissBtn : UIButton = {
        
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        btn.tintColor = .darkGray
        btn.addTarget(self, action: #selector(closeFullScreen), for: .touchUpInside)
        return btn
        
    }()
    
    @objc func closeFullScreen(){
        
        print("dismiss")
        self.dismiss(animated: true, completion: nil)
    }
    
    let cellId = "cellId"
    
    var result : [AppContent]?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = result?[indexPath.item].id ?? ""
        let controller = SpecificAppDetailViewController(appId: Int(id)!)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MultipleInsideCell
        cell.cellResult = self.result?[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if model == .fullScreen {
            return result?.count ?? 0
        }else {
            return min(4,result?.count ?? 0)
        }
        
        
        
    }
    fileprivate let spacing : CGFloat = 10
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewHeight = self.collectionView.frame.height
        
        if model == .fullScreen {
            return .init(width: self.collectionView.frame.width-24, height: 75)
        }
        let height = (CGFloat(collectionViewHeight) - spacing*3)/4
        return .init(width: self.view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    fileprivate let model : Model
    enum Model {
        case fullScreen, small
    }
    init(model: Model){
        self.model = model
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if model == .fullScreen {
            return .init(top: 20, left: 12, bottom: 24, right: 12)

        }
        return .zero
    }
}
