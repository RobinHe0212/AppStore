//
//  Searchresult.swift
//  AppStore
//
//  Created by Robin He on 3/11/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import Foundation

struct SearchResult : Decodable {
    let resultCount : Int
    let results : [Result]
}

struct Result : Decodable {
    let trackName : String
    let primaryGenreName : String
    var averageUserRating : Float?
    let artworkUrl512 : String // icon
    let screenshotUrls : [String]
}
