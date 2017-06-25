//
//  QuestionTableViewCell.swift
//  AutoText
//
//  Created by Nathan khosla on 24 Jun 17.
//  Copyright © 2017 Nathan khosla. All rights reserved.
//

// 375 by 667

import UIKit

class QuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.size.width/2
        self.profileImageView.layer.masksToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
