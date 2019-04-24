//
//  Artist.swift
//  ItuneSearch
//
//  Created by mobileapps on 2019-02-15.
//  Copyright © 2019 mac2_ios. All rights reserved.
//

import Foundation
import UIKit


struct StoreItems: Codable {
 
    
    let results: [StoreItem]
}

struct StoreItem: Codable, Equatable, Comparable {
    
    var name: String
    var artist: String
    var description: String
    var kind: String
    var artworkURL: URL
    // var categori: String
    static func < (lhs: StoreItem, rhs: StoreItem) -> Bool {
        return lhs.artist < rhs.artist
    }
    
    static func == (lhs: StoreItem, rhs: StoreItem) -> Bool {
        return lhs.artist == rhs.artist && lhs.name == rhs.name && lhs.artworkURL == rhs.artworkURL
    }
    
    
    enum CodingKeys: String, CodingKey {
        // Mapping between enum CodingKeys with JSON keys or accessing JSON keys
        case name = "trackName"
        case artist = "artistName"
        case kind = "kind"
        case description = "description"
        case artworkURL = "artworkUrl100"
        
}
    
    enum AdditionalKeys: String, CodingKey {
        case longDescription
}
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        // Mapping betwen instance variables and CodingKeys cases
       name = try values.decode(String.self, forKey: CodingKeys.name)
        artist = try values.decode(String.self, forKey: CodingKeys.artist)
        kind = try values.decode(String.self, forKey: CodingKeys.kind)
        artworkURL = try values.decode(URL.self, forKey: CodingKeys.artworkURL)
      
        
        if let description = try? values.decode(String.self, forKey: CodingKeys.description) {
            self.description = description
        } else {
    
            let additionalValues = try decoder.container(keyedBy: AdditionalKeys.self)
            description = (try? additionalValues.decode(String.self, forKey: AdditionalKeys.longDescription)) ?? ""
        }
       
    }
    
}

