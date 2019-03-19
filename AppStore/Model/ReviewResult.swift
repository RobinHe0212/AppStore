//
//  ReviewResult.swift
//  AppStore
//
//  Created by Robin He on 3/18/19.
//  Copyright © 2019 Robin He. All rights reserved.
//

import Foundation

struct ReviewResult : Decodable {
    
    let feed : Entry
    
    
}
struct Entry : Decodable {
    
    let entry : [ReviewDetail]
}
struct ReviewDetail : Decodable {
    
    let author : Name
    let title : Label
    let content : Label
    let rating : Label
    
    private enum CodingKeys : String, CodingKey {
        case author, title, content
        case rating = "im:rating"
    }
}

struct Name : Decodable {
    
    let name : Label
}
struct Label : Decodable {
    let label : String
    
}

