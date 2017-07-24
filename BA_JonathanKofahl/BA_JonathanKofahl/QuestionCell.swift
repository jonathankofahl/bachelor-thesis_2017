//
//  QuestionCell.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 24.07.17.
//
//

import UIKit

class QuestionCell: UITableViewCell {

    @IBOutlet weak var question: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
