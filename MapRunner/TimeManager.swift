//
//  TimeManager.swift
//  MapRunner
//
//  Created by Minhung Ling on 2017-04-06.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class TimeManager: NSObject {
    struct StopWatch {
        var totalTime: Double = 0
        var hour: Int = 0
        var minute: Int = 0
        var second: Int = 0
        var milliSecond: Int = 0
    }

    var stopWatch = StopWatch()

    func getTimeString(timeInterval: TimeInterval) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        stopWatch.totalTime += timeInterval
        stopWatch.milliSecond += Int(timeInterval * 100)
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
        return "\(date):\(milliSeconds)"
    }
}
