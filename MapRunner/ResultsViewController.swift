//
//  ResultsViewController.swift
//  MapRunner
//
//  Created by Minhung Ling on 2017-04-05.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit
import MapKit

class ResultsViewController: UIViewController, MKMapViewDelegate {
    var locations = [CLLocationCoordinate2D]()

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.mapType = .standard
        let spanX = 0.004
        let spanY = 0.004
        if locations.count > 0 {
            let region = MKCoordinateRegion(center: locations.last!, span: MKCoordinateSpanMake(spanX, spanY))
            mapView.setRegion(region, animated: false)
            drawPath()
        }
    }
    
    @IBAction func refreshButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
    
    func drawPath() {
        var pathArray = [CLLocationCoordinate2D]()
        for index in 0..<locations.count {
            pathArray.append(locations[index])
        }
        let polyline = MKPolyline(coordinates: pathArray, count: pathArray.count)
        mapView.add(polyline)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        polylineRenderer.strokeColor = UIColor.blue
        polylineRenderer.lineWidth = 4
        return polylineRenderer
    }
    
}
