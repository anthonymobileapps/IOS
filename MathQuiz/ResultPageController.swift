//
//  ResultPageController.swift
//  waiHungFung_FinalProject
//
//  Created by Anthony Fung on 2019-01-26.
//  Copyright © 2019 www.anthonyfung.com. All rights reserved.
//

import UIKit

class ResultPageController: UIViewController{
   // var storeResult: StoreResult?
    var correctAnswerArray:[StoreResult] = []
    var wrongAnswerArray:[StoreResult] = []
    var storeResultArray:[StoreResult] = []
    var correctAnswer = 0
    var wrongAnswer = 0
    var percentage = 0.0
    var textResultForAll:String = ""

    @IBOutlet weak var labelPageTittle: UILabel!
    @IBOutlet weak var labelPercentage: UILabel!
    @IBOutlet weak var textFieldName: UITextField!
    //@IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ascendingAnswer: UIButton!
    @IBOutlet weak var label: UILabel!
    
   
    
    @IBAction func accsending(_ sender: UIButton) {
        label.text = ""
        textResultForAll = ""
        let sortedByAnswer = storeResultArray.sorted { (answer1, answer2) -> Bool in
            return answer1.userAnswer < answer2.userAnswer}
        displayAll(storeResultArray: sortedByAnswer)
      // label.text = sortedByAnswer.description
    }
    @IBAction func desscending(_ sender: UIButton) {
        label.text = ""
        textResultForAll = ""
        let sortedByAnswer = storeResultArray.sorted { (answer1, answer2) -> Bool in
                return answer1.userAnswer > answer2.userAnswer}
        displayAll(storeResultArray: sortedByAnswer)
        // label.text = sortedByAnswer.description
        // use for to display all instead of .description
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calcuPercentage()
        displayAll(storeResultArray: storeResultArray)
    }

    func calcuPercentage(){
        if storeResultArray.count == 0{
            return labelPercentage.text = ""
        }else{
            let percentage = (Float(correctAnswer) / Float(storeResultArray.count  ))*100
            let formatted = String(format: " %.2f",percentage)
        labelPercentage.text = String(formatted) + "  %"
        }
    }
    
    func displayAll (storeResultArray: [StoreResult]) {
        label.text = ""
        textResultForAll = ""
        for i in 0..<storeResultArray.count{
            textResultForAll += storeResultArray[i].description  + "\n"
        }
        label.text = textResultForAll
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let targetVC = segue.destination as? ViewController
        if textFieldName.text != ""{
        targetVC?.mathQuizLable.text = textFieldName.text
        }else {
            targetVC?.mathQuizLable.text = "Math Quiz"
        }
    }
}

