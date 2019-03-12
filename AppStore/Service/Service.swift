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
    
    
}
