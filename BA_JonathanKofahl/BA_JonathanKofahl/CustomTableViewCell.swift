//
//  CustomTableViewCell.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 24.07.17.
//
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var criteria: UILabel!
    var tableViewIdentifier : String!
    var index : Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func clickedButton(_ sender: UIButton) {
        
        // Animate the Buttons
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
            if((sender.superview?.subviews.count)! > 2) {
            if(sender == sender.superview?.subviews[2]) {
                sender.backgroundColor = UIColor.init(hexString: "FFB364")
            }
            }
        }
        
        // Save the Content in relation to the MotherViewController
        
        actualTree1?.setValue(sender.titleLabel?.text, forKey: tableViewIdentifier + index.description)
        
    }

}
