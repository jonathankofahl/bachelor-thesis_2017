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
                 _ = textFieldShouldReturn(textField: sender)
          }
   
       func textFieldShouldReturn(textField: UITextField) -> Bool {
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
