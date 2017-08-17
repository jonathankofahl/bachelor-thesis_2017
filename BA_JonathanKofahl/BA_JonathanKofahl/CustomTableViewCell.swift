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
                self.buttonStackView.subviews[1].backgroundColor = UIColor.customColors.customRed
            }
            if attributeString == "Unklar" {
                for item in (buttonStackView.subviews) {
                    item.backgroundColor = UIColor.clear
                }
                buttonStackView.subviews[2].backgroundColor = UIColor.customColors.customRed
            }
            if attributeString == "vorhanden" {
                for item in (buttonStackView.subviews) {
                    item.backgroundColor = UIColor.clear
                }
                buttonStackView.subviews[1].backgroundColor = UIColor.customColors.customOrange
            }
            if attributeString == "Ja" {
                for item in (buttonStackView.subviews) {
                    item.backgroundColor = UIColor.clear
                }
                buttonStackView.subviews[1].backgroundColor = UIColor.customColors.customOrange
            }
            
        } else {
            var buttons = buttonStackView.subviews as! [UIButton]
            //MARK: Save the default values for the tree if the user dont choose.
            if tableViewIdentifier == "crown" {
                actualTree1?.setValue("Unbedenklich", forKey: tableViewIdentifier + index.description)
            }
            if tableViewIdentifier == "tribe" && buttons[0].titleLabel?.text == "Unbedenklich" {
                actualTree1?.setValue("Unbedenklich", forKey: tableViewIdentifier + index.description)
            }
            if tableViewIdentifier == "tribe" && buttons[0].titleLabel?.text == "Nicht vorhanden" {
                actualTree1?.setValue("Nicht vorhanden", forKey: tableViewIdentifier + index.description)
            }
            if tableViewIdentifier == "root" && buttons[0].titleLabel?.text == "Unbedenklich" {
                actualTree1?.setValue("Unbedenklich", forKey: tableViewIdentifier + index.description)
            }
            if tableViewIdentifier == "root" && buttons[0].titleLabel?.text == "Nicht vorhanden" {
                actualTree1?.setValue("Nicht vorhanden", forKey: tableViewIdentifier + index.description)
            }
            if tableViewIdentifier == "environment" {
                actualTree1?.setValue("Nicht vorhanden", forKey: tableViewIdentifier + index.description)
            }
            if tableViewIdentifier == "care" {
                actualTree1?.setValue("Nein", forKey: tableViewIdentifier + index.description)
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
                sender.backgroundColor = UIColor.customColors.customGreen
            }
            if(sender == sender.superview?.subviews[1]) {
                sender.backgroundColor = UIColor.customColors.customRed
            }
            if((sender.superview?.subviews.count)! > 2) {
            if(sender == sender.superview?.subviews[2]) {
                sender.backgroundColor = UIColor.customColors.customOrange
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
