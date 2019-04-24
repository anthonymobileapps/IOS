//
//  ConfirmViewController.swift
//  IOS_ProjectCourse_FinalProject
//
//  Created by Anthony Fung on 2019-03-31.
//  Copyright © 2019 www.anthonyfung.com. All rights reserved.
//

import UIKit
var orderNumber = 0
var stringArray = [String]()
class ConfirmViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    let saveObjectToFile = SaveObjectToFile()
    var confirmList = [Item]()
    var item:[Item]?
    var itemQuantityLabel:String?
    var resultString:String = ""
    var saveButtonCanSave:Bool?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         print("ConfirmViewController Called")
         orderList = saveObjectToFile.readArrayFromFile()
    }
 
    override func viewWillAppear(_ animated: Bool) {
        print("ConfirmViewController viewDidAppear Called")
        /////////////////////////////////////////////////////////
        confirmList = orderList
        saveButtonCanSave = true
        if confirmList.count == 0 {
            title = "No pending order"
        }else{
            title = "Order list"
        }
        tableView.reloadData()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if saveButtonCanSave == true {
        if orderList.count != 0 {
            print("Successfully save")
            resultString = ""
            print ("resulString 1 =  \(resultString)\n")
            orderNumber += 1
            resultString = String(orderNumber) + ".\n"
            resultString += saveObjectToFile.getCurrentDateStringForRest()
            resultString += "\n"
            resultString += saveObjectToFile.convertArrayToString(arr: confirmList)
            stringArray.append(resultString)
            resultString = ""            
            orderList = []
            confirmList = []
            
            tableView.reloadData()
            }
        }
        saveButtonCanSave = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  confirmList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = confirmList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConfirmTableViewCell", for: indexPath) as! ConfirmTableViewCell
        cell.cellDelegate = self //as TableViewNew// **************************************************
        cell.index = indexPath// **************************************************
        
        cell.update(with: item)
        itemQuantityLabel = cell.itemQuantity.text // **************************************************
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
}

// **************************************************
// In between star bolg
    extension ConfirmViewController:TableViewNew{
    func addButtonOnClick(index: Int) {
        // cast itemQuantityLabel to integer
        let tempVar = Int(itemQuantityLabel ?? "0")! + 1
        confirmList[index].itemQuantity = tempVar
        tableView.reloadData()
    }
    
    func minusButtonOnClick(index: Int) {
       var  tempVar = Int(itemQuantityLabel ?? "0" )!
       if tempVar > 0 {
        // cast itemQuantityLabel to integer
         tempVar = Int(itemQuantityLabel ?? "0")! - 1
        confirmList[index].itemQuantity = tempVar
        tableView.reloadData()
        }
    }
}
// **************************************************
