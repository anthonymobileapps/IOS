//
//  MainMenuCell.swift
//  IOS_ProjectCourse_FinalProject
//
//  Created by Anthony Fung on 2019-03-28.
//  Copyright © 2019 www.anthonyfung.com. All rights reserved.
//

import UIKit

class MainMenuCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemCategory: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func update (with item: Item) -> Void {
        itemImage.image = item.itemImage
        itemCategory.text = item.itemCategory
        
        
    }


}
