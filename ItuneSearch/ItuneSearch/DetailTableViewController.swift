//
//  DetailTableViewController.swift
//  ItuneSearch
//
//  Created by Anthony Fung on 2019-02-16.
//  Copyright © 2019 mac2_ios. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    
    var storeItem: StoreItem?
    var storeItems = [StoreItem]()
    var isSaveButtonTapped = false
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var decriptionLable: UILabel!
    
    var  urlKey:String?
    //var artworkUrl:URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        storeItems = readFromFile()
       urlKey = storeItem?.artworkURL.description
       
        setUI( urlKey:urlKey ?? "" )
        shareButton.isEnabled = false
        
    }
    
    func setUI(urlKey:String ){
        if let url = URL (string: urlKey){
            do{
                let data = try Data(contentsOf: url)
                self.photoImage.image = UIImage (data: data)
            }
            catch let err{
                print("Error : \(err.localizedDescription)")
            }
        }
        productNameLabel.text = storeItem?.name
        nameLabel.text = storeItem?.artist
        decriptionLable.text =
            storeItem?.description
        
    }
    @IBAction func shareButtonTapped(_ sender: UIBarButtonItem) {
        guard let image = photoImage.image else {return}
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender as? UIView
        present (activityController, animated: true, completion: nil)
        
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        if storeItem?.name != "" {
            storeItems.append(storeItem!)
           
            saveToFile()
            isSaveButtonTapped = true
            shareButton.isEnabled = true
           
        }
       // showAlert(title: "Add to Favourite", message: "Successfully save!")
    }
    func showAlert (title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        showAlertAction(alertController)
    }
    func showAlertAction (_ alertController: UIAlertController){
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController,animated:true, completion: nil)
    }
    func saveToFile(){
        let propertyListEncoder = PropertyListEncoder()
        let encodedNoteArray = try? propertyListEncoder.encode(storeItems)
        try? encodedNoteArray?.write(to: archiveURL, options: .noFileProtection)
        
    }
    func readFromFile() -> [StoreItem]{
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedNotesData = try? Data(contentsOf: archiveURL), let decodedNotes = try? propertyListDecoder.decode(Array<StoreItem>.self, from: retrievedNotesData){
            return(decodedNotes)
        }else{
            return storeItems
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        saveToFile()
    }

}


