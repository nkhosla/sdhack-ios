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
    
    
    public func getAnswersForQuestion(q: String, completion: @escaping (_ recommendedAnswer:String) -> Void) {
        ServerTools.luisAnanlyzeString(str: mostRecentQuestion.last!){(INTENT: String, ENTITIE: String) -> Void in
            print(INTENT,ENTITIE)
            
            var recommendedAnswer = ""
            
            if INTENT == "When" {
                if self.questions_when.count == 0 && self.answers_when.count == 0 {
                    //                    self.answers_when.append(self.Answer_field.text!)
                    self.questions_when.append(ENTITIE)
                } else {
                    var currentHigh = Float(0.0)
                    var highIdx = 0
                    
                    let myGroup = DispatchGroup()
                    for (idx, q) in self.questions_when.enumerated() {
                        myGroup.enter()
                        ServerTools.stringSimilarity(stringOne: ENTITIE, stringTwo: q) {(intval:Float) -> Void in
                            if intval > currentHigh {
                                currentHigh = intval
                                highIdx = idx
                                print(highIdx)
                            }
                            myGroup.leave()
                            print("FEAR ME PLEASE")
                        }
                    }
                    
                    myGroup.notify(queue: .main) {
                        if currentHigh > 0.75 {
                            //                            self.questions_when.append(ENTITIE)
                            recommendedAnswer = self.answers_when[highIdx]
                            completion(recommendedAnswer)
                            //                            self.question_label.text = self.Answer_field.text
                            //                            self.answers_when.append(self.Answer_field.text!)
                        } else {
                            //                            self.answers_when.append(self.Answer_field.text!)
                            //                            if self.Answer_field.text!.isEmpty {
                            //                                print("type answer")
                            //                            } else {
                            //                                //                                self.questions_when.append(ENTITIE)
                            //                            }
                        }
                    }
                }
                //                completion(recommendedAnswer)
                
            } else if INTENT == "Where" {
                if self.questions_where.count == 0 && self.answers_where.count == 0 {
                    //                    self.answers_where.append(self.Answer_field.text!)
                    self.questions_where.append(ENTITIE)
                } else {
                    var currentHigh = Float(0.0)
                    var highIdx = 0
                    
                    let myGroup = DispatchGroup()
                    for (idx, q) in self.questions_where.enumerated() {
                        myGroup.enter()
                        ServerTools.stringSimilarity(stringOne: ENTITIE, stringTwo: q) {(intval:Float) -> Void in
                            if intval > currentHigh {
                                currentHigh = intval
                                highIdx = idx
                                print(highIdx)
                            }
                            myGroup.leave()
                            print("FEAR ME PLEASE")
                        }
                    }
                    
                    myGroup.notify(queue: .main) {
                        if currentHigh > 0.75 {
                            //                            self.questions_where.append(currentQuestion!)
                            recommendedAnswer = self.answers_where[highIdx]
                            //                            self.question_label.text = self.Answer_field.text!
                            completion(recommendedAnswer)
                            //                            self.answers_where.append(self.Answer_field.text!)
                        } else {
                            //                            self.answers_where.append(self.Answer_field.text!)
                            //                            if self.Answer_field.text!.isEmpty {
                            //                                print("type answer")
                            //                            } else {
                            //                                //                                self.questions_where.append(ENTITIE)
                            //                            }
                        }
                    }
                }
            } else {
                print("no intents were found")
            }
            //        completion(recommendedAnswer)
        }
        
    }
    
}
