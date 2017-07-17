//
//  MenuViewController.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 12.06.17.
//
//

import UIKit

class MenuViewController: UIViewController {
    
    //MARK: - Variables & Outlets
    
    let defaults = UserDefaults.standard

    @IBOutlet weak var view1: UIView!
    
    //MARK: - Methods
    
    override func viewWillAppear(_ animated: Bool) {
        if defaults.value(forKey: "appColor") != nil {
            view1.backgroundColor = UIColor.init(hexString: defaults.value(forKey: "appColor") as! String)

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
