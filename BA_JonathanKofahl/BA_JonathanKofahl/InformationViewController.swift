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
    
    @IBOutlet weak var field1: UITextField!
    @IBOutlet weak var field2: UITextField!
    @IBOutlet weak var field3: UITextField!
    @IBOutlet weak var field4: UITextField!
    @IBOutlet weak var field5: UITextField!
    @IBOutlet weak var field6: UITextField!
    @IBOutlet weak var field7: UITextField!
    @IBOutlet weak var field8: UITextField!
    @IBOutlet weak var field9: UITextField!
    @IBOutlet weak var field10: UITextField!
    @IBOutlet weak var field11: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    let defaults = UserDefaults.standard
    
    //MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // get the current date and time
        let currentDateTime = Date()
        
        // initialize the date formatter and set the style
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .long
        
        // get the date time String from the date object
        dateTextField.text =  formatter.string(from: currentDateTime)
        
        //MARK: - Color load from UserDefaults to complex!
        if defaults.value(forKey: "appColor") != nil {
            view1.backgroundColor = UIColor.init(hexString: defaults.value(forKey: "appColor") as! String)
            view2.backgroundColor = UIColor.init(hexString: defaults.value(forKey: "appColor") as! String)
            cameraButton.backgroundColor = UIColor.init(hexString: defaults.value(forKey: "appColor") as! String)
            treeImageView.borderColor = UIColor.init(hexString: defaults.value(forKey: "appColor") as! String)
            for view in stackView.arrangedSubviews {
                view.borderColor = UIColor.init(hexString: defaults.value(forKey: "appColor") as! String)
            }
        }
        
        //MARK: - Connect the textFields, so the user can tab to the next
        self.field1.nextField = self.field2
        self.field2.nextField = self.field3
        self.field3.nextField = self.field4
        self.field4.nextField = self.field5
        self.field5.nextField = self.field6
        self.field6.nextField = self.field7
        self.field7.nextField = self.field8
        self.field8.nextField = self.field9
        self.field9.nextField = self.field10
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
    
    // Help Methods to tab to the next TextView
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.nextField?.becomeFirstResponder()
        return true
    }
    
    @IBAction func returnClicked(_ sender: Any) {
        //  print("Returnclicked")
        _ = textFieldShouldReturn(textField: sender as! UITextField)
        
        // save Data to database
    }
    
    @IBAction func dismissKeyboard(_ sender: UITextField) {
        sender.endEditing(true)
    }

}

// MARK: - Source:

private var kAssociationKeyNextField: UInt8 = 0

extension UITextField {
    @IBOutlet var nextField: UITextField? {
        get {
            return objc_getAssociatedObject(self, &kAssociationKeyNextField) as? UITextField
        }
        set(newField) {
            objc_setAssociatedObject(self, &kAssociationKeyNextField, newField, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}
