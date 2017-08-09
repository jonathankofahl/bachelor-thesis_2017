//
//  CareViewController.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 12.06.17.
//
//

import UIKit

class CareViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Variables & Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var topView: UIView!
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
        for index in 1...13 {
            let ressourceName = "care" + index.description
            tableCriteria?.append( NSLocalizedString(ressourceName, comment: "") )
        }
        for index in 14...23 {
            let ressourceName = "care" + index.description
            tableCriteria1?.append( NSLocalizedString(ressourceName, comment: "") )
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
            cell.tableViewIdentifier = "care"
            cell.index = indexPath.row + 1
        } else {
            cell.criteria.text = tableCriteria1?[indexPath.row]
            cell.tableViewIdentifier = "care"
            cell.index = indexPath.row + 15
        }
        
        return cell
    }

    //MARK - Save the Tree to the Database and close the Inspections Controllers (Tabbar)
    
    @IBAction func saveTree(_ sender: Any) {
        
        let infoController = self.tabBarController?.viewControllers?[0] as! InformationViewController
        
        // Check if the Tree has a Place -> if not -> Alert
        if infoController.actualTree.info4 == nil {
            // AlertController with hint
            print("Please insert Placename!")
        } else {
        
        let infoController = self.tabBarController?.viewControllers?[0] as! InformationViewController

        var placeUsedBefore = false
        var placeIndex = 0
        
        for (index,place) in databaseModel.places.enumerated() {
            if place.name?.capitalized ==  infoController.actualTree.info4?.components(separatedBy: " ")[0].capitalized {
                placeUsedBefore = true
                placeIndex = index
            }
        }
        if !placeUsedBefore {
            databaseModel.createPlace(name: (infoController.actualTree.info4?.components(separatedBy: " ")[0].capitalized)!)
            placeIndex = databaseModel.places.count-1
            databaseModel.save()
        }
        
        infoController.actualTree.place = databaseModel.places[placeIndex]
        databaseModel.save()
        
        databaseModel.logModel()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let home = storyboard.instantiateViewController(withIdentifier: "menuNavigationController") as UIViewController
            present(home, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3){
            for item in (sender.superview?.subviews)! {
                item.backgroundColor = UIColor.clear
            }
            sender.backgroundColor = UIColor.init(hexString: "00B079")
        }
        actualTree1?.setValue(sender.titleLabel?.text, forKey: "care"+sender.tag.description)
    }
    
    
    
    
}
