//
//  TodayViewController.swift
//  AppStore
//
//  Created by Robin He on 3/20/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit


class TodayViewController: BaseViewController, UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        collectionView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: cellId)
    }

    var startFrame : CGRect?
    
    var appFullController : UITableViewController!
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cv = TodayTableView()
        self.appFullController = cv
       self.addChild(appFullController)
        view.addSubview(appFullController.view)
        appFullController.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissPopUpView)))
        
        
        let cell = collectionView.cellForItem(at: indexPath) // frame based on superview
        print(cell?.frame)
        print(cell?.bounds)
        guard let startingframe = cell?.superview?.convert((cell?.frame)!, to: nil) else {return} // base on window
        print("starting frame is \(startingframe)")
        cv.view.frame = startingframe
        startFrame = startingframe
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            cv.view.frame = self.view.frame
             self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
        }, completion: nil)
    }
    
    @objc func dismissPopUpView(gesture:UITapGestureRecognizer){
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            gesture.view?.frame = self.startFrame!
            
        }) { _ in
            gesture.view?.removeFromSuperview()
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 0)
            self.appFullController.removeFromParent()
        }
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TodayCell
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.view.frame.width-48, height: 450)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 20, left: 0, bottom: 20, right: 0)
    }
}
