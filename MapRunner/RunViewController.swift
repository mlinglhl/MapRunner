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
    @IBOutlet weak var timerLabel: UILabel!
    
    var startTime: Date!
    
    var myLocations = [CLLocationCoordinate2D]()
    var timer: Timer!
    var totalTime: TimeInterval = 0
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        }
    
    @IBAction func timerLabelTapped(_ sender: UITapGestureRecognizer) {
        if startTime == nil {
            startTime = Date()
        }
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(RunViewController.updateTimerLabel), userInfo: nil, repeats: true)
        }
    }
    
    func updateTimerLabel() {
        totalTime += timer.timeInterval
        var timeLeft = totalTime
        let hours = Int(timeLeft/3600)
        timeLeft -= Double(hours) * 3600
        let minutes = Int(timeLeft/60)
        timeLeft -= Double(minutes) * 60
        let seconds = timeLeft
        
        timerLabel.text = "\(hours):\(minutes):\(seconds)"
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
