//
//  AnswerdQuestionStore.swift
//  AutoText
//
//  Created by Nathan khosla on 25 Jun 17.
//  Copyright © 2017 Nathan khosla. All rights reserved.
//

import UIKit

class AnswerdQuestionStore: NSObject {
    
    var questions_when = [String]()
    var questions_where = [String]()
    var answers_when = [String]()
    var answers_where = [String]()
    
    
    static let shared = AnswerdQuestionStore()
    private override init() {}
    

}
