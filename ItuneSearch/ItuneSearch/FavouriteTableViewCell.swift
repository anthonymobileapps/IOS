//
//  FavouriteTableViewCell.swift
//  ItuneSearch
//
//  Created by Anthony Fung on 2019-02-17.
//  Copyright © 2019 mac2_ios. All rights reserved.
//
//


import Foundation
import UIKit
class FavouriteTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    func update(with storeItem: StoreItem) -> Void {
        
         nameLabel.text = storeItem.name
              headLabel.text = storeItem.artist
                if let imageURL = URL(string: storeItem.artworkURL.description){
                    let data = try? Data (contentsOf: imageURL)
                    if let data = data {
                        let image = UIImage(data:data)
                        DispatchQueue.main.async {
                            self.photoImage.image = image
                        }
                    }
                }
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
   
}

