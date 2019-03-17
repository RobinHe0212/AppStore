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
    
    func fetchApp(search:String,completion:@escaping (SearchResult?,Error?)->()){
        print("fetching contents from itunes ")
    
    
    let url = "https://itunes.apple.com/search?term=\(search)&entity=software"
        
        fetchGeneric(url: url, completion: completion)

    
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
    
    // fetch social header
    func fetchSocialHeader(completion:@escaping ([SocialResult]?,Error?)->()){
        
        let url = "https://api.letsbuildthatapp.com/appstore/social"
        
        
        fetchGeneric(url: url, completion: completion)
        
    }

    //generic
func fetchGeneric<T:Decodable>(url: String,completion:@escaping(T?,Error?)->()){

    guard let urlString = URL(string: url) else {return}
    URLSession.shared.dataTask(with: urlString) { (data, res, err) in
        if err != nil {
            print("cannot get url", err)
            completion(nil,err)
            return
        }
        guard let data = data else {return}
        
        do{
            let result = try JSONDecoder().decode(T.self, from: data)
            
            completion(result,nil)
            
            
            
        }catch let jsonErr{
            
            print("cannot parse json",jsonErr)
            completion(nil,jsonErr)
        }
        
        
        }.resume()
    
    
    
    
    
}


    
    //helper
    func fetchGenreHelper(url: String,completion:@escaping (AppsResult?,Error?)->()){
        
        fetchGeneric(url: url, completion: completion)

}
    
    //appdetailhelper
    func fetchDetailedGenreHelper(url: String,completion:@escaping (DetailedAppResult?,Error?)->()){
        
        fetchGeneric(url: url, completion: completion)
        
    }
}
