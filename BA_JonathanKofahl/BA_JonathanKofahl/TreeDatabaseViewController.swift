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
    @IBOutlet weak var deleteDetailViewButton: UIButton!
    @IBOutlet weak var editDetailViewButton: UIButton!
    @IBOutlet weak var pdfDetailViewButton: UIButton!
    @IBOutlet weak var detailStackView: UIStackView!
    @IBOutlet weak var mapStyleSwitchControl: UISegmentedControl!
    
    var placeSelected = false
    var placeIndex = 0
    
    var selectedTree : Tree?
    
    var showDetailView = false
    var color : UIColor?
    
    
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
        
        if defaults.value(forKey: "appColor") != nil {
             color = UIColor.color(withData: (defaults.value(forKey: "appColor") as! Data))
        } else {
             color = UIColor.customColors.backgroundColor
        }
        
        var alphaColor = color?.withAlphaComponent(0.8)
        
        // Set Colors
        deleteDetailViewButton.backgroundColor = color
        editDetailViewButton.backgroundColor = color
        pdfDetailViewButton.backgroundColor = color
        for view in detailStackView.subviews {
            if view.tag == 0 {
                view.backgroundColor = color
            } else {
                for label in view.subviews {
                    label.tintColor = color
                    //mapStyleSwitchControl.tintColor = color
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
            self.groupTableView.backgroundColor = UIColor.color(withData: (defaults.value(forKey: "appColor") as! Data))
            self.detailView.backgroundColor = UIColor.color(withData: (defaults.value(forKey: "appColor") as! Data))
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
            for (_,tree) in databaseModel.trees.enumerated() {
                // print(tree.place?.name)
                // print(databaseModel.places[placeIndex].name)
                print("tree.place:")
                print(tree.info4)
                print("datamodel.places:" + databaseModel.places[placeIndex].name!)
                print("found tree")

                if tree.info4 == databaseModel.places[placeIndex].name {
                    x += 1
                    tableTrees?.append(tree)
                    
                    
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
            if (Double((tableTrees?[indexPath.row].xLocation)!) != 0.0) {
                let eventLocation = CLLocationCoordinate2DMake((tableTrees?[indexPath.row].xLocation)!, (tableTrees?[indexPath.row].yLocation)!)
                // Drop a pin
                let dropPin = MKPointAnnotation()
                dropPin.coordinate = eventLocation
                if tableTrees?[indexPath.row].info6 != nil {
                    let title = "Nummer: " + (tableTrees?[indexPath.row].info6)!
                    dropPin.title = title
                }
                mapView.addAnnotation(dropPin)
                
                if indexPath.row == 0 {
                    mapView.setCenter(CLLocationCoordinate2D.init(latitude: (tableTrees?[indexPath.row].xLocation)!, longitude: (tableTrees?[indexPath.row].yLocation)!), animated: true)
                }
            }
            
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
            self.closeDetailView(self)
            tableTrees = []
            placeSelected = true
            placeIndex = indexPath.row
            self.tableViewTrees.reloadData()
            self.mapView.removeAnnotations(mapView.annotations)
        } else {
            selectedTree = tableTrees?[indexPath.row]
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
            if !showDetailView {
                self.openDetailView()
            }
            
            //detailView.isHidden = false
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Löschen"
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if tableView == tableViewTrees {
           /* // action one
            let editAction = UITableViewRowAction(style: .default, title: "Editieren", handler: { (action, indexPath) in
                print("Tree edit")
            })
            editAction.backgroundColor = UIColor.customColors.customGreen
            */
            // action two
            let deleteAction = UITableViewRowAction(style: .default, title: "Löschen", handler: { (action, indexPath) in
                //self.tableTrees?.remove(at: indexPath.row)
                databaseModel.deleteTree(objID:self.tableTrees![indexPath.row].objectID)
                databaseModel.save()
               // self.tableViewPlaces.reloadData()
                var path = IndexPath(row:self.placeIndex, section: 0)
                
                var test = self.placeIndex
                print(self.placeIndex)
                
                
                
                self.tableView(self.tableViewPlaces, didSelectRowAt: path)
               // self.tableViewTrees.reloadData()

                print("Tree delete")
            })
            deleteAction.backgroundColor = UIColor.customColors.customRed
            
            return [deleteAction]
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
                print("Place delete")
            })
            
            deleteAction.backgroundColor = UIColor.customColors.customRed
            
            return [deleteAction]
            
        }
        
    }
    
    @IBAction func closeDetailView(_ sender: Any) {
        
        // self.detailView.isHidden = true
        if self.showDetailView == true {
            UIView.animate(withDuration: 0.7) {
                self.detailView.frame.origin.x = self.detailView.frame.origin.x + 400
                self.showDetailView = false
                print("false")
            }
        }
    }
    
    func openDetailView() -> Void {
        if self.showDetailView == false {
            UIView.animate(withDuration: 0.7) {
                self.detailView.isHidden = false
                self.detailView.frame.origin.x = self.detailView.frame.origin.x - 400
                self.showDetailView = true
                print("true")
            }
        }
    }
    
    func deleteTree() -> Void {
        self.closeDetailView(self)
        
        // self.tableViewPlaces.reloadData()
        var path = IndexPath(row:self.placeIndex, section: 0)
        var test = self.placeIndex
        databaseModel.deleteTree(objID:self.tableTrees![path.row].objectID)
        databaseModel.save()
        print(self.placeIndex)
        self.tableView(self.tableViewPlaces, didSelectRowAt: path)

        
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        deleteTree()
    }
    
    
    @IBAction func swipeDetailView(_ sender: Any) {
        self.closeDetailView(sender)
    }
    
    @IBAction func editTree(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Inspect", bundle: nil)
        let tabBar = storyboard.instantiateViewController(withIdentifier: "tabbar") as! TabbarController
        tabBar.actualTree = selectedTree
        present(tabBar as UIViewController, animated: true, completion: nil)
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
    
    @IBAction func setMapStyle(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.mapView.mapType = MKMapType.hybrid
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
        }
        if sender.selectedSegmentIndex == 1 {
            self.mapView.mapType = MKMapType.standard
           // detailView.backgroundColor = UIColor.color(withData: (defaults.value(forKey: "appColor") as! Data))
            //self.groupTableView.backgroundColor = UIColor.color(withData: (defaults.value(forKey: "appColor") as! Data))
            detailView.backgroundColor = UIColor.customColors.backgroundColor.withAlphaComponent(0.8)
            self.groupTableView.backgroundColor = UIColor.customColors.backgroundColor.withAlphaComponent(0.8)

            self.detailView.subviews[0].removeFromSuperview()
            self.groupTableView.subviews[0].removeFromSuperview()
        }
    }
    
    
    
    /**( When NSError in Locationmanager do nothing
     */
    public func locationManager(manager: CLLocationManager,
                                didFailWithError error: NSError) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createPDF" {
            if let pdfView = segue.destination as? PDFViewController {
                pdfView.tree = selectedTree }
            
            
        }
    }
    
    
    
    
}
