//
//  HomeViewController.swift
//  MapRunner
//
//  Created by Minhung Ling on 2017-04-04.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class HomeViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var latitudeLabel: UILabel!
    
    @IBOutlet weak var longitudeLabel: UILabel!
    
    @IBOutlet weak var altitudeLabel: UILabel!
    
    @IBOutlet weak var speedLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var myLocations = [CLLocationCoordinate2D]()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        let spanX = 0.007
        let spanY = 0.007
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
        mapView.setRegion(region, animated: false)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            let location = locations.last!
            latitudeLabel.text = "\(location.coordinate.latitude)"
            longitudeLabel.text = "\(location.coordinate.longitude)"
            altitudeLabel.text = "\(location.altitude)"
            let mpsSpeed = location.speed
            let kmpsSpeed = mpsSpeed/1000
            let kmphSpeed = kmpsSpeed * 3600
            
            speedLabel.text = "\(kmphSpeed)"
            
            myLocations.append(location.coordinate)
        }
        
        if myLocations.count > 1 {
            let currentIndex = myLocations.count - 1
            let previousIndex = myLocations.count - 2
            let positionArray = [myLocations[currentIndex], myLocations[previousIndex]]
            let polyline = MKPolyline(coordinates: positionArray, count: positionArray.count)
            mapView.add(polyline)
        }
        
        let spanX = 0.002
        let spanY = 0.002
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        //       if overlay is MKPolyline {
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        polylineRenderer.strokeColor = UIColor.blue
        polylineRenderer.lineWidth = 4
        return polylineRenderer
        //       }
        //       return nil
    }
    
}
