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
    
    var topConstraint : NSLayoutConstraint?
    var leftConstraint : NSLayoutConstraint?
    var widthConstraint : NSLayoutConstraint?
    var heightConstraint : NSLayoutConstraint?
    
    
    var appFullController : TodayTableView!
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cv = TodayTableView()
        
        self.appFullController = cv
       self.addChild(appFullController)
        view.addSubview(appFullController.view)
        
        appFullController.dismissHeader = {
            
            self.dismissPopUpView()
            
        }
        let cell = collectionView.cellForItem(at: indexPath) // frame based on superview
        print(cell?.frame)
        print(cell?.bounds)
        guard let startingframe = cell?.superview?.convert((cell?.frame)!, to: nil) else {return} // base on window
        print("starting frame is \(startingframe)")
        cv.view.frame = startingframe
        startFrame = startingframe
        
        // use auto constraints to fix the moving-up effect glitch

        cv.view.translatesAutoresizingMaskIntoConstraints = false
        self.topConstraint = cv.view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: startingframe.origin.y)
        self.leftConstraint = cv.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: startingframe.origin.x)
        self.widthConstraint =  cv.view.widthAnchor.constraint(equalToConstant: startingframe.width)
        self.heightConstraint = cv.view.heightAnchor.constraint(equalToConstant: startingframe.height)
        
        [self.topConstraint,self.leftConstraint,self.widthConstraint,self.heightConstraint].forEach{
            $0?.isActive = true
        }
        
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
//            cv.view.frame = self.view.frame
            self.topConstraint?.constant = 0
            self.leftConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstraint?.constant = self.view.frame.height
            
            self.view.layoutIfNeeded()
             self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
        }, completion: nil)
    }
    
    @objc func dismissPopUpView(){
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
//            gesture.view?.frame = self.startFrame ?? .zero
            // back to origin position
            self.appFullController.tableView.contentOffset = .zero
            
            guard let start = self.startFrame else{return}
            self.topConstraint?.constant = start.origin.y
            self.leftConstraint?.constant = start.origin.x
            self.widthConstraint?.constant = start.width
            self.heightConstraint?.constant = start.height
            
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.transform = .identity
            
        }) { _ in
            self.appFullController.view?.removeFromSuperview()
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
