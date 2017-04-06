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
    struct StopWatch {
        var totalTime: Double = 0
        var hour: Int = 0
        var minute: Int = 0
        var second: Int = 0
        var milliSecond: Int = 0
    }
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var startTime: Date!
    var stopWatch = StopWatch()
    var myLocations = [CLLocationCoordinate2D]()
    var timer: Timer!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        timerLabel.font = timerLabel.font.monospacedDigitFont
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        stopWatch.totalTime += timer.timeInterval
        stopWatch.milliSecond += Int(timer.timeInterval * 100)
        if stopWatch.milliSecond > 99 {
            stopWatch.milliSecond = 0
        }
        stopWatch.hour = Int(stopWatch.totalTime)/3600
        if stopWatch.hour < 1 {
            dateFormatter.dateFormat = "mm:ss"
        }
        stopWatch.minute = Int(stopWatch.totalTime)/60%60
        stopWatch.second = Int(stopWatch.totalTime)%60
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
        timerLabel.text = "\(date):\(milliSeconds)"
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
