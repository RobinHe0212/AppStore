//
//  TodayViewController.swift
//  AppStore
//
//  Created by Robin He on 3/20/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import UIKit


class TodayViewController: BaseViewController, UICollectionViewDelegateFlowLayout {

    
    

    var todayList = [TodayModel]()
    
    let activityIndicator : UIActivityIndicatorView = {
        let acti = UIActivityIndicatorView(style: .whiteLarge)
        acti.color = UIColor.darkGray
        acti.hidesWhenStopped = true
        acti.startAnimating()
        return acti
        
        
        
    }()
    // fix tabbar moving up glitch
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.superview?.setNeedsLayout()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(activityIndicator)
        activityIndicator.centerInSuperview()
        
        let group = DispatchGroup()
        var topGrossingResult : AppsResult?
        var topFreeResult : AppsResult?
        
        group.enter()
        Service.shared.fetchTopFree { (app, err) in
            topGrossingResult = app
            group.leave()
            if err != nil {
                print("error is \(err)")
                return
            }
        }
        group.enter()
        Service.shared.fetchTopGrossing { (app, err) in
            topFreeResult = app
            group.leave()
            if err != nil {
                print("error is \(err)")
                return
            }
        }
        group.notify(queue: .main) {
            self.activityIndicator.stopAnimating()
            self.todayList = [
                
                
                TodayModel.init(title: "Daily List", subTitle: topFreeResult?.feed.title ?? "" , image: UIImage(named: "holiday")!, desc: "", bgc: UIColor.white, appContent: topFreeResult?.feed.results ?? [],cellType: TodayModel.CellEnum.MultiCell),
                TodayModel.init(title: "Daily List", subTitle: topGrossingResult?.feed.title ?? "" , image: UIImage(named: "holiday")!, desc: "", bgc: UIColor.white, appContent: topGrossingResult?.feed.results ?? [] ,cellType: TodayModel.CellEnum.MultiCell),
                TodayModel.init(title: "LIFE HACK", subTitle: "Utilizing your Time", image: UIImage(named:"garden")!, desc: "All the tools and apps you need to intelligently organize your life the right way", bgc: UIColor.white, appContent: [],cellType: TodayModel.CellEnum.singleCell),
                TodayModel.init(title: "HOLIDAYS", subTitle: "Travel on a Budget", image: UIImage(named:"holiday")!, desc: "Find out all you need ti know on how to travel without packing everything", bgc: #colorLiteral(red: 0.9843137255, green: 0.9607843137, blue: 0.7529411765, alpha: 1), appContent: [],cellType: TodayModel.CellEnum.singleCell)
                
                
            
            
            ]
            print("finished fetching")
            self.collectionView.reloadData()
        }
        
        
        navigationController?.navigationBar.isHidden = true
        collectionView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayModel.CellEnum.singleCell.rawValue)
        collectionView.register(TodayMultiCell.self, forCellWithReuseIdentifier: TodayModel.CellEnum.MultiCell.rawValue)
        
    }

    var startFrame : CGRect?
    
    var topConstraint : NSLayoutConstraint?
    var leftConstraint : NSLayoutConstraint?
    var widthConstraint : NSLayoutConstraint?
    var heightConstraint : NSLayoutConstraint?
    
    
    var appFullController : TodayTableView!
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if todayList[indexPath.item].cellType == .MultiCell {
            
            let view = MultiCenterCollectionViewController(model: .fullScreen)
            view.result = todayList[indexPath.item].appContent
            present(BackSwipeController(rootViewController: view) ,animated: true)
            return
        }
        
        let cv = TodayTableView()
        
        self.appFullController = cv
        self.appFullController.result = todayList[indexPath.item]
       
        appFullController.dismissHeader = {
            
            self.dismissPopUpView()
            
        }
        self.addChild(appFullController)
        view.addSubview(appFullController.view)
        
        // avoid glitch because of not 100% refreshing cell
        collectionView.isUserInteractionEnabled = false
        
        let cell = collectionView.cellForItem(at: indexPath) // frame based on superview
        print(cell?.frame)
        print(cell?.bounds)
        guard let startingframe = cell?.superview?.convert((cell?.frame)!, to: nil) else {return} // base on window
        print("starting frame is \(startingframe)")
        appFullController.view.frame = startingframe
        startFrame = startingframe
        
        // use auto constraints to fix the moving-up effect glitch

        appFullController.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.topConstraint = self.appFullController.view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: startingframe.origin.y)
        self.leftConstraint = self.appFullController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: startingframe.origin.x)
        self.widthConstraint =  self.appFullController.view.widthAnchor.constraint(equalToConstant: startingframe.width)
        self.heightConstraint = self.appFullController.view.heightAnchor.constraint(equalToConstant: startingframe.height)
        
        [self.topConstraint,self.leftConstraint,self.widthConstraint,self.heightConstraint].forEach{
            $0?.isActive = true
        }
        appFullController.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
//            cv.view.frame = self.view.frame
            self.topConstraint?.constant = 0
            self.leftConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstraint?.constant = self.view.frame.height
            
            self.view.layoutIfNeeded()
             self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
            
            guard let cell = self.appFullController.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TodayFullScreenHeaderCell else {return}
            cell.today.topConstraint?.constant = 44
            cell.layoutIfNeeded()
            
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
            guard let cell = self.appFullController.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TodayFullScreenHeaderCell else {return}
            cell.today.topConstraint?.constant = 24
            cell.layoutIfNeeded()
            
            
        }) { _ in
            self.collectionView.isUserInteractionEnabled = true
            self.appFullController.view?.removeFromSuperview()
            self.appFullController.removeFromParent()
        }
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellId = todayList[indexPath.item].cellType.rawValue
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseCell
        cell.todayResult = todayList[indexPath.item]
        
        (cell as? TodayMultiCell)?.uiCollectionVC.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapMulti)))
        
        return cell
    }
    
    @objc func tapMulti(gesture:UIGestureRecognizer){
        let collectionView = gesture.view
        var superview = collectionView?.superview
        
        while superview != nil {
           if let cell = superview as? TodayMultiCell {
            guard let indexPath = self.collectionView.indexPath(for:cell ) else {return}
                let apps = self.todayList[indexPath.item].appContent
                let vc = MultiCenterCollectionViewController(model: .fullScreen)
                vc.result = apps
            
                present(vc,animated: true)
                
                
            
            }
           superview = superview?.superview
        }
      
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todayList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.view.frame.width-64, height: 450)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 24, left: 0, bottom: 24, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
}
