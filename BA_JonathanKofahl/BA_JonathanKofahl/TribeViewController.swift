//
//  TribeViewController.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 12.06.17.
//
//

import UIKit

class TribeViewController: UIViewController {
    
    //MARK: - Variables & Outlets
    var containerView: ContainerViewController!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    var defaults = UserDefaults.standard
    
    @IBOutlet weak var tabbarItem: UITabBarItem!

    
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
            stackView.subviews[0].backgroundColor = UIColor.customColors.backgroundColor
            stackView.subviews[1].backgroundColor = color
        }
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
    
    @IBAction func cancelNewTree(_ sender: Any) {
        let infoController = self.tabBarController?.viewControllers?[0] as! InformationViewController
        infoController.alertFunc(sender: sender, parentController: self)
    }
    
}
