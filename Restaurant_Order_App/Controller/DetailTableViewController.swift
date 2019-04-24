//
//  DetailTableViewController.swift
//  IOS_ProjectCourse_FinalProject
//
//  Created by Anthony Fung on 2019-03-29.
//  Copyright © 2019 www.anthonyfung.com. All rights reserved.
//



import UIKit
var orderList = [Item]()
let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
let archiveURL = documentDirectory.appendingPathComponent("notes").appendingPathExtension("me")
class DetailTableViewController: UIViewController {

    var items:[Item] = []
    var item: Item?
    var itemNumberString = ""
    var itemNameString = ""
   
    var itemCategory = ""
    var identifiyer = ""
    var isAddToCartButtonTapped = false
    
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var itemNameLabel: UILabel!

    @IBOutlet weak var itemQuantityLabel: UILabel!
    
    @IBOutlet weak var removeButton: UIButton!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var orderConfirmButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Item Detail"
        
        if  identifiyer == "DetailViewController"{
            orderConfirmButton.isEnabled = false
            
        }
        
        itemImage.image = item?.itemImage!
        itemNumberString = (item?.itemNumber)!
        itemNameString = (item?.itemName)!
        itemNameLabel.text = ("\(itemNumberString). \(itemNameString)")
        itemCategory = (item?.itemCategory)!
        if let stringQuantity = item?.itemQuantity{
             itemQuantityLabel.text = String(stringQuantity)
        }
    
       
   
    }
    func saveArrayToFile(){
        let propertyListEncoder = PropertyListEncoder()
        let encodedNoteArray = try? propertyListEncoder.encode(orderList)
        try? encodedNoteArray?.write(to: archiveURL, options: .noFileProtection)
        
    }
    
    
    @IBAction func orderComfirmButtonTapped(_ sender: UIButton) {
        
        if (itemQuantityLabel.text != "0" && isAddToCartButtonTapped == false ){
            let orderItem = Item(itemImage: itemImage.image!, itemNumber: itemNumberString, itemName: itemNameString, itemCategory: itemCategory, itemQuantity: ((item?.itemQuantity)!))
            orderList.append(orderItem)
            isAddToCartButtonTapped = true
            orderConfirmButton.isEnabled = false
        }
    }
    
    @IBAction func removeButtonTapped(_ sender: UIButton) {
        if (item?.itemQuantity)! > 0 {
            item?.itemQuantity -= 1
            itemQuantityLabel.text = String(item!.itemQuantity)
        }
    }
    

     var tempQuantity:Int = 0
    @IBAction func addButtonTapped(_ sender: UIButton) {
       
        if (item?.itemQuantity) != nil {
            
               item?.itemQuantity = (item?.itemQuantity)! + 1
            itemQuantityLabel.text = String(item!.itemQuantity)
        
        }
}
    override func viewWillDisappear(_ animated: Bool) {
        saveArrayToFile()
    }
}
