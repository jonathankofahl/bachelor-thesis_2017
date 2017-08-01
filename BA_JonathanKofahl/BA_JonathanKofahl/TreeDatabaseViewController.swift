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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var treeNumberLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var treeImageView: UIImageView!
    
    // Seperated Arrays for the two Tables
    var tableCriteria : [String]?
    var tableCriteria1 : [String]?
    
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
        
        
        
        tableCriteria = []
        tableCriteria1 = []
        
        //MARK: - TableView init -> load strings from Localization.strings file
        for tree in databaseModel.trees {
            tableCriteria1?.append(tree.treeNumber.description)
        }
        for index in 14...23 {
            let ressourceName = "care" + index.description
            tableCriteria?.append( NSLocalizedString(ressourceName, comment: "") )
        }
        
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
        
        if tableView == self.tableView {
            return tableCriteria!.count
        } else {
            return tableCriteria1!.count
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        /*
        if tableView == self.tableView {
            cell.criteria.text = tableCriteria?[indexPath.row]
        } else {
            cell.criteria.text = tableCriteria1?[indexPath.row]
        }
        */
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        treeNumberLabel.text = databaseModel.trees[0].treeNumber.description
        placeLabel.text = databaseModel.trees[0].info0?.description
        timeLabel.text = databaseModel.trees[0].info1?.description
        categoryLabel.text = databaseModel.trees[0].info2?.description
        treeImageView.image = UIImage.init(data: databaseModel.trees[0].image as! Data)
        
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
