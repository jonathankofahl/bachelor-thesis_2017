//
//  secondCrownViewController.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 25.07.17.
//
//

import Foundation
import UIKit

class secondCrownViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    //MARK: - Variables & Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var secondStackView: UIStackView!
    @IBOutlet weak var thirdStackView: UIStackView!
    @IBOutlet weak var firstTextfield: UITextField!
    @IBOutlet weak var secondTextfield: UITextField!
    
    // Seperated Arrays for the two Tables
    var tableCriteria : [String]?
    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableCriteria = []
        
        //MARK: - TableView init -> load strings from Localization.strings file
        for index in 16...21 {
            let ressourceName = "crown" + index.description
            tableCriteria?.append( NSLocalizedString(ressourceName, comment: "") )
        }
        
        //MARK: Load values if tree is not new
        if actualTree1?.isNew == false {
            for button in firstStackView.subviews as! [UIButton] {
              button.backgroundColor = UIColor.clear
              checkValue(attributeString: (button.titleLabel?.text!)!, sender: button)
            }
            for button in secondStackView.subviews as! [UIButton] {
                button.backgroundColor = UIColor.clear
                checkValue(attributeString: (button.titleLabel?.text)!, sender: button)
            }
            for button in thirdStackView.subviews as! [UIButton] {
                button.backgroundColor = UIColor.clear
                checkValue(attributeString: (button.titleLabel?.text)!, sender: button)
            }
            if actualTree1?.crown17 != nil {
                firstTextfield.text = actualTree1?.crown17
            }
            if actualTree1?.crown19 != nil {
                secondTextfield.text = actualTree1?.crown19
            }
            
        }
    }
    
    // Maybe write a global func to do this. see same code in CustomTableViewCell
    func checkValue(attributeString: String, sender: UIButton) -> Void
    {
        if attributeString == ("Gefährlich") {
            sender.backgroundColor = UIColor.init(hexString: "F4605D")
        }
        if attributeString == "Unklar" {
            sender.backgroundColor = UIColor.init(hexString: "F4605D")
        }
        if attributeString == "vorhanden" {
            sender.backgroundColor = UIColor.init(hexString: "FFB364")
        }
        if attributeString == "Ja" {
            sender.backgroundColor = UIColor.init(hexString: "FFB364")
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableView Configuration
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
            return tableCriteria!.count
            
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        cell.criteria.text = tableCriteria?[indexPath.row]
        cell.tableViewIdentifier = "crown"
        cell.index = indexPath.row + 20
        return cell
}
    @IBAction func returnClicked(_ sender: UITextField) {
          //  print("Returnclicked")
                 _ = textFieldShouldReturn(sender)
          }
   
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            actualTree1?.setValue(textField.text, forKey: "crown"+textField.tag.description)
                 textField.resignFirstResponder()
        
              return true
           }
   
       @IBAction func clickedButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3){
           for item in (sender.superview?.subviews)! {
           item.backgroundColor = UIColor.clear
        }
          sender.backgroundColor = UIColor.init(hexString: "00B079")
           }
          actualTree1?.setValue(sender.titleLabel?.text, forKey: "crown"+sender.tag.description)
           }
}
