//
//  RunManager.swift
//  MapRunner
//
//  Created by Minhung Ling on 2017-05-02.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit
import CoreLocation
import CoreMotion

class RunManager: NSObject, CLLocationManagerDelegate {
    
    static let sharedInstance = RunManager()
    private override init() {}
    
    var session: Session! = nil
    var run: Run! = nil
    let locationManager = CLLocationManager()
    let dataManager = DataManager.sharedInstance
    var pedometer: CMPedometer!
    
    func startSession() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        session = dataManager.generateSession()
    }
    
    func startRun() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        run = dataManager.generateRun()
        session.addToRuns(run)
        startPedometer()
    }
    
    func stopRun() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.stopUpdatingLocation()
        }
        stopPedometer()
    }
    
    //MARK: Pedometer methods
    func startPedometer() {
        if CMPedometer.isStepCountingAvailable() {
            if pedometer == nil {
                pedometer = CMPedometer()
            }
            pedometer.startUpdates(from: Date(), withHandler: { (pedometerData, error) in
                if let pedData = pedometerData{
                    self.session.steps = Int16(pedData.numberOfSteps)
                    print("\(self.session.steps)")
                    print("\(pedData.numberOfSteps)")
                    self.dataManager.saveContext()
                } else {
                    print("Steps not available")
                }
            })
        }
    }
    
    func stopPedometer() {
        if CMPedometer.isStepCountingAvailable() {
            pedometer.stopUpdates()
        }
    }
    
    //MARK: CLLocationManagerDelegate methods
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            addLocation(locations.last!)
        }
    }
    
    func addLocation(_ location: CLLocation) {
        let locationObject = dataManager.generateLocation()
        locationObject.latitude = location.coordinate.latitude
        locationObject.longitude = location.coordinate.longitude
        run.addToLocations(locationObject)
        dataManager.saveContext()
    }
}
