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
    
    var option = 0
    
    @IBAction func swapButton2Pressed(_ sender: Any) {
        if option == 0 {
            option = 1
            self.containerView.currentSegueIdentifier = "embedSecond"
            self.containerView.swapViewControllers()
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self.option = 2
            })
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
        }
    }
    
    @IBAction func cancelNewTree(_ sender: Any) {
        let infoController = self.tabBarController?.viewControllers?[0] as! InformationViewController
        infoController.alertFunc(sender: sender, parentController: self)
    }
    
}
