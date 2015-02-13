//
//  MapAltViewController.swift
//  tabbedView
//
//  Created by ジエーンポール ソリバ on 2/14/15.
//  Copyright (c) 2015 ジエーンポール ソリバ. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapAltViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var trackButton: UIButton!
    
    var locationManager: CLLocationManager!
    var oldLocation: CLLocation?
    var totalDistance: Double = 0
    var isUserTracking: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.setUserTrackingMode(MKUserTrackingMode.Follow, animated: true)


        // Do any additional setup after loading the view.
    }
    
    func createLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.activityType = .Fitness
    }
    
    @IBAction func trackButton(sender: AnyObject) {
        if isUserTracking {
            trackButton.setTitle("track my location", forState: .Normal)
            distanceLabel.text = "0.0km"
            isUserTracking = false
        } else {
            isUserTracking = true
            trackButton.setTitle("Stop tracking", forState: .Normal)
        }
    }
    
    func updateDistanceLabel() {
        distanceLabel.text = NSString(format: "%.2f km", totalDistance / 1000)
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if let firstLocation = locations.first as? CLLocation {
            mapView.setCenterCoordinate(firstLocation.coordinate, animated: true)
            
            let region = MKCoordinateRegionMakeWithDistance(firstLocation.coordinate, 1000, 1000)
            mapView.setRegion(region, animated: true)
            
            if let oldLocation = oldLocation {
                let delta: CLLocationDistance = firstLocation.distanceFromLocation(oldLocation)
                totalDistance += delta
                updateDistanceLabel()
            }
            
            oldLocation = firstLocation
        }
    }
}
