//
//  InformationViewController.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 12.06.17.
//
//

import UIKit

class InformationViewController: UIViewController {
    
    //MARK: - Variables & Outlets

    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    let defaults = UserDefaults.standard
    
    //MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //MARK: - Color load from UserDefaults to complex!
        view1.backgroundColor = UIColor.init(hexString: defaults.value(forKey: "appColor") as! String)
        view2.backgroundColor = UIColor.init(hexString: defaults.value(forKey: "appColor") as! String)
        cameraButton.backgroundColor = UIColor.init(hexString: defaults.value(forKey: "appColor") as! String)
        treeImageView.borderColor = UIColor.init(hexString: defaults.value(forKey: "appColor") as! String)
        for view in stackView.arrangedSubviews {
            view.borderColor = UIColor.init(hexString: defaults.value(forKey: "appColor") as! String)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func takePhoto(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cameraSeg" {
            let destinationController = segue.destination as! CameraViewController
            destinationController.motherController = self
        }
    }
    
}
