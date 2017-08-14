//
//  RootViewController.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 12.06.17.
//
//

import UIKit

class RootViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Variables & Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var textField: UITextField!
    var defaults = UserDefaults.standard
    
    // Seperated Arrays for the two Tables
    var tableCriteria : [String]?
    var tableCriteria1 : [String]?
    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //MARK: - Color load from UserDefaults
        if defaults.value(forKey: "appColor") != nil {
            let color = UIColor.init(hexString: defaults.value(forKey: "appColor") as! String)
            topView.backgroundColor = color
        }
        
        tableCriteria = []
        tableCriteria1 = []
        
        //MARK: - TableView init -> load strings from Localization.strings file
        for index in 1...5 {
            let ressourceName = "root" + index.description
            tableCriteria?.append( NSLocalizedString(ressourceName, comment: "") )
        }
        for index in 6...10 {
            let ressourceName = "root" + index.description
            tableCriteria1?.append( NSLocalizedString(ressourceName, comment: "") )
        }
        
        //MARK: Load values if tree is not new
        if actualTree1?.isNew == false {
            if actualTree1?.root6 != nil {
                textField.text = actualTree1?.root6
            }
            
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelNewTree(_ sender: Any) {
        let infoController = self.tabBarController?.viewControllers?[0] as! InformationViewController
        infoController.alertFunc(sender: sender, parentController: self)
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
            cell.tableViewIdentifier = "root"
            cell.index = indexPath.row
        } else {
            cell.criteria.text = tableCriteria1?[indexPath.row]
            cell.tableViewIdentifier = "root"
            cell.index = indexPath.row + 6
        }
        
        return cell
    }
    
    @IBAction func returnClicked(_ sender: UITextField) {
       //  print("Returnclicked")
       _ = textFieldShouldReturn(textField: sender)
       }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        actualTree1?.setValue(textField.text, forKey: "root"+textField.tag.description)
        textField.resignFirstResponder()
                
        return true
    }

    
}
