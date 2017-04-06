//
//  RunViewController.swift
//  MapRunner
//
//  Created by Minhung Ling on 2017-04-05.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//
//
//  HomeViewController.swift
//  MapRunner
//
//  Created by Minhung Ling on 2017-04-04.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit
import CoreLocation

class RunViewController: UIViewController, CLLocationManagerDelegate {
    
    var myLocations = [CLLocationCoordinate2D]()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            let location = locations.last!
            myLocations.append(location.coordinate)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsViewController" {
            let rvc = segue.destination as! ResultsViewController
            rvc.locations = myLocations
        }
    }
}
