//
//  firstCareViewController.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 26.08.17.
//
//

import UIKit

class firstCareViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var secondStackView: UIStackView!
    @IBOutlet weak var thirdStackView: UIStackView!

    // Seperated Arrays for the two Tables
    var tableCriteria : [String]?
    var tableCriteria1 : [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableCriteria = []
        tableCriteria1 = []
        
        //MARK: - TableView init -> load strings from Localization.strings file
        for index in 1...13 {
            let ressourceName = "care" + index.description
            tableCriteria?.append( NSLocalizedString(ressourceName, comment: "") )
        }
        for index in 14...23 {
            let ressourceName = "care" + index.description
            tableCriteria1?.append( NSLocalizedString(ressourceName, comment: "") )
        }
        
        
        //MARK: Load values if tree is not new
        if actualTree1?.isNew == false {
            for button in firstStackView.subviews as! [UIButton] {
                button.backgroundColor = UIColor.clear
                if actualTree1?.care0 == button.titleLabel?.text {
                    button.backgroundColor = UIColor.customColors.customGreen
                }
            }
            for button in secondStackView.subviews as! [UIButton] {
                button.backgroundColor = UIColor.clear
                if actualTree1?.care14 == button.titleLabel?.text {
                    button.backgroundColor = UIColor.customColors.customGreen
                }            }
            for button in thirdStackView.subviews as! [UIButton] {
                button.backgroundColor = UIColor.clear
                if actualTree1?.care28 == button.titleLabel?.text {
                    button.backgroundColor = UIColor.customColors.customGreen
                }
            }
            
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
            cell.tableViewIdentifier = "care"
            cell.index = indexPath.row + 1
        } else {
            cell.criteria.text = tableCriteria1?[indexPath.row]
            cell.tableViewIdentifier = "care"
            cell.index = indexPath.row + 15
        }
        
        return cell
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3){
            for item in (sender.superview?.subviews)! {
                item.backgroundColor = UIColor.clear
            }
            sender.backgroundColor = UIColor.customColors.customGreen
        }
        actualTree1?.setValue(sender.titleLabel?.text, forKey: "care"+sender.tag.description)
    }


}
