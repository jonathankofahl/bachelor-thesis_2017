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
            view1.backgroundColor = UIColor.init(hexString: defaults.value(forKey: "appColor") as! String)
            view2.backgroundColor = UIColor.init(hexString: defaults.value(forKey: "appColor") as! String)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeAppColor(_ sender: UIButton) {

       //  sender.borderWidth = 1
       //  sender.borderColor = UIColor.black
        
        switch sender.tag {
        case 1:
            defaults.set("#4C4C4C", forKey: "appColor")
        case 2:
            defaults.set("#00B079", forKey: "appColor")
        case 3:
            defaults.set("#4E7DB3", forKey: "appColor")
        case 4:
            defaults.set("#EEB109", forKey: "appColor")
        case 5:
            defaults.set("#B85D55", forKey: "appColor")
        default:
            defaults.set("#4E7DB3", forKey: "appColor")
        }
        
        view1.backgroundColor = UIColor.init(hexString: defaults.value(forKey: "appColor") as! String)
        view2.backgroundColor = UIColor.init(hexString: defaults.value(forKey: "appColor") as! String)
        
    }
    
    }

// https://stackoverflow.com/questions/24263007/how-to-use-hex-colour-values-in-swift-ios
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
