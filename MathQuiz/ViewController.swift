//
//  ViewController.swift
//  waiHungFung_FinalProject
//
//  Created by Anthony Fung on 2019-01-25.
//  Copyright © 2019 www.anthonyfung.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var num1 = ""
    var num2 = ""
    let numericOpterator = ""
    var result:Int?
    var answer:Int?
    var correctAnswer:Int = 0
    var wrongAnswer:Int = 0
    var correctAnswerArray:[StoreResult] = []
    var wrongAnswerArray:[StoreResult] = []
    var storeResultArray:[StoreResult] = []
    
   
    @IBOutlet weak var mathQuizLable: UILabel!
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var decimal: UIButton!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var generate: UIButton!
    @IBOutlet weak var vaildate: UIButton!
    @IBOutlet weak var clear: UIButton!
    @IBOutlet weak var score: UIButton!
    
    @IBAction func score(_ sender: UIButton) {
     // performSegue(withIdentifier: "resultPage", sender: nil) this is optional
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // function general random number each time the generate buttom press
    func randomNumber1() -> String {
        let randomNumber1 = String(Int.random(in: 1...25))
        return randomNumber1
    }
    func randomNumber2() -> String {
        let randomNumber2 = String(Int.random(in: 1...25))
        return randomNumber2
    }
    func randomOperator() -> String {
        var randomOperator = String(Int.random(in: 0...3))
        switch randomOperator {
        case "0":
            randomOperator = "+"
        case "1":
            randomOperator = "-"
        case "2":
            randomOperator = "*"
        case "3":
            randomOperator = "/"
        default:
            randomOperator = "0"
        }
        return randomOperator
    }
   
    @IBAction func generate(_ sender: UIButton) {
      
        let oper = randomOperator()
         num1 = randomNumber1()
         num2 = randomNumber2()
        if label.text != ""{
            label.text = ""
        }
        switch oper {
        case "+":
            result = Int(num1)! + Int(num2)!
        case "-":
            result =  Int(num1)! - Int(num2)!
        case "*":
            result =   Int(num1)! * Int(num2)!
        case "/":
          var temp1 = Int(num1)!
          var temp2 = Int(num2)!
          // passing denominator (change divisor always smaller than moleules)
          let temp = temp1
          temp1 = temp1 * temp2
          temp2 = temp
          
          result = temp1 / temp2
          num1 = String(temp1)
          num2 = String(temp2)

        default:
            result = 0
            
        }
         display.text = "\(num1) \(oper) \(num2)"
        }

    @IBAction func numbers(_ sender: UIButton) {
        if sender.tag == 13{
            label.text = ""
            return
        }
        if sender.tag == 15 {
            mathQuizLable.text = "Math Quiz"
            display.text = "Let's play"
            label.text = ""
            correctAnswerArray = []
            wrongAnswerArray = []
            storeResultArray = []
            
        }
        if (label.text!) == "" {
            // check the first enter digit if is '.', if is not add character
            if sender.tag == 12{
                label.text = label.text! + "-"
            }else if sender.tag >= 1 && sender.tag <= 10{
                label.text = label.text! + String(sender.tag-1)
            }
        }else{
            switch sender.tag{
            case 11:
                if  !((label.text?.contains("."))!){
                    label.text = label.text! + "."
                    }
            case 1,2,3,4,5,6,7,8,9,10:
                 label.text = label.text! + String(sender.tag-1)
            case 14:
                validateAnswer(sender.tag)
            default:
                display.text = ""
            }
        }
    }
    
    func validateAnswer(_ sender: Int){
        var question = ""
        if sender == 14 {
            //Optional blinding
            if let userAnswer = Int(label.text!){
            
                if  result == userAnswer {//(userAnswer as NSString).integerValue{
                    correctAnswer += 1
                    question = display.text!
                    display.text = "Correct"
                    print("Total of \(correctAnswer) correct answer !")
                    print(userAnswer)
                    print(result!)
                   
                }else{
                    wrongAnswer += 1
                    question = display.text!
                    display.text = "Wrong"
                    print("Total of \(wrongAnswer) wrong answer !")
                }
              
                // CREATE OBJECT OF QUESTION
                let output = StoreResult ( rightOrWrong: display.text!, question: question, userAnswer: Int(userAnswer), result: result! )
            
                storeResultArray.append(output)
                let str = output.description
                print (str)
               
            }
        }
        label.text = ""
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultPage" {
            if let targetVC = segue.destination as? ResultPageController{
                targetVC.storeResultArray = storeResultArray
                targetVC.correctAnswer = correctAnswer
               // targetVC.wrongAnswer = wrongAnswer
            }
        }
    }
    @IBAction func unwindToVC(_ unwindSegue: UIStoryboardSegue, towards subsequentVc: UIViewController){
        if unwindSegue.identifier == "resultPage" {
       
            let vc = unwindSegue.source as! ResultPageController
            self.mathQuizLable.text = vc.textFieldName.text
       
        }
    }
}
            
