//
//  secondTribeViewController.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 25.07.17.
//
//

import UIKit

class secondTribeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Variables & Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableView1: UITableView!
    
    // Seperated Arrays for the two Tables
    var tableCriteria : [String]?
    var tableCriteria1 : [String]?
    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableCriteria = []
        tableCriteria1 = []
        
        //MARK: - TableView init -> load strings from Localization.strings file
        for index in 12...20 {
            let ressourceName = "tribe" + index.description
            tableCriteria?.append( NSLocalizedString(ressourceName, comment: "") )
        }
        for index in 22...28 {
            let ressourceName = "tribe" + index.description
            tableCriteria1?.append( NSLocalizedString(ressourceName, comment: "") )
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
        
        if tableView == self.tableView {
            return tableCriteria!.count
        } else {
            return tableCriteria1!.count
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        if tableView == self.tableView {
            cell.criteria.text = tableCriteria?[indexPath.row]
            cell.tableViewIdentifier = "tribe"
            cell.index = indexPath.row + 12
            
        } else {
            cell.criteria.text = tableCriteria1?[indexPath.row]
            cell.tableViewIdentifier = "tribe"
            cell.index = indexPath.row + 22
        }
        
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
    
}
