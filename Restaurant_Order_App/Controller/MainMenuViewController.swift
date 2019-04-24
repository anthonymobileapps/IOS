//
//  MainMenuViewController.swift
//  IOS_ProjectCourse_FinalProject
//
//  Created by Anthony Fung on 2019-03-28.
//  Copyright © 2019 www.anthonyfung.com. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController{
    
    @IBOutlet weak var trushButtonTapped: UIBarButtonItem!
    var items : [Item] = []
    let myItem = Item()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        items = myItem.createMainMeunItemArray()

    }
    @IBAction func trushButtonTapped(_ sender: Any) {
        stringArray=[]
        orderList = []
        orderNumber = 0
        dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CategoryCollectionViewCell" { // decstinatin VC identifier
            let destVC = segue.destination as! CategoryCollectionViewController
            destVC.item = items[tableView.indexPathForSelectedRow!.row]
            
        }
    }
    

  

}
extension MainMenuViewController: UITableViewDataSource,UITableViewDelegate{

    //*********************************************************************************
    // 4. Impelement all the func for the row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainMenuCell", for: indexPath) as! MainMenuCell
        cell.update(with: item)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
        
    }    

}
