//
//  SettingsViewController.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 12.06.17.
//
//

import UIKit

class SettingsViewController: UIViewController {
    
     //MARK: - Variables & Outlets
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var colorOption1: UIButton!
    @IBOutlet weak var colorOption2: UIButton!
    @IBOutlet weak var colorOption3: UIButton!
    @IBOutlet weak var colorOption4: UIButton!
    @IBOutlet weak var colorOption5: UIButton!
    
     //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if (defaults.value(forKey: "appColor") != nil) {
            view1.backgroundColor = UIColor.color(withData: (defaults.value(forKey: "appColor") as! Data))
            view2.backgroundColor = UIColor.color(withData: (defaults.value(forKey: "appColor") as! Data))
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeAppColor(_ sender: UIButton) {
       
        defaults.set(sender.backgroundColor?.encode(), forKey: "appColor")
        
        view1.backgroundColor = sender.backgroundColor
        view2.backgroundColor = sender.backgroundColor
        
    }
    
    @IBAction func deleteDatabase(_ sender: Any) {
        for tree in databaseModel.trees {
            databaseModel.deleteTree(objID: tree.objectID)
        }
        for (index,place) in databaseModel.places.enumerated() {
            databaseModel.deletePlace(index: index)
        }
    }
    
    }

extension UIColor {
    class func color(withData data:Data) -> UIColor {
        return NSKeyedUnarchiver.unarchiveObject(with: data) as! UIColor
    }
    
    func encode() -> Data {
        return NSKeyedArchiver.archivedData(withRootObject: self)
    }
    
    struct customColors {
        static let cancelColor     = UIColor.init(red: 255/255, green: 87/255, blue: 34/255, alpha: 1.0)
        static let customRed        = UIColor.init(red: 244/255, green: 67/255, blue: 54/255, alpha: 1.0)
        static let customOrange     = UIColor.init(red: 239/255, green: 108/255, blue: 0/255, alpha: 1.0)
        static let customGreen      = UIColor.init(red: 67/255, green: 160/255, blue: 71/255, alpha: 1.0)
        static let backgroundColor = UIColor.init(red: 66/255, green: 66/255, blue: 66/255, alpha: 1.0)

    }
    }


