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
    
    let pedometer = CMPedometer()
    @IBOutlet weak var timerLabel: UILabel!
    let timeManager = TimeManager.sharedInstance
    let stepManager = StepManager.sharedInstance
    var myLocations = [CLLocationCoordinate2D]()
    var timer: Timer!
    let locationManager = CLLocationManager()
    let activityManager = CMMotionActivityManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        timerLabel.font = timerLabel.font.monospacedDigitFont
        }
    
    @IBAction func timerLabelTapped(_ sender: UITapGestureRecognizer) {
        stepManager.togglePedometer()
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(RunViewController.updateTimerLabel), userInfo: nil, repeats: true)
            return
        }
        timer.invalidate()
        timer = nil
    }
    
    func updateTimerLabel() {
        timerLabel.text = timeManager.getTimeString(timeInterval: timer.timeInterval)
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
