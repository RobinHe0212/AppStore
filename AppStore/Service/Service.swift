//
//  Service.swift
//  AppStore
//
//  Created by Robin He on 3/11/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service() // singleton
    
    func fetchApp(search:String,completion:@escaping ([Result],Error?)->()){
        print("fetching contents from itunes ")
    
    
    let url = "https://itunes.apple.com/search?term=\(search)&entity=software"
    guard let dataUrl = URL(string: url) else {return}
    
    
    URLSession.shared.dataTask(with: dataUrl) { (data, response, err) in
        if let error = err {
            
            print(error)
            return
        }
        guard let data = data else {return}
        
        do{
            let searchResult = try
                JSONDecoder().decode(SearchResult.self, from: data)
            
            completion(searchResult.results, nil)
            
        }catch let jsonErr{
            print(jsonErr)
            completion([],jsonErr)
            
            
        }
        
        
        }.resume()
    
    }
    
    // Top Grossing games
    func fetchTopGrossing(completion:@escaping (AppsResult?,Error?)->()){
    
    let url = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/50/explicit.json"
        fetchGenreHelper(url: url, completion: completion)
    
    
    }
    // new games
    func fetchNewGames(completion:@escaping (AppsResult?,Error?)->()){
        
        let url = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json"
        fetchGenreHelper(url: url, completion: completion)
        
        
    }
    // Top free
    func fetchTopFree(completion:@escaping (AppsResult?,Error?)->()){
        
        let url = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/50/explicit.json"
        fetchGenreHelper(url: url, completion: completion)
        
        
    }
    
    
    //helper
    func fetchGenreHelper(url: String,completion:@escaping (AppsResult?,Error?)->()){
        
        guard let urlString = URL(string: url) else {return}
        URLSession.shared.dataTask(with: urlString) { (data, res, err) in
            if err != nil {
                print("cannot get url", err)
                completion(nil,err)
                return
            }
            guard let data = data else {return}
            
            do{
                let result = try JSONDecoder().decode(AppsResult.self, from: data)
                
                completion(result,nil)
                
                
                
            }catch let jsonErr{
                
                print("cannot parse json",jsonErr)
                completion(nil,jsonErr)
            }
            
            
            }.resume()
        
        
        
    }
    
}
