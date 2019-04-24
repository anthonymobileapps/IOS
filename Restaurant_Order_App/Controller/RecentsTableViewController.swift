//
//  RecentsTableViewController.swift
//  IOS_ProjectCourse_FinalProject
//
//  Created by mobileapps on 2019-04-02.
//  Copyright © 2019 www.anthonyfung.com. All rights reserved.
//

import UIKit



class RecentsTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    let saveObjectToFile = SaveObjectToFile()
    var finalArray = [String]()
    var arrayItem = [Item]()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("RecentsTableViewController Construtor called")
        title = "Recents Order"
        arrayItem = saveObjectToFile.readArrayFromFile()
        tableView.reloadData()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear called")
        tableView.reloadData()
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return stringArray.count
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recentsCell", for: indexPath )as! RecentsTableViewCell
                cell.displayLabel.text =  stringArray[indexPath.row]
        return cell
    }
 }
