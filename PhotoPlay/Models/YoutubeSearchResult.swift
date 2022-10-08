//
//  YoutubeSearchResult.swift
//  PhotoPlay
//
//  Created by ahmed nagi on 03/10/2022.
//

import Foundation

struct YoutubeSearchResult : Codable{
    let items: [VideoElement]
}

struct VideoElement : Codable {
    let id: IdVideoElement
    
 }

struct IdVideoElement : Codable {
    let kind: String
    let videoId: String
}


