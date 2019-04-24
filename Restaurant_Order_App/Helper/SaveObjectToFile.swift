//
//  SaveObjectToFile.swift
//  IOS_ProjectCourse_FinalProject
//
//  Created by Anthony Fung on 2019-04-01.
//  Copyright © 2019 www.anthonyfung.com. All rights reserved.
//

import Foundation

let fileName = "StoreData"
let documentDirURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
let fileURL = documentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")

class SaveObjectToFile{
    var tempString = ""
    
    func convertArrayToString(arr:[Item]) -> String{
        
       tempString = ""
        
        for ch in arr {
            tempString += "\(String(describing: ch.itemNumber)). \(String(describing: ch.itemName))   x \(ch.itemQuantity) \n"
            
        }
        
        return tempString
    }
    func getCurrentDateStringForRest() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: Date())
    }
    func saveToFile (str: String){
        
        print("File Path: \(fileURL.path)")
        
        let writeString = str
        do{
            // write to the file
            try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
            print("Success to write to file")
        }catch _ as NSError{
            print("Failed to write to file")
        }
       
      
    }
    func readFromFile() -> String{
        var readingString = ""
        
        do{
            readingString = try String(contentsOf: fileURL)
             print("Success read from file")
        }catch let error as NSError{
           
            print (error)
        }
         print(readingString)
        return readingString
    }
    func readArrayFromFile() -> [Item]{
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedNotesData = try? Data(contentsOf: archiveURL), let decodedNotes = try? propertyListDecoder.decode(Array<Item>.self, from: retrievedNotesData){
            return(decodedNotes)
        }else{
            return orderList
        }
        
    }
 
    
    
    
    
    
    
    
}
