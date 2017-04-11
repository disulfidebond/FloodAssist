//
//  ThemisInfoTableViewController.swift
//  Themis
//
//  Created by Thor on 8/19/16.
//  Copyright © 2016 Thor. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Contacts

class ThemisInfoTableViewController: UITableViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    lazy var locationManager: CLLocationManager = {
        let m = CLLocationManager()
        m.delegate = self
        m.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        return m
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Updated Location!")
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed!")
        print((error))
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if case .authorizedWhenInUse = status{
            manager.requestLocation()
            print("Got Location")
        }
        else {
            //manager.
            print("No location")
        }
    }

    var names = [ThemisObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        names = [ThemisObject(n: "Campus Alerts", d: "Web Updates and Information for LSU"),
                 ThemisObject(n: "LSU Flood Updates", d: "Web Updates for Flooding"),
                 ThemisObject(n: "Road Closures", d: "Google Map with Road Closures"),
                 ThemisObject(n: "PILS", d: "LSU Public Interest Law Society"),
                 ThemisObject(n: "Flooding Assistance", d: "Forms to request and volunteer assistance")
                ]
        self.tableView.backgroundColor = UIColor.purple
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell!
        if (cell != nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        }
        
        cell?.selectionStyle = UITableViewCellSelectionStyle.gray
        cell?.accessoryType = .disclosureIndicator
        let labelName = names[indexPath.row]
        
        cell?.backgroundColor? = UIColor.clear
        
        // cell?.selectedBackgroundView?.backgroundColor = UIColor.whiteColor()
        
        cell?.textLabel?.font = UIFont(name: "Times New Roman", size: 18)
        cell?.textLabel?.textColor = UIColor.white

        cell?.detailTextLabel?.textColor = UIColor.yellow
        
        cell?.textLabel?.text = labelName.n
        cell?.detailTextLabel?.text = labelName.d
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let alertURL = "http://www.lsu.edu/eoc/emergency-response-pages/index.php"
            let alertClosure = { (action:UIAlertAction!) -> Void in
                UIApplication.shared.openURL(URL(string: alertURL)!)
            }
            let campusAlert = UIAlertController(title: "Campus Alert Webpage", message: "This will open the Alert link for LSU in Safari", preferredStyle: UIAlertControllerStyle.alert)
            // let launchCampusAlertWebpage = UIAlertAction(title: "Ok", style: .Default, handler: Selector)
            let launchCampusAlertWebpage = UIAlertAction(title: "Ok", style: .default, handler: alertClosure)
            let noLaunchCampusAlertWebpage = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            campusAlert.addAction(launchCampusAlertWebpage)
            campusAlert.addAction(noLaunchCampusAlertWebpage)
            self.present(campusAlert, animated: true, completion: nil)
           tableView.deselectRow(at: indexPath, animated: true)
        }
        else if indexPath.row == 1 {
            let alertURL = "http://www.lsu.edu/floodrelief/index.php"
            let alertClosure = { (action:UIAlertAction!) -> Void in
                UIApplication.shared.openURL(URL(string: alertURL)!)
            }
            let campusAlert = UIAlertController(title: "Flood Relief Webpage", message: "This will open the LSU Flood Relief webpage in Safari", preferredStyle: UIAlertControllerStyle.alert)
            // let launchCampusAlertWebpage = UIAlertAction(title: "Ok", style: .Default, handler: Selector)
            let launchCampusAlertWebpage = UIAlertAction(title: "Ok", style: .default, handler: alertClosure)
            let noLaunchCampusAlertWebpage = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            campusAlert.addAction(launchCampusAlertWebpage)
            campusAlert.addAction(noLaunchCampusAlertWebpage)
            self.present(campusAlert, animated: true, completion: nil)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        else if indexPath.row == 2 {
            
            let alertToOpenMap = UIAlertController(title: "Open in Maps", message: "Would you like to open your location in Maps?", preferredStyle: .alert)
            let openInMapsHandler = { (action:UIAlertAction!) -> Void in
                if CLLocationManager.locationServicesEnabled() {
                    switch CLLocationManager.authorizationStatus(){
                    case .authorizedWhenInUse:
                        let src = MKMapItem.forCurrentLocation()
                            MKMapItem.openMaps(with: [src], launchOptions: nil)
                    case .denied:
                        print("LocationServices Not Allowed")
                        let mapNotify = UIAlertController(title: "Locatin Services Turned Off", message: "Turn On Location Services in Settings > Privacy to Allow App to determine your current location", preferredStyle: UIAlertControllerStyle.alert)
                        
                        let mapAction = UIAlertAction(title: "Settings", style: UIAlertActionStyle.default, handler: { (paramAction:UIAlertAction) -> Void in
                            DispatchQueue.main.async(execute: { let settingsURL = URL(string: UIApplicationOpenSettingsURLString)
                                if let url = settingsURL { UIApplication.shared.openURL(url)}
                            })
                        })
                        mapNotify.addAction(mapAction)
                        mapNotify.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                        self.present(mapNotify, animated: true, completion: nil)
                        
                    case .restricted:
                        print("Restricted")
                        let mapRestrictedNotify = UIAlertController(title: "Location Services Could Not be determined", message: "Location Services could not be determined at this time", preferredStyle: UIAlertControllerStyle.alert)
                        mapRestrictedNotify.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(mapRestrictedNotify, animated: true, completion: nil)
                    case .notDetermined:
                        self.locationManager.requestWhenInUseAuthorization()

                    default:
                        print("Unknown")
                        let mapRestrictedNotify = UIAlertController(title: "Location Services Could Not be determined", message: "Location Services could not be determined at this time", preferredStyle: UIAlertControllerStyle.alert)
                        mapRestrictedNotify.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(mapRestrictedNotify, animated: true, completion: nil)
                    }
                } else {
                    let simplifiedAlert = UIAlertController(title: "Location Services are not enabled", message: "Location Services are not enabled, please check settings", preferredStyle: UIAlertControllerStyle.alert)
                    simplifiedAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(simplifiedAlert, animated: true, completion: nil)
                }
            }
            let openMapsAction = UIAlertAction(title: "Yes", style: .default, handler: openInMapsHandler)
            let noOpenMapsAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
            alertToOpenMap.addAction(openMapsAction)
            alertToOpenMap.addAction(noOpenMapsAction)
            self.present(alertToOpenMap, animated: true, completion: nil)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        else if indexPath.row == 3 {
            let alertURL = "https://sites.law.lsu.edu/pils/"
            let alertClosure = { (action:UIAlertAction!) -> Void in
                UIApplication.shared.openURL(URL(string: alertURL)!)
            }
            let campusAlert = UIAlertController(title: "LSU Public Interest Law Society", message: "This will open to the PILS webpage in Safari", preferredStyle: UIAlertControllerStyle.alert)
            let launchCampusAlertWebpage = UIAlertAction(title: "Ok", style: .default, handler: alertClosure)
            let noLaunchCampusAlertWebpage = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            campusAlert.addAction(launchCampusAlertWebpage)
            campusAlert.addAction(noLaunchCampusAlertWebpage)
            self.present(campusAlert, animated: true, completion: nil)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        else {
            performSegue(withIdentifier: "assistRequest", sender: tableView)
        }
    }


}
