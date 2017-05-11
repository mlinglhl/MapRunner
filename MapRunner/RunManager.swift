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
    
    struct StopWatch {
        var totalTime: Double = 0
        var hour: Int = 0
        var minute: Int = 0
        var second: Int = 0
        var milliSecond: Int = 0
    }
    
    struct RunSettings {
        var countDownMode = false
        var outdoorRun = false
        var trackLocation = false
    }
    
    var settings = RunSettings()
    var stopWatch = StopWatch()
    var session: Session! = nil
    var run: Run! = nil
    let locationManager = CLLocationManager()
    let dataManager = DataManager.sharedInstance
    var pedometer: CMPedometer!
    
    func startRun() {
        if session == nil {
            locationManager.delegate = self
            locationManager.requestAlwaysAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.allowsBackgroundLocationUpdates = true
            session = dataManager.generateSession()
        }
        
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
        run = nil
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
        if run != nil {
            let locationObject = dataManager.generateLocation()
            locationObject.latitude = location.coordinate.latitude
            locationObject.longitude = location.coordinate.longitude
            run.addToLocations(locationObject)
            dataManager.saveContext()
        }
    }
}

//MARK: Time Methods
extension RunManager {
    func panUpdateTime(timeInterval: TimeInterval) {
        
        //Ensures changing time is only available during an active session in countdown mode
        if session != nil {
            if !settings.countDownMode {
                return
            }
        }
        
        settings.countDownMode = true
        
        updateTime(timeInterval: timeInterval)
        
    }
    
    func addTime(timeInterval: TimeInterval) {
        var time = timeInterval
        
        if settings.countDownMode {
            time = -time
        }
        
        updateTime(timeInterval: time)
        
        //        if stopWatch.totalTime == 0 {
        //            settings.countDownMode = false
        //        }
    }
    
    func updateTime(timeInterval: TimeInterval) {
        
        if stopWatch.totalTime + timeInterval < 0 {
            stopWatch.totalTime = 0
            stopWatch.milliSecond = 0
            stopRun()
            setTimeValues()
            return
        }
        stopWatch.totalTime += timeInterval
        stopWatch.milliSecond += Int(timeInterval * 100)
        
        if stopWatch.milliSecond < 0 {
            stopWatch.milliSecond = 99
        }
        
        if stopWatch.milliSecond > 99 || abs(timeInterval) > 1 {
            stopWatch.milliSecond = 0
        }
        setTimeValues()
    }
    
    func setTimeValues() {
        stopWatch.hour = Int(stopWatch.totalTime)/3600
        stopWatch.minute = Int(stopWatch.totalTime)/60%60
        stopWatch.second = Int(stopWatch.totalTime)%60
    }
    
    func getTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        if stopWatch.hour < 1 {
            dateFormatter.dateFormat = "mm:ss"
        }
        var dateComponents = DateComponents()
        dateComponents.hour = stopWatch.hour
        dateComponents.minute = stopWatch.minute
        dateComponents.second = stopWatch.second
        dateComponents.calendar = Calendar.current
        var milliSeconds = String(stopWatch.milliSecond)
        if stopWatch.milliSecond < 10 {
            milliSeconds = "0\(stopWatch.milliSecond)"
        }
        let date = dateFormatter.string(from: dateComponents.date!)
        return "\(date):\(milliSeconds)"
    }
}
