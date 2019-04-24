//
//  CategoryCell.swift
//  IOS_ProjectCourse_FinalProject
//
//  Created by Anthony Fung on 2019-03-29.
//  Copyright © 2019 www.anthonyfung.com. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryItemImage: UIImageView!
    
    @IBOutlet weak var categoryItemNumner: UILabel!
    @IBOutlet weak var categoryItemName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func update (with item: Item) -> Void {
        categoryItemImage.image = item.itemImage
        categoryItemNumner.text = item.itemNumber
        categoryItemName.text = item.itemName
        
        
    }
    
    
}
