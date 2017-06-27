//
//  CrownViewController.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 12.06.17.
//
//

import UIKit

class CrownViewController: UIViewController {
    
    //MARK: - Variables & Outlets
    
    var containerView: ContainerViewController!
    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.containerView.initialize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedContainer" {
            self.containerView = segue.destination as! ContainerViewController
        }
    }
    
    @IBAction func swapButton2Pressed(_ sender: Any) {
        self.containerView.currentSegueIdentifier = "embedSecond"
        self.containerView.swapViewControllers()
    }
    
    @IBAction func swapButtonPressed(_ sender: Any) {
        self.containerView.currentSegueIdentifier = "embedFirst"
        self.containerView.swapViewControllers()
    }

    
    
}
