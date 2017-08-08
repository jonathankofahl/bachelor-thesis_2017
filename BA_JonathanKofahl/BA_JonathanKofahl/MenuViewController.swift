//
//  MenuViewController.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 12.06.17.
//
// HALLO GIT BRANCH TEST

import UIKit

class MenuViewController: UIViewController {
    
    //MARK: - Variables & Outlets
    
    let defaults = UserDefaults.standard

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var databaseButton: UIButton!
    
    //MARK: - Methods
    
    override func viewWillAppear(_ animated: Bool) {
        if defaults.value(forKey: "appColor") != nil {
            view1.backgroundColor = UIColor.init(hexString: defaults.value(forKey: "appColor") as! String)
        } else {
            defaults.set("#4E7DB3", forKey: "appColor")
        }
        if defaults.value(forKey: "treeCount") == nil {
            defaults.set(0, forKey: "treeCount")
        }
        
        databaseButton.backgroundColor = view1.backgroundColor
        databaseButton.setTitleColor(UIColor.white, for: UIControlState.normal)
    }
    
    // Make the Button highlighted on Select
    @IBAction func selectButton(_ sender: UIButton) {
        if sender.tag == 0 {
            sender.setTitleColor(view1.backgroundColor, for: UIControlState.normal)
            sender.setTitleColor(view1.backgroundColor, for: UIControlState.highlighted)
            sender.backgroundColor = UIColor.white
            sender.tag = 1
        } else {
            sender.setTitleColor(UIColor.white, for: UIControlState.normal)
            sender.setTitleColor(UIColor.white, for: UIControlState.normal)
            sender.backgroundColor = UIColor.init(hexString:"27CEA6")
            if sender == databaseButton {
                sender.backgroundColor = view1.backgroundColor
            }
            sender.tag = 0
        }
        
    }
    @IBAction func newTreeAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Inspect", bundle: nil)
        let tabbar = storyboard.instantiateViewController(withIdentifier: "tabbar") as UIViewController
        present(tabbar, animated: true, completion: nil)
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
