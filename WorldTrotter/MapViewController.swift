//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Devin Smaldore on 2/6/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController { //MKMapViewDelegate
    var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func loadView() {
        //Create a map view
        mapView = MKMapView()
        
        //Set it as *the* view of this view controller
        view = mapView
        
        locationManager.requestAlwaysAuthorization()
        
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        let segmentedControl = UISegmentedControl(items: [standardString, hybridString, satelliteString])

        
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor,
                                                                  constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        let myLocation = UIButton()
        
        
        
        myLocation.setTitle("My Location", for: .normal)
        myLocation.setTitleColor(UIColor.blue, for: .normal)
        myLocation.translatesAutoresizingMaskIntoConstraints = false
        myLocation.addTarget(self, action: #selector(myLocButtonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(myLocation)
        myLocation.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -8).isActive = true
        myLocation.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MapViewController loaded its view.")
    }
    
    func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    func myLocButtonTapped(_ button: UIButton) {
        
        print("MyLocation")
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
        
    }
}

//*************THIS IS TO GET THE USERS LOCATION**************

/*
 class MapViewController: UIViewController, MKMapViewDelegate {
    
    var mapViw: MKMapView!
    
    //where should this appear in your code?? PROBABLY IN LOADVIEW()
    //look above??
    self.mapView.delegate = self
    mapView.delegate = self same as above we think...
 
    s   = true
    
    
}

let locationManager = CLLocationManager()

locationManager = CLLocationManager()
locationManager.delegate = self
locationManager.desiredAccuracy = kCLLocationAccuracyBest
locationManager.requestAlwaysAuthorization()
locationManager.startUpdatingLocation()

*/

func mapViewWillStartLocatingUser(_ mapView: MKMapView) {
    print("Start Loading.")
}

func mapViewDidStopLocatingUser(_ mapView: MKMapView) {
    print("Stop Loading.")
}

