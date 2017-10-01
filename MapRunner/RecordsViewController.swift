//
//  RecordsViewController.swift
//  MapRunner
//
//  Created by Minhung Ling on 2017-09-28.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class RecordsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var sessionArray = [Session]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sessionArray = DataManager.sharedInstance.fetchSessions()
    }
}

extension RecordsViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordsTableViewCell", for: indexPath) as! RecordsTableViewCell
        return cell
    }
}
