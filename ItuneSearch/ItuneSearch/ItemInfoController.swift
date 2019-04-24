//
//  ItemInfoController.swift
//  ItuneSearch
//

//  Created by Anthony Fung on 2019-02-16.
//  Copyright © 2019 mac2_ios. All rights reserved.
//

import Foundation
struct ItemInfoController {

    
    func fetchItemsWithSearchKeyAndCategori(searchKey:String,categori:String,completion: @escaping ([StoreItem]?) -> Void) {
        let query: [String: String] = [
            "term": "\(searchKey)",
            "media": "\(categori)",
            "lang": "en_us",
            "limit": "30"
        ]
        let baseURL = URL(string: "https://itunes.apple.com/search?")!
        
        guard let url = baseURL.withQueries(query) else {
            completion(nil)
            print("Unable to build URL with supplied queries.")
            return
        }
        
        print(url)
        // Parallel Execution Path -----------------------------
        // Runnung this task will convert received data as bytes from web service to swift object
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data,
                let storeItems = try? decoder.decode(StoreItems.self, from: data) {
                completion(storeItems.results)
            } else {
                print("Either no data was returned, or data was not serialized.")
                completion(nil)
                return
            }
        }
        task.resume()
        //------------------------------------------------------
    }
}
