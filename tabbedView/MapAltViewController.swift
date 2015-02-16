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

class MapAltViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var trackButton: UIButton!
    
    var locationManager: CLLocationManager!
    var oldLocation: CLLocation?
    var totalDistance: Double = 0
    var isUserTracking: Bool = false
    var myLocations: [Double] = []
    
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
    
    var cLocations: [CLLocationCoordinate2D]! = []
    @IBAction func trackButtonPressed(sender: UIButton) {
        if isUserTracking {
            sender.setTitle("track my location", forState: .Normal)
            distanceLabel.text = "0.0km"
            isUserTracking = false
            println(myLocations)
            var coordinates = cLocations.map({ (location: CLLocation) ->
                CLLocationCoordinate2D in
                return location.coordinate
            })
            var polyline = MKPolyline(coordinates: &coordinates,
                count: cLocations.count)
        } else {
            isUserTracking = true
            sender.setTitle("Stop Tracking", forState: .Normal)
        }
    }
    
    func updateDistanceLabel() {
        distanceLabel.text = NSString(format: "%.2f km", totalDistance / 1000)
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if let firstLocation = locations.first as? CLLocation {
            mapView.setCenterCoordinate(firstLocation.coordinate, animated: true)
            cLocations.append(firstLocation.coordinate)
            let region = MKCoordinateRegionMakeWithDistance(firstLocation.coordinate, 1000, 1000)
            mapView.setRegion(region, animated: true)
            
            if let oldLocation = oldLocation {
                if isUserTracking {
                    println(firstLocation.coordinate)
                    let delta: CLLocationDistance = firstLocation.distanceFromLocation(oldLocation)
                    myLocations.append(delta)
                    totalDistance += delta
                    
                    updateDistanceLabel()
                }
            }
            
            oldLocation = firstLocation
        }
    }
}
