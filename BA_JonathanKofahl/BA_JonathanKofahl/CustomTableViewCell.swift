//
//  QuestionCell.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 24.07.17.
//
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var criteria: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func clickedButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3){
            for item in (sender.superview?.subviews)! {
                item.backgroundColor = UIColor.clear
            }
            if(sender == sender.superview?.subviews[0]) {
                sender.backgroundColor = UIColor.init(hexString: "00B079")
            }
            if(sender == sender.superview?.subviews[1]) {
                sender.backgroundColor = UIColor.init(hexString: "F4605D")
            }
            if(sender == sender.superview?.subviews[2]) {
                sender.backgroundColor = UIColor.init(hexString: "FFB364")
            }
        }
    }

}
