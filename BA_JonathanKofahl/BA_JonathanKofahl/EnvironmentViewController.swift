//
//  EnvironmentViewController.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 12.06.17.
//
//

import UIKit

class EnvironmentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Variables & Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var tabbarItem: UITabBarItem!

    
    var defaults = UserDefaults.standard
    
    // Seperated Arrays for the two Tables
    var tableCriteria : [String]?
    
    //MARK: - Methods
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        let infoController = self.tabBarController?.viewControllers?[0] as! InformationViewController
        infoController.removeHighlightTabIcon(item: tabbarItem)
        
        actualTree1?.setValue(textView.text, forKey: "environment"+textView.tag.description)
        super.viewWillDisappear(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let infoController = self.tabBarController?.viewControllers?[0] as! InformationViewController
        infoController.highlightTabIcon(item: tabbarItem)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //MARK: Color load from UserDefaults
        if defaults.value(forKey: "appColor") != nil {
            let color = UIColor.color(withData: (defaults.value(forKey: "appColor") as! Data))
            topView.backgroundColor = color
        }
        
        tableCriteria = []
        
        //MARK: TableView init -> load strings from Localization.strings file
        for index in 1...6 {
            let ressourceName = "environment" + index.description
            tableCriteria?.append( NSLocalizedString(ressourceName, comment: "") )
        }
        
        //MARK: Load values if tree is not new
        if actualTree1?.isNew == false {
            if actualTree1?.tribe21 != "Nein" {
                firstButton.backgroundColor = UIColor.clear
                secondButton.backgroundColor = UIColor.customColors.customOrange
            } else {
                firstButton.backgroundColor = UIColor.customColors.customGreen
                secondButton.backgroundColor = UIColor.clear
            }
            if actualTree1?.environment7 != nil {
                textView.text = actualTree1?.environment7
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
        cell.tableViewIdentifier = "environment"
        cell.index = indexPath.row
        
        return cell
    }
    
    @IBAction func cancelNewTree(_ sender: Any) {
        let infoController = self.tabBarController?.viewControllers?[0] as! InformationViewController
        infoController.alertFunc(sender: sender, parentController: self)
    }
    
    
    @IBAction func clickedButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3){
            for item in (sender.superview?.subviews)! {
                item.backgroundColor = UIColor.clear
            }
            sender.backgroundColor = UIColor.customColors.customGreen
        }
        actualTree1?.setValue(sender.titleLabel?.text, forKey: "info"+sender.tag.description)
    }
    
    
}
