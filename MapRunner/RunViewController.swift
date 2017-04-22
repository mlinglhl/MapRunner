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
import CoreMotion

class RunViewController: UIViewController, CLLocationManagerDelegate {
    struct StopWatch {
        var totalTime: Double = 0
        var hour: Int = 0
        var minute: Int = 0
        var second: Int = 0
        var milliSecond: Int = 0
    }
    
    var run: Run!
    let dataManager = DataManager.sharedInstance
    let pedometer = CMPedometer()
    @IBOutlet weak var timerLabel: UILabel!
    let timeManager = TimeManager()
    let stepManager = StepManager()
    var myLocations = [CLLocationCoordinate2D]()
    var timer: Timer!
    let locationManager = CLLocationManager()
    let activityManager = CMMotionActivityManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        timerLabel.font = timerLabel.font.monospacedDigitFont
        if run == nil {
            run = dataManager.generateRun() as! Run
        }
    }
    
    @IBAction func timerLabelTapped(_ sender: UITapGestureRecognizer) {
        if run == nil {
            locationManager.startUpdatingLocation()
        }
        stepManager.togglePedometer()
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(RunViewController.updateTimerLabel), userInfo: nil, repeats: true)
            return
        }
        timer.invalidate()
        timer = nil
    }
    
    func updateTimerLabel() {
        timeManager.updateTime(timeInterval: timer.timeInterval)
        timerLabel.text = timeManager.getTimeString()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            let location = locations.last!
            myLocations.append(location.coordinate)
            let locationObject = dataManager.generateLocation() as! Location
            locationObject.latitude = location.coordinate.latitude
            locationObject.longitude = location.coordinate.longitude
            run.addToLocations(locationObject)
            dataManager.saveContext()
        }
    }
    
    @IBAction func panOnView(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        timeManager.updateTime(timeInterval: TimeInterval(-translation.y))
        timerLabel.text = timeManager.getTimeString()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsViewController" {
            let rvc = segue.destination as! ResultsViewController
            rvc.locations = myLocations
        }
    }
}
