//
//  CareViewController.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 12.06.17.
//
//

import UIKit

class CareViewController: UIViewController {
    
    //MARK: - Variables & Outlets
    var containerView: ContainerViewController!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tabbarItem: UITabBarItem!
    @IBOutlet weak var stackView: UIStackView!

    var defaults = UserDefaults.standard
    
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
        
        self.containerView.initialize()

        //MARK: - Color load from UserDefaults
        if defaults.value(forKey: "appColor") != nil {
            let color = UIColor.color(withData: (defaults.value(forKey: "appColor") as! Data))
            topView.backgroundColor = color
        }
        
        
        
        //MARK: - Color load from UserDefaults
        if defaults.value(forKey: "appColor") != nil {
            let color = UIColor.color(withData: (defaults.value(forKey: "appColor") as! Data))
            topView.backgroundColor = color
            stackView.subviews[0].backgroundColor = UIColor.customColors.backgroundColor
            stackView.subviews[1].backgroundColor = color
        }

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedContainer" {
            self.containerView = segue.destination as! ContainerViewController
        }
    }
    
    var option = 0
    
    @IBAction func swapButton2Pressed(_ sender: Any) {
        if option == 0 {
            option = 1
            self.containerView.currentSegueIdentifier = "embedSecond"
            self.containerView.swapViewControllers()
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self.option = 2
            })
            stackView.subviews[0].backgroundColor = self.stackView.subviews[1].backgroundColor
            self.stackView.subviews[1].backgroundColor = UIColor.customColors.backgroundColor
            
        }
    }
    
    @IBAction func swapButtonPressed(_ sender: Any) {
        if option == 2 {
            option = 3
            self.containerView.currentSegueIdentifier = "embedFirst"
            self.containerView.swapViewControllers()
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self.option = 0
            })
            stackView.subviews[1].backgroundColor = self.stackView.subviews[0].backgroundColor
            self.stackView.subviews[0].backgroundColor = UIColor.customColors.backgroundColor
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
                if place.name?.capitalized == actualTree1?.info4/*?.components(separatedBy: " ")[0].capitalized*/ {
                    placeUsedBefore = true
                    placeIndex = index
                }
            }
            if !placeUsedBefore {
                databaseModel.createPlace(name: (actualTree1?.info4)!)/*?.components(separatedBy: " ")[0].capitalized)!)*/
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
