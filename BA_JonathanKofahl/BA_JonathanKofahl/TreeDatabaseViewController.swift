//
//  TreeDatabaseViewController.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 12.06.17.
//
//

import UIKit
import MapKit
import CoreLocation

class TreeDatabaseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    //MARK: - Variables & Outlets
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var tableViewPlaces: UITableView!
    @IBOutlet weak var tableViewTrees: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var treeNumberLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var groupTableView: UIView!
    @IBOutlet weak var closeDetailViewButton: UIButton!
    @IBOutlet weak var detailStackView: UIStackView!
    
    var placeSelected = false
    var placeIndex = 0
    
    
    // Seperated Arrays for the two Tables
    //var tablePlaces : [Place]?
    var tableTrees : [Tree]?
        
    /** Bool of Map
     */
    var mapInitialized = true;
    
    /** The Location Manager
     */
    var locationManager: CLLocationManager = CLLocationManager()
    /** The Location Managers start Location
     */
    var startLocation: CLLocation!
    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var color = UIColor.init(hexString: defaults.value(forKey: "appColor") as! String)
        var alphaColor = color.withAlphaComponent(0.8)
        
        // Set Colors
        closeDetailViewButton.backgroundColor = color
        for view in detailStackView.subviews {
            if view.tag == 0 {
                view.backgroundColor = color
            } else {
                for label in view.subviews {
                    label.tintColor = color
                }
            }
        }
        
        // https://stackoverflow.com/questions/17041669/creating-a-blurring-overlay-view
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            self.groupTableView.backgroundColor = UIColor.clear
            self.detailView.backgroundColor = UIColor.clear
            
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.groupTableView.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            self.groupTableView.insertSubview(blurEffectView, at: 0)
            
            let blurEffectView1 = UIVisualEffectView(effect: blurEffect)
            blurEffectView1.frame = self.detailView.bounds
            blurEffectView1.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            self.detailView.insertSubview(blurEffectView1, at: 0)
        } else {
            self.groupTableView.backgroundColor = alphaColor
            self.detailView.backgroundColor = alphaColor
        }
        
        //self.detailView.frame.origin.x = self.detailView.frame.origin.x + 400
        //detailView.isHidden = false
        
        
        self.tableViewTrees.allowsMultipleSelectionDuringEditing = false
        
        //tablePlaces = []
        tableTrees = []
        
        //MARK: - TableView init -> load strings from Localization.strings file
        /*for tree in databaseModel.trees {
            tableCriteria1?.append(tree.treeNumber.description)
        }
        */
        
        // MapView
        if CLLocationManager.locationServicesEnabled()
        {
            //locationManager = CLLocationManager()
            // Ask for the user Authority for GPS
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            startLocation = nil
            
            mapView.showsUserLocation = true
        
                /*
                for element in trees {
                    let eventLocation = CLLocationCoordinate2DMake(Double(element.latitude), Double(element.longitude))
                    // Drop a pin
                    let dropPin = MKPointAnnotation()
                    dropPin.coordinate = eventLocation
                    dropPin.title = element.number
                    mapView.addAnnotation(dropPin)
                }
            }
            */
        }
        else
        {
            print("Location service disabled");
        }

    
    
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - TableView Configuration
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if tableView == self.tableViewPlaces {
            return databaseModel.places.count
        } else {
            if !placeSelected {
                return 0
            }
            
            var x = 0
            for (index,tree) in databaseModel.trees.enumerated() {
               // print(tree.place?.name)
               // print(databaseModel.places[placeIndex].name)
                
                if tree.place == databaseModel.places[placeIndex] {
                    x += 1
                    tableTrees?.append(tree)
                   // print("found tree")
                    
                    //print(tableTrees)
                }
            }
            return x
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var cell  = TreeDatabaseTableViewCellPlace()
        var cell1  = TreeDatabaseTableViewCellTree()
        
        if tableView == self.tableViewPlaces {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TreeDatabaseTableViewCellPlace
            cell.placeLabel.text = databaseModel.places[indexPath.row].name?.description
        } else {
            cell1 = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TreeDatabaseTableViewCellTree
            cell1.treeNumberLabel.text = tableTrees?[indexPath.row].info6
            return cell1
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if tableView == self.tableViewPlaces {
            //detailView.isHidden = true
            UIView.animate(withDuration: 0.7) {
                self.detailView.frame.origin.x = self.detailView.frame.origin.x + 400
                self.detailView.tag = 0
            }
            tableTrees = []
            placeSelected = true
            placeIndex = indexPath.row
            self.tableViewTrees.reloadData()
        } else {
        
        treeNumberLabel.text = tableTrees?[indexPath.row].info6
        placeLabel.text = tableTrees?[indexPath.row].info4
        timeLabel.text = tableTrees?[indexPath.row].info1
        categoryLabel.text = tableTrees?[indexPath.row].info5
        if tableTrees?[indexPath.row].image != nil {
            treeImageView.isHidden = false
            treeImageView.image = UIImage(cgImage: (UIImage.init(data: tableTrees?[indexPath.row].image! as! Data)?.cgImage)!,
                                          scale: 1.0 ,
                                          orientation: UIImageOrientation.right)
        } else {
            treeImageView.isHidden = true
        }
            if detailView.tag == 0 {
                UIView.animate(withDuration: 0.7) {
                    self.detailView.isHidden = false
                    self.detailView.frame.origin.x = self.detailView.frame.origin.x - 400
                    self.detailView.tag = 1
                }
            }
            
        //detailView.isHidden = false
        
        }
    }
    
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
            return "Löschen"
        }
        
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if tableView == tableViewTrees {
        // action one
        let editAction = UITableViewRowAction(style: .default, title: "Editieren", handler: { (action, indexPath) in
            print("Tree edit")
        })
        editAction.backgroundColor = UIColor.init(hexString: "00B079")
        
        // action two
        let deleteAction = UITableViewRowAction(style: .default, title: "Löschen", handler: { (action, indexPath) in
            //self.tableTrees?.remove(at: indexPath.row)
            print(self.tableTrees![indexPath.row].treeNumber)
            databaseModel.deleteTree(index:Int(self.tableTrees![indexPath.row].treeNumber))
            self.tableViewTrees.reloadData()
            databaseModel.save()
            print("Tree delete")
        })
        deleteAction.backgroundColor = UIColor.red
        
        return [editAction, deleteAction]
        } else
        {
            // action two
            let deleteAction = UITableViewRowAction(style: .default, title: "Löschen", handler: { (action, indexPath) in
                //self.tableTrees?.remove(at: indexPath.row)
                //print(self.tableTrees![indexPath.row].treeNumber)
                databaseModel.deletePlace(index: indexPath.row)
                self.tableTrees = []
                self.placeSelected = false
                self.tableViewTrees.reloadData()
                self.tableViewPlaces.reloadData()
                databaseModel.save()
                self.closeDetailView(self)
                print("Tree delete")
            })
            
            deleteAction.backgroundColor = UIColor.red
            
        return [deleteAction]
        
        }
        
    }
    
    @IBAction func closeDetailView(_ sender: Any) {
       // self.detailView.isHidden = true
        UIView.animate(withDuration: 0.7) {
            self.detailView.frame.origin.x = self.detailView.frame.origin.x + 400
            self.detailView.tag = 0
        }
    }
    
    
        //MARK: - MapView
        
        
        /** Read out the Locationmanager and write the Data to the Labels and set the map
         */
        public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            let location = locations.last! as CLLocation
            
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007))
            
            
            /** When map is loaded, remove Region Lock
             */
            if (mapInitialized){
                mapView.setRegion(region, animated: true)
            }
            
            // print("update")
            
            let latestLocation: AnyObject = locations[locations.count - 1]
            
            if startLocation == nil {
                startLocation = latestLocation as! CLLocation
            }
        }
        
        
        /**( When NSError in Locationmanager do nothing
         */
        public func locationManager(manager: CLLocationManager,
                                    didFailWithError error: NSError) {
            
        }

    
}
