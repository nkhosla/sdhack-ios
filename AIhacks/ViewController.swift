//
//  ViewController.swift
//  AIhacks
//
//  Created by Yago Arconada on 6/24/17.
//  Copyright © 2017 bima.engine. All rights reserved.
//

import UIKit
import Darwin

class ViewController: UIViewController {
    
    @IBOutlet weak var question_label: UILabel!
    @IBOutlet weak var Question_field: UITextField!
    @IBOutlet weak var Answer_field: UITextField!
    
    var questions_when = [String]()
    var questions_where = [String]()
    var answers_when = [String]()
    var answers_where = [String]()
    
    
    @IBAction func Suggest(_ sender: Any) {
        let currentQuestion = Question_field.text
        
        luistime.sendRequest2Request(str: currentQuestion!){(INTENT:String,ENTITIE:String) -> Void in
            print(INTENT,ENTITIE)

            if INTENT == "When" {
                if self.questions_when.count == 0 && self.answers_when.count == 0 {
                    if self.Answer_field.text!.isEmpty {
                        print("Answer is empty")
                    } else {
                        self.answers_when.append(self.Answer_field.text!)
                        self.questions_when.append(ENTITIE)
                    }
                } else {
                    var currentHigh = Float(0.0)
                    var highIdx = 0
                    
                    let myGroup = DispatchGroup()
                    for (idx, q) in self.questions_when.enumerated() {
                        myGroup.enter()
                        serverside.stringSimilarity(stringOne: ENTITIE, stringTwo: q) {(intval:Float) -> Void in
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
                        if currentHigh > 0.65 {
//                            self.questions_when.append(ENTITIE)
                            self.Answer_field.text = self.answers_when[highIdx]
//                            self.question_label.text = self.Answer_field.text
//                            self.answers_when.append(self.Answer_field.text!)
                        } else {
//                            self.answers_when.append(self.Answer_field.text!)
                            if self.Answer_field.text!.isEmpty {
//                                self.Answer_field.text = "No suggestions"
                                print("type answer")
                            } else {
//                                self.questions_when.append(ENTITIE)
                            }
                        }
                    }
                }
                
            } else if INTENT == "Where" {
                if self.questions_where.count == 0 && self.answers_where.count == 0 {
                    if self.Answer_field.text!.isEmpty {
                        print("Answer is empty")
                    } else {
                        self.answers_where.append(self.Answer_field.text!)
                        self.questions_where.append(ENTITIE)
                    }
                    
                } else {
                    var currentHigh = Float(0.0)
                    var highIdx = 0
                    
                    let myGroup = DispatchGroup()
                    for (idx, q) in self.questions_where.enumerated() {
                        myGroup.enter()
                        serverside.stringSimilarity(stringOne: ENTITIE, stringTwo: q) {(intval:Float) -> Void in
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
                        if currentHigh > 0.65 {
//                            self.questions_where.append(currentQuestion!)
                            self.Answer_field.text = self.answers_where[highIdx]
//                            self.question_label.text = self.Answer_field.text!
//                            self.answers_where.append(self.Answer_field.text!)
                        } else {
//                            self.answers_where.append(self.Answer_field.text!)
                            if self.Answer_field.text!.isEmpty {
                                print("type answer")
//                                self.Answer_field.text = "No suggestions"
                            } else {
//                                self.questions_where.append(ENTITIE)
                            }
                        }
                    }
                }
            } else {
                print("no intents were found")
            }
            
        }

        
    }
    @IBAction func send(_ sender: Any) {
        let currentQuestion = Question_field.text
        
        luistime.sendRequest2Request(str: currentQuestion!){(INTENT:String,ENTITIE:String) -> Void in
            print(INTENT,ENTITIE)
            if INTENT == "When" {
                if self.questions_when.count != self.answers_when.count {
                    let diffwhen = self.questions_when.count - self.answers_when.count
                    for _ in 1...diffwhen {
                        self.answers_when.append(self.Answer_field.text!)
                    }
//                    self.answers_when.append(self.Answer_field.text!)
                } else {
                    self.answers_when.append(self.Answer_field.text!)
                    self.questions_when.append(ENTITIE)
                }
                
            } else if INTENT == "Where" {
                if self.questions_where.count != self.answers_where.count {
                    let diffwhere = self.questions_when.count - self.answers_when.count
                    for _ in 1...diffwhere {
                        self.answers_where.append(self.Answer_field.text!)
                    }                } else {
                    self.answers_where.append(self.Answer_field.text!)
                    self.questions_where.append(ENTITIE)
                }
                
            }
            self.Question_field.text = ""
            self.Answer_field.text = ""
            
            let names = arc4random_uniform(7)
            if names <= 1 {
                self.question_label.text = "Diana"
            } else if names <= 2 {
                self.question_label.text = "Jon"
            } else if names <= 3 {
                self.question_label.text = "Peter"
            } else if names <= 4 {
                self.question_label.text = "Alice"
            } else if names <= 5 {
                self.question_label.text = "Fred"
            } else if names <= 6 {
                self.question_label.text = "Cortana"
            } else {
                self.question_label.text = "Emily"
            }
            
        }
        
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//
    }

    //    override func didReceiveMemoryWarning() {
    //        super.didReceiveMemoryWarning()
    //        // Dispose of any resources that can be recreated.
    //    }
    
    
}

