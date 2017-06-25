//
//  AnswerdQuestionStore.swift
//  AutoText
//
//  Created by Nathan khosla on 25 Jun 17.
//  Copyright © 2017 Nathan khosla. All rights reserved.
//

import UIKit

class AnsweredQuestionStore: NSObject {
    
    var questions_when = [String]()
    var questions_where = [String]()
    var answers_when = [String]()
    var answers_where = [String]()
    
    var mostRecentQuestion:[String] = [String]()
    
    
    static let shared = AnsweredQuestionStore()
    private override init() {}
    
    
    public func storeWhenQAPair(a:String, q:String) {
        self.questions_when.append(q)
        self.answers_when.append(a)
    }
    
    public func storeWhereQAPair(a:String, q:String) {
        self.questions_where.append(q)
        self.answers_where.append(a)
    }
    
    public func createAnswerForMostRecentQuestion(a:String) {
        
        switch mostRecentQuestion[0].lowercased() {
        case "when":
            self.storeWhenQAPair(a: a , q: mostRecentQuestion[1].lowercased())
            
        case "where":
            self.storeWhereQAPair(a: a , q: mostRecentQuestion[1].lowercased())
            
        default:
            print("Tried to make QA pair from most recent Q and failed")
            
        }
    }
    
    
}
