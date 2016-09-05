//
//  ViewController.swift
//  TesteWaze
//
//  Created by Edgar Junior on 9/5/16.
//  Copyright © 2016 Edgar Junior. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var textFieldLatitude: UITextField!
    @IBOutlet weak var textFieldLongitude: UITextField!
    let locationManager = CLLocationManager()
    var globallocation = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        if (CLLocationManager.locationServicesEnabled()) {

            locationManager.requestAlwaysAuthorization()
            if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse){
                
                globallocation = locationManager.location!
                
            }
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()

        } else {
            print("Location services are not enabled");
        }
    }
    
    func viewWaze(location : CLLocation) {
        
        let latitude:Double = location.coordinate.latitude;
        let longitude:Double = location.coordinate.longitude;
        
        var link:String = "waze://"
        
        let wazeInstalled = schemeAvailable(link)
        
        if wazeInstalled {
            
            let urlStr:NSString = NSString(format: "waze://?ll=%f,%f&navigate=yes",latitude, longitude)
            
            UIApplication.sharedApplication().openURL(NSURL(string: urlStr as String)!)
            UIApplication.sharedApplication().idleTimerDisabled = true
            
            
        } else {
            link = "http://itunes.apple.com/us/app/id323229106"
            UIApplication.sharedApplication().openURL(NSURL(string: link)!)
            UIApplication.sharedApplication().idleTimerDisabled = true
        }
        
    }
    
    func schemeAvailable(scheme: String) -> Bool {
        //if let url = NSURL.init(string: scheme) {
        //    return UIApplication.sharedApplication().canOpenURL(url)
        //}
        return true
    }
    
    @IBAction func OpenWaze_Click(sender: AnyObject)
    {
        viewWaze(globallocation)
    }

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        locationManager.stopUpdatingLocation()

    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        globallocation = locationObj
        let coord = locationObj.coordinate
        textFieldLongitude.text = "\(coord.longitude)"
        textFieldLatitude.text = "\(coord.latitude)"
    }

}

