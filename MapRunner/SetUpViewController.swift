//
//  SetUpViewController.swift
//  MapRunner
//
//  Created by Minhung Ling on 2017-04-06.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class SetUpViewController: UITableViewController {
    @IBOutlet weak var countDownModeSwitch: UISwitch!
    @IBOutlet weak var outdoorRunSwitch: UISwitch!
    @IBOutlet weak var trackLocationSwitch: UISwitch!
    var runManager = RunManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        countDownModeSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        outdoorRunSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        trackLocationSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        countDownModeSwitch.isOn = runManager.settings.countDownMode
        outdoorRunSwitch.isOn = runManager.settings.outdoorRun
        trackLocationSwitch.isOn = runManager.settings.trackLocation
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        runManager.settings.countDownMode = countDownModeSwitch.isOn
        runManager.settings.outdoorRun = outdoorRunSwitch.isOn
        runManager.settings.trackLocation = trackLocationSwitch.isOn
    }
}
