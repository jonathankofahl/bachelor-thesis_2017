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
    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var secondStackView: UIStackView!
    @IBOutlet weak var thirdStackView: UIStackView!
    @IBOutlet weak var tabbarItem: UITabBarItem!

    var defaults = UserDefaults.standard
    
    
    // Seperated Arrays for the two Tables
    var tableCriteria : [String]?
    var tableCriteria1 : [String]?
    
    //MARK: - Methods
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        let infoController = self.tabBarController?.viewControllers?[0] as! InformationViewController
        infoController.removeHighlightTabIcon(item: tabbarItem)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let infoController = self.tabBarController?.viewControllers?[0] as! InformationViewController
        infoController.highlightTabIcon(item: tabbarItem)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //MARK: - Color load from UserDefaults
        if defaults.value(forKey: "appColor") != nil {
            let color = UIColor.color(withData: (defaults.value(forKey: "appColor") as! Data))
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
        
        //let infoController = self.tabBarController?.viewControllers?[0] as! InformationViewController
        
        // Check if the Tree has a Place -> if not -> Alert
        if actualTree1?.info4 == nil {
            // AlertController with hint
            alertFunc(parentController: self)
        } else {
            
            let infoController = self.tabBarController?.viewControllers?[0] as! InformationViewController
            
            var placeUsedBefore = false
            var placeIndex = 0
            
            for (index,place) in databaseModel.places.enumerated() {
                if place.name?.capitalized ==  actualTree1?.info4?.components(separatedBy: " ")[0].capitalized {
                    placeUsedBefore = true
                    placeIndex = index
                }
            }
            if !placeUsedBefore {
                databaseModel.createPlace(name: (actualTree1?.info4?.components(separatedBy: " ")[0].capitalized)!)
                placeIndex = databaseModel.places.count-1
                databaseModel.save()
            }
            
            actualTree1?.place = databaseModel.places[placeIndex]
            
            actualTree1?.isNew = false
            
            if infoController.locationManager.location?.coordinate.latitude != nil {
                actualTree1?.xLocation = (infoController.locationManager.location?.coordinate.latitude)!
                actualTree1?.yLocation = (infoController.locationManager.location?.coordinate.longitude)!
            }
            
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
            sender.backgroundColor = UIColor.customColors.customGreen
        }
        actualTree1?.setValue(sender.titleLabel?.text, forKey: "care"+sender.tag.description)
    }
    
    // Source: http://nshipster.com/uialertcontroller/
    func alertFunc(parentController: UIViewController) -> Void {
        let alertController = UIAlertController(title: "Hinweis", message: "Sie haben vergessen im Abschnitt Info (1) einen Ort einzutragen. Ohne einen Ort kann der Baum nicht gespeichert werden.", preferredStyle: .alert)
        self.present(alertController, animated: true) {
        }
        
        let cancelAction = UIAlertAction(title: "OK", style: .cancel) { action in
        }
        alertController.addAction(cancelAction)
    }
    
    
    
}
