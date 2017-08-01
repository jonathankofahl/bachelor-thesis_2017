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
    
    // Seperated Arrays for the two Tables
    var tableCriteria : [String]?
    var tableCriteria1 : [String]?
    
    //MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
        } else {
            cell.criteria.text = tableCriteria1?[indexPath.row]
        }
        
        return cell
    }

    //MARK - Save the Tree to the Database and close the Inspections Controllers (Tabbar)
    
    @IBAction func saveTree(_ sender: Any) {
        
        
        databaseModel.clear()
        
        //https://stackoverflow.com/questions/16685812/how-to-store-an-image-in-core-data
        let testImage = UIImage(named: "river_photo")
        var imageData = UIImagePNGRepresentation(testImage!)
        
        if databaseModel.places {
            <#code#>
        }
        
        databaseModel.createTree(number: 0, info0: "Mario", info1: "Birke", info2: "Raduhn", info3: "test", info4: "bob", image: imageData as! NSData)
 
        
        
        databaseModel.save()
        
        databaseModel.logModel()
        
        
        
        
        self.performSegue(withIdentifier: "exit", sender: self)
        
    }
    
    
    
}
