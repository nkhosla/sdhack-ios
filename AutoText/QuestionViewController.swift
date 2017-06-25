//
//  QuestionViewController.swift
//  AutoText
//
//  Created by Nathan khosla on 24 Jun 17.
//  Copyright © 2017 Nathan khosla. All rights reserved.
//

import UIKit
import PopupDialog

class QuestionViewController: UITableViewController {
    
    @IBOutlet var questionTableView: UITableView!
    
    var questionList = ["When are we meeting tonight?",
                        "What is the address for dinner?",
                        "What time is dinner?",
                        "Where are we going?"];
    
    let contactNameList = ["Genevieve", "Lucy", "Chad"];
    
    let contactImageList = ["girl", "girl2", "boy"];
    
    let newQuestionDelay = 15;
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //TODO add a timer to birng a new question in newQuestioDelay seconds
        
        let nib = UINib(nibName: "QuestionTableViewCell", bundle: nil)
        
        tableView.register(nib, forCellReuseIdentifier: "questioncell")
        
        ServerTools.stringSimilarity(stringOne: "where am I", stringTwo: "who am I") {(intval:Float) -> Void in
            print(intval)
        }
        
        print("mid")
        ServerTools.luisAnanlyzeString(str: "What time is the flight for the wedding?") {(int:String, ents:[String]) -> Void in
            print("here")
            print(int, ents)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AnsweredQuestionStore.shared.mostRecentQuestion = ["",""]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactNameList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = questionTableView.dequeueReusableCell(withIdentifier: "questioncell", for: indexPath) as! QuestionTableViewCell
        cell.questionLabel.text = contactNameList[indexPath.row]
        cell.profileImageView.image = UIImage.init(imageLiteralResourceName: contactImageList[indexPath.row])
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChatViewController(nibName: "ChatViewController", bundle: nil)
        var dataSource: FakeDataSource!
        let pageSize = 50
        
        
        switch indexPath.row {
        case 0:
            dataSource = FakeDataSource(messages: FriendMessageFactory.createMessages(sender:"Genevieve"), pageSize: pageSize)
            
            ServerTools.luisAnanlyzeString(str: "When are we meeting to go to the party?"){ (intent, entities) in
                var econcat = ""
                for (index, e) in entities.enumerated() {
                    if index==0 {
                        econcat += e
                    } else {
                        econcat += " "
                        econcat += e
                    }
                }
                
                AnsweredQuestionStore.shared.mostRecentQuestion = [intent, econcat]
            }
        case 1:
            dataSource = FakeDataSource(messages: FriendMessageFactory.createMessages(sender:"Lucy"), pageSize: pageSize)
            
            ServerTools.luisAnanlyzeString(str: "What time does this party start?"){ (intent, entities) in
                var econcat = ""
                for (index, e) in entities.enumerated() {
                    if index==0 {
                        econcat += e
                    } else {
                        econcat += " "
                        econcat += e
                    }
                }
                
                AnsweredQuestionStore.shared.mostRecentQuestion = [intent, econcat]
            }
            
        case 2:
            dataSource = FakeDataSource(messages: FriendMessageFactory.createMessages(sender:"Chad"), pageSize: pageSize)
            
            ServerTools.luisAnanlyzeString(str: "What time are you arriving?"){ (intent, entities) in
                var econcat = ""
                for (index, e) in entities.enumerated() {
                    if index==0 {
                        econcat += e
                    } else {
                        econcat += " "
                        econcat += e
                    }
                }
                
                AnsweredQuestionStore.shared.mostRecentQuestion = [intent, econcat]
            }
            
        default:
            break
        }
        
        
        vc.dataSource = dataSource
        vc.messageSender = dataSource.messageSender
        
        navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
}


