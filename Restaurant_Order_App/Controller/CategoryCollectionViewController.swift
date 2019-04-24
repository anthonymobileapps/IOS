//
//  CategoryCollectionViewController.swift
//  IOS_ProjectCourse_FinalProject
//
//  Created by Anthony Fung on 2019-03-29.
//  Copyright © 2019 www.anthonyfung.com. All rights reserved.
//

import UIKit


class CategoryCollectionViewController:UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {
    var items:[Item] = []
    var item: Item?
    var category = ""
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myItem = Item()
           navigationItem.title = item?.itemCategory
        print("CategoryCollectionViewController constructor is calledd")
        category = (item?.itemCategory)!
        switch category {
        case "Appertizers":
          items = myItem.createAppertizersMeunItemArray()
        case "Sushi":
            items = myItem.createAppertizersMeunItemArray()
        case "Sushi Pizzer":
            items = myItem.createAppertizersMeunItemArray()
        case "Foto Maki":
            items = myItem.createAppertizersMeunItemArray()
            
        case "Hoso Maki":
            items = myItem.createAppertizersMeunItemArray()
        case "Hand Roll":
            items = myItem.createAppertizersMeunItemArray()
        case "Noodle":
            items = myItem.createAppertizersMeunItemArray()
        default:
            print( "Appertizers")
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.update(with: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // this case I only assign DetailTableViewController as a class name and
        //      DetailTableViewController as Storyboard Id below the class name
        // There is no identifier. The meaning of withIdentifier here is storyboard id
        let desVC = storyboard?.instantiateViewController(withIdentifier:"DetailTableViewController") as? DetailTableViewController
            desVC?.item = items[indexPath.row]
        // set up Detail Table View black button text
        let backItem = UIBarButtonItem()
        backItem.title = "Category"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
     self.navigationController?.pushViewController(desVC!, animated: true)
    }
}
extension CategoryCollectionViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 0, left:10, bottom: 0, right:5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        
        return CGSize(width: bounds.width/2 - 10, height: 195)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

