//
//  DetailedAppResult.swift
//  AppStore
//
//  Created by Robin He on 3/17/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import Foundation

struct DetailedAppResult : Decodable {
    let resultCount : Int
    let results : [DetailedResult]
}

struct DetailedResult : Decodable {
    let trackName : String
    let artworkUrl60 : String //icon
    let releaseNotes : String
    
}
