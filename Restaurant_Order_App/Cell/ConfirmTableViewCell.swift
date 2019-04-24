//
//  ConfirmTableViewCell.swift
//  IOS_ProjectCourse_FinalProject
//
//  Created by Anthony Fung on 2019-03-31.
//  Copyright © 2019 www.anthonyfung.com. All rights reserved.
//


// Inorder to make the cell button clickable
// add some code in between *************************
import UIKit

protocol TableViewNew {// **************************************************
    func addButtonOnClick(index: Int)// **************************************************
    func minusButtonOnClick(index: Int)// **************************************************
}

class ConfirmTableViewCell: UITableViewCell {

    var cellDelegate: TableViewNew?// **************************************************
    var index: IndexPath?// **************************************************

    @IBOutlet weak var itemImage: UIImageView!
    
    
    @IBOutlet weak var itemNumberAndName: UILabel!
    
    
    @IBOutlet weak var itemQuantity: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func minusQuantityButtonTapped(_ sender: Any) {// **************************************************
        cellDelegate?.minusButtonOnClick(index: (index?.row)!)// **************************************************
    }
    
    @IBAction func addQuantityButtonTapped(_ sender: Any) {// **************************************************
        cellDelegate?.addButtonOnClick(index: (index?.row)!)// **************************************************
    }
    
    func update (with item: Item) -> Void {
        var itemNumber = ""
        var itemName = ""
        var itemNumberAndItemName = ""
       itemImage.image = item.itemImage
        
        itemNumber = item.itemNumber 
        itemName = item.itemName 
        itemNumberAndItemName = "\(itemNumber). \(itemName)"
        itemNumberAndName.text = itemNumberAndItemName
        itemQuantity.text = String( item.itemQuantity)
        
        
        
    }
}
