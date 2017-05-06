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

class RunViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    let runManager = RunManager.sharedInstance
    let pedometer = CMPedometer()
    @IBOutlet weak var timerLabel: UILabel!
    var myLocations = [CLLocationCoordinate2D]()
    var timer: Timer!
    let locationManager = CLLocationManager()
    let activityManager = CMMotionActivityManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        panGestureRecognizer.delegate = self
        runManager.startSession()
        timerLabel.font = timerLabel.font.monospacedDigitFont
    }
    
    @IBAction func panOnView(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        runManager.panUpdateTime(timeInterval: TimeInterval(-translation.y/2))
        timerLabel.text = runManager.getTimeString()
        sender.setTranslation(CGPoint(x: 0, y: 0), in: view)
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UIPanGestureRecognizer {
            let pgr = gestureRecognizer as! UIPanGestureRecognizer
            let translation = pgr.translation(in: view)
            if abs(translation.x) > abs(translation.y) {
                return false
            }
        }
        return true
    }
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        if timer != nil {
            stopTimer()
            return
        }
        startTimer()
    }
    
    func stopTimer() {
        runManager.stopRun()

        timer.invalidate()
        timer = nil
    }
    
    func startTimer() {
        runManager.startRun()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(RunViewController.updateTimerLabel), userInfo: nil, repeats: true)
    }
    
    func updateTimerLabel() {
        runManager.updateTime(timeInterval: timer.timeInterval)
        timerLabel.text = runManager.getTimeString()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsViewController" {
            let rvc = segue.destination as! ResultsViewController
            rvc.locations = myLocations
        }
    }
}
