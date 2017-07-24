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

    @IBOutlet weak var stackViewTopConstraint: NSLayoutConstraint!
    
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
    
    var topConstant : CGFloat!
    
    //MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        topConstant = stackViewTopConstraint.constant
        
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
    
    var constrainChanged = false
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField.nextField == field11 {
             self.stackViewTopConstraint.constant -= 50
            constrainChanged = true
        }
        textField.nextField?.becomeFirstResponder()
        return true
    }
    
    @IBAction func returnClicked(_ sender: UITextField) {
        //  print("Returnclicked")
        _ = textFieldShouldReturn(textField: sender)
        // save Data to database
        
        
        
    }
    
    // extra method for the last textfield. need to change the position of the textfield, otherwise it would be overlayed by the keyboard
    @IBAction func textEditingBegin(_ sender: UITextField) {
        if sender == field11 {
            UIView.animate(withDuration: 1) {
                if self.constrainChanged {
                   // do nothing, already changed 
                } else {
                    self.stackView.frame.origin.y -= 50
                }
            }
        } else {
            resetConstraint(field1)
        }
    }
    
    @IBAction func resetConstraint(_ sender: Any) {
        self.stackViewTopConstraint.constant = self.topConstant
    }
    
    
    @IBAction func dismissKeyboard(_ sender: UITextField) {
        sender.endEditing(true)
        if sender == field11 {
            UIView.animate(withDuration: 1) {
                if self.constrainChanged {
                    self.stackViewTopConstraint.constant += 50
                    self.constrainChanged = false
                } else {
                     self.stackView.frame.origin.y += 50
                }
            }
        }
 
    }
    
    
    @IBAction func cancelNewTree(_ sender: UIButton) {
        alertFunc(sender: sender, parentController: self)
    }
    // Source: http://nshipster.com/uialertcontroller/
    func alertFunc(sender: Any, parentController: UIViewController) -> Void {
        let alertController = UIAlertController(title: "Kontrolle Abbrechen", message: "Wollen Sie die Kontrolle wirklich abbrechen? Alle Eintragungen zu diesem Baum gehen verloren.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Weiter kontrollieren", style: .cancel) { action in
        }
        alertController.addAction(cancelAction)
        
        let exitAction = UIAlertAction(title: "Baum verwerfen", style: .destructive) { action in
            parentController.performSegue(withIdentifier: "showMenu", sender: self)
        }
        alertController.addAction(exitAction)
        
        self.present(alertController, animated: true) {
        }
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
