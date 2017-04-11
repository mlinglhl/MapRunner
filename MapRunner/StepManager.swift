//
//  StepManager.swift
//  MapRunner
//
//  Created by Minhung Ling on 2017-04-07.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit
import CoreMotion

class StepManager: NSObject {
    
    var pedometer: CMPedometer!
    var stepCount = 0
    
    func togglePedometer() {
        if pedometer == nil {
            pedometer = CMPedometer()
            pedometer.startUpdates(from: Date(), withHandler: { (pedometerData, error) in
                if let pedData = pedometerData{
                    self.stepCount += Int(pedData.numberOfSteps)
                    print("\(self.stepCount)")
                } else {
                    print("Steps not available")
                }
            })
            return
        }
        pedometer.stopUpdates()
    }
}
