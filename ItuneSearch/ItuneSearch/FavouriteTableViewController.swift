//
//  FavouriteTableViewController.swift
//  ItuneSearch
//
//  Created by Anthony Fung on 2019-02-17.
//  Copyright © 2019 mac2_ios. All rights reserved.
//

import UIKit
import MessageUI


let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
let archiveURL = documentDirectory.appendingPathComponent("notes").appendingPathExtension("me")

class FavouriteTableViewController:UIViewController, UITableViewDataSource,UITableViewDelegate ,UIImagePickerControllerDelegate,
UINavigationControllerDelegate, MFMailComposeViewControllerDelegate {
    var detailViewController = DetailTableViewController()
    var kind = ""
    var storeItem:StoreItem?
    var storeItems:[StoreItem] = []
    var tempStoreItems:[StoreItem] = []
    var accendingOrDescending = "accending"
    var sortedArray = [StoreItem]()
    
    
    @IBOutlet weak var favouriteTableView: UITableView!
    
    @IBOutlet weak var emailButton: UIBarButtonItem!
    
    @IBOutlet weak var segementBar: UISegmentedControl!
    
    
    @IBAction func segmentBarClick(_ sender: UISegmentedControl) {
    }
    
    @IBAction func emaiButton(_ sender: UIBarButtonItem) {
        showMailComposer()
    }
    func showMailComposer(){
        guard MFMailComposeViewController.canSendMail() else {
            print("Can not send mail")
            return
        }
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients(["example@example.com"])
        mailComposer.setSubject("Important topic to discuss")
        mailComposer.setMessageBody("Hello there!", isHTML: false)
        present(mailComposer, animated: true, completion: nil)
        
        
    }
    
    // mailComposeController(didFinishWith:)
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        
        let storeItems = self.storeItems.description
        let activityController = UIActivityViewController(activityItems: [storeItems], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender as? UIView
        present (activityController, animated: true, completion: nil)
        
    }
    
    
    func checkSegmentBarStatus(kind: String){
        
        storeItems = readFromFile()
        let originalStoreItems = storeItems        
        tempStoreItems = storeItems.filter { return $0.kind == kind }
        storeItems = tempStoreItems
        saveToFile(storeItems)
        storeItems = readFromFile()
        self.favouriteTableView.reloadData()
        saveToFile(originalStoreItems)
        
    }
    func accsending(arrayOf: [StoreItem]){
        sortedArray = arrayOf.sorted(by: <)
        storeItems = sortedArray
        saveToFile(storeItems)
        storeItems = readFromFile()
        self.favouriteTableView.reloadData()
    }
    func desscending(arrayOf: [StoreItem]){
        sortedArray = arrayOf.sorted(by: >)
        storeItems = sortedArray
        saveToFile(storeItems)
        storeItems = readFromFile()
        self.favouriteTableView.reloadData()
    }
    func sortArray(_ storeItems: [StoreItem]) {
        if accendingOrDescending == "accsending"{
            accendingOrDescending = "desending"
            accsending(arrayOf: storeItems)
            saveToFile(storeItems)
        }
        else {
            accendingOrDescending = "accsending"
            desscending(arrayOf:storeItems)
            saveToFile(storeItems)
        }
        
    }
    @IBAction func segmentBarTapped(_ sender: UISegmentedControl) {
        switch  sender.selectedSegmentIndex {
        case 0:
            navigationItem.leftBarButtonItem?.isEnabled = true
            kind = "all"
            storeItems = readFromFile()
            sortArray(storeItems)
            self.favouriteTableView.reloadData()
        case 1:
            navigationItem.leftBarButtonItem?.isEnabled = false
            
            kind = "feature-movie"
            checkSegmentBarStatus(kind: kind)
            
        case 2:
            navigationItem.leftBarButtonItem?.isEnabled = false
            kind = "song"
            checkSegmentBarStatus(kind: kind)
        case 3:
            navigationItem.leftBarButtonItem?.isEnabled = false
            kind = "software"
            checkSegmentBarStatus(kind: kind)
            
        case 4:
            navigationItem.leftBarButtonItem?.isEnabled = false
            kind = "ebook"
            checkSegmentBarStatus(kind: kind)
            
        default:
            break
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.favouriteTableView.rowHeight = 100
        //kind = "all"
        
        // --> this function lets edit button to action move row method.
        // -->  used this with @objc editButton func below
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(editButtonTapped))
        
        
        storeItems = readFromFile()
        
        favouriteTableView.reloadData()
    }
    @objc func editButtonTapped(_ sender: UIBarButtonItem){
        favouriteTableView.setEditing(!favouriteTableView.isEditing, animated: true)
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.storeItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteTableViewCell", for: indexPath) as! FavouriteTableViewCell
        
        let storeItem = storeItems[indexPath.row]
        
        cell.update(with: storeItem)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // delete row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //// let tempArray = storeItems
        if editingStyle == .delete{
            storeItems.remove(at: indexPath.row)
            saveToFile(storeItems)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }else if editingStyle == .insert{}
        tableView.endUpdates()
        
        saveToFile(storeItems)
        favouriteTableView.reloadData()
        // storeItems = tempArray
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
        let movedStoreItem = storeItems.remove(at: fromIndexPath.row)
        // 2- Insert cell to new place
        storeItems.insert(movedStoreItem, at: to.row)
        saveToFile(storeItems)
        
    }
    
    func saveToFile(_ storeItems:[StoreItem]){
        let propertyListEncoder = PropertyListEncoder()
        let encodedNoteArray = try? propertyListEncoder.encode(storeItems)
        try? encodedNoteArray?.write(to: archiveURL, options: .noFileProtection)
        
    }
    //  then read from file
    func readFromFile() -> [StoreItem]{
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedNotesData = try? Data(contentsOf: archiveURL), let decodedNotes = try? propertyListDecoder.decode(Array<StoreItem>.self, from: retrievedNotesData){
            return(decodedNotes)
        }else{
            return storeItems
        }
    }
}

