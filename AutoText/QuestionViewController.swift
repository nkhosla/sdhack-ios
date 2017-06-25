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
    
    let newQuestionDelay = 15;
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //TODO add a timer to birng a new question in newQuestioDelay seconds
        
        let nib = UINib(nibName: "QuestionTableViewCell", bundle: nil)
        
        tableView.register(nib, forCellReuseIdentifier: "questioncell")

    }
 
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = questionTableView.dequeueReusableCell(withIdentifier: "questioncell", for: indexPath) as! QuestionTableViewCell
        cell.questionLabel.text = questionList[indexPath.row]
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Prepare the popup assets
        let title = "THIS IS THE DIALOG TITLE"
        let message = "This is the message section of the popup dialog default view"
        //let image = UIImage(named: "pexels-photo-103290")
        
        // Create the dialog
        let popup = PopupDialog(title: title, message: message, image: image)
        
        // Create buttons
        let buttonOne = CancelButton(title: "CANCEL") {
            print("You canceled the car dialog.")
        }
        
        let buttonTwo = DefaultButton(title: "ADMIRE CAR") {
            print("What a beauty!")
        }
        
        let buttonThree = DefaultButton(title: "BUY CAR", height: 60) {
            print("Ah, maybe next time :)")
        }
        
        // Add buttons to dialog
        // Alternatively, you can use popup.addButton(buttonOne)
        // to add a single button
        popup.addButtons([buttonOne, buttonTwo, buttonThree])
        
        // Present dialog
        self.present(popup, animated: true, completion: nil)
    }
}


