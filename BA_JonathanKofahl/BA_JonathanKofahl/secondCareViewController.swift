//
//  secondCareViewController.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 26.08.17.
//
//

import UIKit

class secondCareViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var secondStackView: UIStackView!

    // Seperated Arrays for the two Tables
    var tableCriteria : [String]?
    var tableCriteria1 : [String]?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableCriteria = []
        tableCriteria1 = []
        
        //MARK: - TableView init -> load strings from Localization.strings file
        for index in 30...35 {
            let ressourceName = "care" + index.description
            tableCriteria?.append( NSLocalizedString(ressourceName, comment: "") )
        }
        for index in 36...41 {
            let ressourceName = "care" + index.description
            tableCriteria1?.append( NSLocalizedString(ressourceName, comment: "") )
        }
        //MARK: Load values if tree is not new
        if actualTree1?.isNew == false {
            for button in firstStackView.subviews as! [UIButton] {
                button.backgroundColor = UIColor.clear
                if actualTree1?.care39 == button.titleLabel?.text {
                    button.backgroundColor = UIColor.customColors.customGreen
                }
            }
            for button in secondStackView.subviews as! [UIButton] {
                button.backgroundColor = UIColor.clear
                if actualTree1?.care42 == button.titleLabel?.text {
                    button.backgroundColor = UIColor.customColors.customGreen
                }
            }
        
    }

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
            cell.index = indexPath.row + 30
        } else {
            cell.criteria.text = tableCriteria1?[indexPath.row]
            cell.tableViewIdentifier = "care"
            cell.index = indexPath.row + 36
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
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
