//
//  StoreResult.swift
//  waiHungFung_FinalProject
//
//  Created by Anthony Fung on 2019-01-27.
//  Copyright © 2019 www.anthonyfung.com. All rights reserved.
//

import Foundation
class StoreResult:  Comparable, CustomStringConvertible {
    
    var rightOrWrong:String = ""
    var question:String = ""
    var userAnswer:Int = 0
    var result:Int = 0
    
    init(rightOrWrong:String, question:String, userAnswer:Int, result:Int) {
        self.rightOrWrong = rightOrWrong
        self.question = question
        self.userAnswer = userAnswer
        self.result = result
    }
    
    static func < (lhs: StoreResult, rhs: StoreResult) -> Bool {
            return lhs.userAnswer < lhs.userAnswer
    }
    static func > (lhs: StoreResult, rhs: StoreResult) -> Bool {
        return lhs.userAnswer > lhs.userAnswer
    }
    static func == (lhs: StoreResult, rhs: StoreResult) -> Bool {
        return lhs.question == rhs.question
    }
    
    var description: String {
        return "\(rightOrWrong) answer  \(question) = \(userAnswer) \n"
    }
    
}
