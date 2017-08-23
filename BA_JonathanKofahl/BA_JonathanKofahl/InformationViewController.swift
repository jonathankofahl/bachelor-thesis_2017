//
//  InformationViewController.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 12.06.17.
//
//

import UIKit
import CoreData
import CoreLocation

class InformationViewController: UIViewController, CLLocationManagerDelegate {
    
    //MARK: - Variables & Outlets
    
    @IBOutlet weak var stackViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var bottomStackView: UIStackView!
        
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
    private var managedObjectContext : NSManagedObjectContext!
    let defaults = UserDefaults.standard
    var actualPlace : String!
    var topConstant : CGFloat!
    
    @IBOutlet weak var tabbarItem: UITabBarItem!
    
    /** The Location Manager
     */
    var locationManager: CLLocationManager = CLLocationManager()
    /** The Location Managers start Location
     */
    var startLocation: CLLocation!
    
    //MARK: - Methods
    
    func highlightTabIcon(item: UITabBarItem) -> Void {
        item.imageInsets.bottom = -2
        item.imageInsets.top = -2
        item.imageInsets.left = -2
        item.imageInsets.right = -2

        item.image = UIImage(named: "tabIcon1")
        item.selectedImage = UIImage(named: "tabIcon1")
    }
    
    func removeHighlightTabIcon(item: UITabBarItem) -> Void {
    
        item.imageInsets.top = 13
        item.imageInsets.bottom = 13
        item.imageInsets.left = 13
        item.imageInsets.right = 13
        
        item.image = UIImage(named: "tabIcon")
        item.selectedImage = UIImage(named: "tabIcon")


    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.removeHighlightTabIcon(item: tabbarItem)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.highlightTabIcon(item: tabbarItem)
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        topConstant = stackViewTopConstraint.constant
        
        var tabBar = self.tabBarController as! TabbarController
        if tabBar.actualTree == nil {
            tabBar.actualTree = databaseModel.createTree()
            actualTree1 = tabBar.actualTree
            actualTree1?.isNew = true
            actualTree1?.info0 = ""
            actualTree1?.info1 = ""
            actualTree1?.info2 = ""
            actualTree1?.info3 = ""
            actualTree1?.info4 = ""
            actualTree1?.info5 = ""
            actualTree1?.info6 = ""
            actualTree1?.info7 = ""
            actualTree1?.info8 = ""
            actualTree1?.info9 = ""
            actualTree1?.info10 = ""
            actualTree1?.info11 = ""
            actualTree1?.crown16 = "Unbedenklich"
            actualTree1?.crown18 = "Unbedenklich"
            actualTree1?.crown10 = "leicht"
            actualTree1?.environment6 = "Ja"
            
            // LocationManager
            if CLLocationManager.locationServicesEnabled()
            {
                //locationManager = CLLocationManager()
                // Ask for the user Authority for GPS
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.delegate = self
                locationManager.requestWhenInUseAuthorization()
                locationManager.startUpdatingLocation()
                startLocation = nil
                
            }
            
        } else {
            actualTree1 = tabBar.actualTree
            //MARK: Load the Values from the last Inspection
            self.field1.text = actualTree1?.info0
            self.field2.text = actualTree1?.info2
            self.field3.text = actualTree1?.info3
            self.field4.text = actualTree1?.info4
            self.field5.text = actualTree1?.info5
            self.field6.text = actualTree1?.info6
            self.field7.text = actualTree1?.info7
            self.field8.text = actualTree1?.info8
            self.field9.text = actualTree1?.info9
            self.field10.text = actualTree1?.info10
            self.field11.text = actualTree1?.info11
            
            if actualTree1?.info12 == "Jugend" {
                
                for button in(self.bottomStackView.subviews[0].subviews[1].subviews) {
                    
                    button.backgroundColor = UIColor.clear
                }
                self.bottomStackView.subviews[0].subviews[1].subviews[0].backgroundColor = UIColor.customColors.customGreen
            }
            
            if actualTree1?.info12 == "Reife" {
                for button in (self.bottomStackView.subviews[0].subviews[1].subviews) {
                    button.backgroundColor = UIColor.clear
                }
                self.bottomStackView.subviews[0].subviews[1].subviews[1].backgroundColor = UIColor.customColors.customGreen
            }
            if actualTree1?.info12 == "Alterung" {
                for button in (self.bottomStackView.subviews[0].subviews[1].subviews) {
                    button.backgroundColor = UIColor.clear
                }
                self.bottomStackView.subviews[0].subviews[1].subviews[2].backgroundColor = UIColor.customColors.customGreen
            }
            if actualTree1?.info13 == "Gering" {
                for button in (self.bottomStackView.subviews[2].subviews[1].subviews) {
                    button.backgroundColor = UIColor.clear
                }
                self.bottomStackView.subviews[2].subviews[2].subviews[0].backgroundColor = UIColor.customColors.customGreen
            }
            if actualTree1?.info13 == "Hoch" {
                
                print(self.bottomStackView.subviews.count)
                
                print(self.bottomStackView.subviews[0].subviews.count)
                
                print(self.bottomStackView.subviews[0].subviews[1].subviews.count)
                
                for button in (self.bottomStackView.subviews[2].subviews[1].subviews) {
                    button.backgroundColor = UIColor.clear
                }
                self.bottomStackView.subviews[2].subviews[1].subviews[1].backgroundColor = UIColor.customColors.customGreen
            }
            if actualTree1?.info14 == "Gesund/leicht geschädigt" {
                for button in (self.bottomStackView.subviews[4].subviews[1].subviews) {
                    button.backgroundColor = UIColor.clear
                }
                self.bottomStackView.subviews[4].subviews[1].subviews[0].backgroundColor = UIColor.customColors.customGreen
            }
            if actualTree1?.info14 == "Stärker geschädigt" {
                for button in (self.bottomStackView.subviews[4].subviews[1].subviews) {
                    button.backgroundColor = UIColor.clear
                }
                self.bottomStackView.subviews[4].subviews[1].subviews[1].backgroundColor = UIColor.customColors.customGreen
            }
            
            if actualTree1?.image != nil {
                treeImageView.image = UIImage(cgImage: (UIImage.init(data: actualTree1?.image as! Data)?.cgImage)!,
                                              scale: 1.0 ,
                                              orientation: UIImageOrientation.right)
            }
            
            // Load tree end
            
            
            
        }
        
        
        
        // get the current date and time
        let currentDateTime = Date()
        
        
        if defaults.value(forKey: "userName") != nil {
            print("Hallo")
            field1.text = defaults.string(forKey: "userName")
            actualTree1?.info0 = field1.text
        }
        
        if defaults.value(forKey: "customDate") != nil  {
            print("Datum Hallo")
            dateTextField.text = defaults.string(forKey: "customDate")
            actualTree1?.info1 = dateTextField.text
        } else {
            // initialize the date formatter and set the style
            let formatter = DateFormatter()
            formatter.timeStyle = .none
            formatter.dateStyle = .long
            
            // get the date time String from the date object
            dateTextField.text =  formatter.string(from: currentDateTime)
        }
        
        //MARK: - Color load from UserDefaults
        if defaults.value(forKey: "appColor") != nil {
            let color = UIColor.color(withData: (defaults.value(forKey: "appColor") as! Data))
            view1.backgroundColor = color
            //view2.backgroundColor = color
            //treeImageView.borderColor = color
            //for view in stackView.arrangedSubviews {
            // view.borderColor = color
            //}
            //for view in bottomStackView.arrangedSubviews {
            //view.borderColor = color
            //}
            self.tabBarController?.tabBar.barTintColor = color
            self.tabBarController?.tabBar.tintColor = UIColor.white
            self.tabBarController?.tabBar.unselectedItemTintColor = UIColor.white
            // if defaults.value(forKey: "appColor") as! String == "#4C4C4C" {
            //self.tabBarController?.tabBar.tintColor = UIColor.white
            // }
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
    var resetFrame = false
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField.nextField == field11 {
            self.stackViewTopConstraint.constant -= 50
            constrainChanged = true
            print("true")
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
        self.resetFrame = false
        
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
                
                
                if(self.constrainChanged == true){
                    self.stackViewTopConstraint.constant += 50
                    self.constrainChanged = false
                    print("false")
                } else {
                    if(self.resetFrame == false){
                        self.stackView.frame.origin.y += 50
                        self.resetFrame = true
                        print("second")
                        
                    }
                }
                
            }
        }
        
    }
    
    
    //MARK: - Save Entries do database tree Object
    @IBAction func endEditing(_ sender: UITextField) {
        actualTree1?.setValue(sender.text, forKey: "info"+sender.tag.description)
        print("saved!!!")
        
    }
    
    
    @IBAction func clickedButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3){
            for item in (sender.superview?.subviews)! {
                item.backgroundColor = UIColor.clear
            }
            sender.backgroundColor = UIColor.customColors.customGreen
        }
        actualTree1?.setValue(sender.titleLabel?.text, forKey: "info"+sender.tag.description)
    }
    
    
    //MARK: - Cancel NewTreeFunction - Used in all VC
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
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let home = storyboard.instantiateViewController(withIdentifier: "menuNavigationController") as UIViewController
            self.present(home, animated: true, completion: nil)
        }
        alertController.addAction(exitAction)
        
        self.present(alertController, animated: true) {
        }
    }
    
    
}

public var actualTree1 : Tree?

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
