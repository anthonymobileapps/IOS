//
//  Item.swift
//  IOS_ProjectCourse_FinalProject
//
//  Created by Anthony Fung on 2019-03-28.
//  Copyright © 2019 www.anthonyfung.com. All rights reserved.
//



import Foundation
import UIKit


class Item: Codable {
    
    
    var itemImage: UIImage?
    var itemName: String = ""
    var itemNumber: String = ""
    var itemCategory: String = ""
    var itemDescription: String = ""
    var itemQuantity: Int = 0
    
    enum CodingKeys: String, CodingKey{
        
        case itemImage
        case itemName
        case itemNumber
        case itemCategory
        case itemDescription
        case itemQuantity
       
    }
    init() {
        
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        // Mapping betwen instance variables and CodingKeys cases
        itemName = try values.decode(String.self, forKey: CodingKeys.itemName)
        itemNumber = try values.decode(String.self, forKey: CodingKeys.itemNumber)
        itemCategory = try values.decode(String.self, forKey: CodingKeys.itemCategory)
        let itemImageData = try values.decode(Data.self, forKey: CodingKeys.itemImage)
         itemImage = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(itemImageData) as? UIImage
        itemDescription = try values.decode(String.self, forKey: CodingKeys.itemDescription)

        itemQuantity = try values.decode(Int.self, forKey: CodingKeys.itemQuantity)

        
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(itemName, forKey: .itemName)
        try container.encode(itemNumber, forKey: .itemNumber)
         try container.encode(itemCategory, forKey: .itemCategory)
         try container.encode(itemDescription, forKey: .itemDescription)
         try container.encode(itemQuantity, forKey: .itemQuantity)
        
        let itemImageData = try NSKeyedArchiver.archivedData(withRootObject: itemImage!, requiringSecureCoding: false)
        try container.encode(itemImageData, forKey: .itemImage)
        
    }

    
    init(itemImage: UIImage, itemName: String, itemNumber: String, itemCategory:String, description: String,itemQuantity: Int) {
        self.itemImage = itemImage
        self.itemName = itemName
        self.itemNumber = itemNumber
        self.itemCategory = itemCategory
        self.itemDescription = description
        self.itemQuantity = itemQuantity
    }
    init(itemImage:UIImage, itemCategory:String){
        self.itemImage = itemImage
        self.itemCategory = itemCategory
    }
    init(itemImage:UIImage,itemNumber:String, itemName:String, itemCategory:String,itemQuantity: Int){
        self.itemImage = itemImage
        self.itemNumber = itemNumber
        self.itemName = itemName
        self.itemCategory = itemCategory
        self.itemQuantity = itemQuantity
    }
//    static func < (lhs: Item, rhs: Item) -> Bool {
//        var lhsItemNumber = Int(lhs.itemNumber!)
//        var rhsItemNumber =  Int(rhs.itemNumber!)
//        return lhsItemNumber < rhsItemNumber
//    }
//
//    static func == (lhs: StoreItem, rhs: StoreItem) -> Bool {
//        return lhs.artist == rhs.artist && lhs.name == rhs.name && lhs.artworkURL == rhs.artworkURL
//    }

    
     func createMainMeunItemArray() -> [Item]{
        
        
        let item1 = Item (itemImage:UIImage(named: "001")!,itemCategory:"Appertizers")
        let item2 = Item (itemImage:UIImage(named: "025")!,itemCategory:"Sushi")
        let item3 = Item (itemImage:UIImage(named: "050")!,itemCategory:"Sushi Pizzer")
        let item4 = Item (itemImage:UIImage(named: "061")!,itemCategory:"Foto Maki")
        let item5 = Item (itemImage:UIImage(named: "080")!,itemCategory:"Hoso Maki")
        let item6 = Item (itemImage:UIImage(named: "120")!,itemCategory:"Hand Roll")
        let item7 = Item (itemImage:UIImage(named: "150")!,itemCategory:"Noodle")
        
        let items = [item1, item2, item3,item4,item5,item6,item7]

        return items
    }
      func createAppertizersMeunItemArray() -> [Item] {
        
        
              let item1 = Item (itemImage:UIImage(named: "001")!,itemNumber: "1" ,itemName: "Miso Soupe", itemCategory:"Appertizers",itemQuantity: 0)
              let item2 = Item (itemImage:UIImage(named: "003")!,itemNumber: "3" ,itemName: "Kim chi", itemCategory:"Appertizers",itemQuantity: 0)
              let item3 = Item (itemImage:UIImage(named: "005")!,itemNumber: "5" ,itemName: "SeaWeed Salad", itemCategory:"Appertizers",itemQuantity: 0)
              let item4 = Item (itemImage:UIImage(named: "006")!,itemNumber: "6" ,itemName: "Green Salad", itemCategory:"Appertizers",itemQuantity: 0)
              let item5 = Item (itemImage:UIImage(named: "007")!,itemNumber: "7" ,itemName: "House Salade", itemCategory:"Appertizers",itemQuantity: 0)
              let item6 = Item (itemImage:UIImage(named: "008")!,itemNumber: "8" ,itemName: "Seafood Salade", itemCategory:"Appertizers",itemQuantity: 0)
             let item7 = Item (itemImage:UIImage(named: "009")!,itemNumber: "9" ,itemName: "Kimchi Tofu Salade", itemCategory:"Appertizers",itemQuantity: 0)
              let item8 = Item (itemImage:UIImage(named: "010")!,itemNumber: "10" ,itemName: "Cold Tofu", itemCategory:"Appertizers",itemQuantity: 0)
              let item9 = Item (itemImage:UIImage(named: "011")!,itemNumber: "10" ,itemName: "Soyo Bean", itemCategory:"Appertizers",itemQuantity: 0)
              let items = [item1, item2, item3,item4,item5,item6,item7,item8,item9]
       
       
        
            return items
    }
    public var description: String { return "\(String(describing: itemNumber)). \(String(describing: itemName)) \(itemQuantity)" }
    
    
}


