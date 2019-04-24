//
//  TableViewCell.swift
//  ItuneSearch
//
//  Created by mobileapps on 2019-02-15.
//  Copyright © 2019 mac2_ios. All rights reserved.
//

import Foundation
import UIKit
class TableViewCell: UITableViewCell {
    

    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    func update(with appStoreItem: StoreItem) -> Void {
       
        guard let url = appStoreItem.artworkURL.withHTTPS()else{return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.headLabel.text = appStoreItem.name
                    self.nameLabel.text = appStoreItem.artist
                    self.photoImage.image = image
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }
        task.resume()
       
       
    }
}
