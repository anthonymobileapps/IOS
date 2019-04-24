//
//  ViewController.swift
//  ItuneSearch
//
//  Created by mobileapps on 2019-02-15.
//  Copyright © 2019 mac2_ios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let itemInfoController = ItemInfoController()
    var categori:String = ""
    var searchMusic:String = ""
    var searchArray = [StoreItem]()
    var searching = false
    var searchKey = ""
    var storeItem:StoreItem?
   
    @IBOutlet weak var segmentBar: UISegmentedControl!
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        searchBar.text = "movie"
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
    }


    
    @IBAction func segmentBarTapped(_ sender: UISegmentedControl) {
        switch  sender.selectedSegmentIndex {
        case 0:
          categori = "movie"
         
        case 1:
         categori = "music"
           
        case 2:
             categori = "software"
           
        case 3:
            categori = "ebook"
           
  
        default:
            categori = "all"
        }
            
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toNextVC" {
            
            // Which cell is selected ........................
            let indexPath = tableView.indexPathForSelectedRow!
            let searchItem = searchArray[indexPath.row]
            //................................................
            
            // two step to go to the destination controller because there is navigationController inbetween
            // Create a reference to next VC which is the first VC of UINavigationController
            let navVC = segue.destination as! UINavigationController
            let detailTableViewController = navVC.viewControllers.first as! DetailTableViewController
            //................................................
            detailTableViewController.storeItem = searchItem
           
        }
    }
    @IBAction  func unwindToMain(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        
    }

}
extension ViewController: UISearchBarDelegate,UISearchDisplayDelegate{
  

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchKey = searchBar.text ?? ""
    
        searchKey = searchKey.lowercased()
        
        itemInfoController.fetchItemsWithSearchKeyAndCategori (searchKey: searchKey, categori: categori){ (items) in
            if let items = items {
                self.searchArray = items
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
 
    }
    
}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let appStoreItem = searchArray[indexPath.row]
        print(appStoreItem)
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
       cell.update(with: appStoreItem)
       
        return cell
    }
    //    // can delete set to true
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // delete row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            searchArray.remove(at: indexPath.row)
            //saveToFile()
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }else if editingStyle == .insert{}
        tableView.endUpdates()
        //  saveToFile()
        
    }
    // move row
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //Move selected row
    func tableView(_ tableView: UITableView,
                   moveRowAt fromIndexPath: IndexPath,
                   to: IndexPath) {
        // 1- Remove cell from old place
        let moveItem = searchArray.remove(at: fromIndexPath.row)
        // 2- Insert cell to new place
        searchArray.insert(moveItem, at: to.row)
        // saveToFile()
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                let  searchItem = searchArray[indexPath.row]
        
                performSegue(withIdentifier: "toNextVC", sender: searchItem)
            }
}

