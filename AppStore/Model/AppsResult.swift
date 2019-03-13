//
//  AppsResult.swift
//  AppStore
//
//  Created by Robin He on 3/13/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import Foundation

struct AppsResult : Decodable {
    
    let feed : Content
    
}

struct Content : Decodable {
    let title : String
    let results : [AppContent]
}

struct AppContent : Decodable {
    
    let artistName : String
    let artworkUrl100 : String
    let name : String
}
