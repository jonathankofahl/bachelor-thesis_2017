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
    @IBOutlet weak var buttonStackView: UIStackView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var test = actualTree1?.value(forKey: tableViewIdentifier + index.description)
        
        if actualTree1?.value(forKey: tableViewIdentifier + index.description) != nil {
            
            let attributeString = actualTree1?.value(forKey: tableViewIdentifier + index.description) as! String
            
            if attributeString == ("Gefährlich") {
                for item in (self.buttonStackView.subviews) {
                    item.backgroundColor = UIColor.clear
                }
                self.buttonStackView.subviews[1].backgroundColor = UIColor.init(hexString: "F4605D")
            }
            if attributeString == "Unklar" {
                for item in (buttonStackView.subviews) {
                    item.backgroundColor = UIColor.clear
                }
                buttonStackView.subviews[2].backgroundColor = UIColor.init(hexString: "F4605D")
            }
            if attributeString == "vorhanden" {
                for item in (buttonStackView.subviews) {
                    item.backgroundColor = UIColor.clear
                }
                buttonStackView.subviews[1].backgroundColor = UIColor.init(hexString: "FFB364")
            }
            if attributeString == "Ja" {
                for item in (buttonStackView.subviews) {
                    item.backgroundColor = UIColor.clear
                }
                buttonStackView.subviews[1].backgroundColor = UIColor.init(hexString: "FFB364")
            }
            
        }
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
        
        //actualTree1?.setValue(true, forKey: criteria.text)
        if sender.titleLabel?.text == "vorhanden" || sender.titleLabel?.text == "Ja" {
            actualTree1?.setValue("vorhanden", forKey: tableViewIdentifier + index.description)
        } else if sender.titleLabel?.text == "Ja" {
            actualTree1?.setValue("Ja", forKey: tableViewIdentifier + index.description)
        }
        else if sender.titleLabel?.text == "Nicht vorhanden" || sender.titleLabel?.text == "Nein" {
            actualTree1?.setValue("Nicht Vorhanden", forKey: tableViewIdentifier + index.description)
        } else {
            actualTree1?.setValue(sender.titleLabel?.text, forKey: tableViewIdentifier + index.description)
        }
    }

}
