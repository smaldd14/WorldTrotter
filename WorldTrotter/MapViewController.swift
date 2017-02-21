//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Devin Smaldore on 2/6/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//
//  Date: 2-20-17
//  Class: csc-2310
//  

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController { //MKMapViewDelegate
    var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var lastLoc = CLLocationCoordinate2D()
    var trackingUser = false

    //setting future pin locations
    let poB = MKPointAnnotation()
    let poBLocCoord = CLLocationCoordinate2DMake(39.351162, -76.479461)

    let currentLoc = MKPointAnnotation()
    let currentLocCoord = CLLocationCoordinate2DMake(35.973189, -79.994997)
    
    let cocoCay = MKPointAnnotation()
    let cocoCayCoord = CLLocationCoordinate2DMake(25.818164, -77.938906)
    
    var defaultLoc = false
    var calledFromLocation = false
    var pIndex = 0

    //create buttons
    let myLocation = UIButton()
    let myPin = UIButton()
    
    
    override func loadView() {
        //Create a map view
        mapView = MKMapView()
        
        //Set it as *the* view of this view controller
        view = mapView
        

        locationManager.requestAlwaysAuthorization()
        
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
//        let myLocationString = NSLocalizedString("My Location", comment: "My Location view")
//        let pinString = NSLocalizedString("Pin", comment: "Pin view")

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
        
        
        
        
        //setting myLocation button
        myLocation.setTitle("My Location", for: .normal)
        myLocation.setTitleColor(UIColor.blue, for: .normal)
        myLocation.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        myLocation.translatesAutoresizingMaskIntoConstraints = false
        myLocation.addTarget(self, action: #selector(myLocButtonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(myLocation)
        //setting constraints
        myLocation.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -8).isActive = true
        myLocation.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        //setting myPin button
        myPin.setTitleColor(UIColor.blue, for: UIControlState.normal)
        myPin.setTitle("Pin", for: UIControlState.normal)
        myPin.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        myPin.addTarget(self, action: #selector(setPins(_:)), for: UIControlEvents.touchUpInside)
        
        
        myPin.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(myPin)
        
        //setting constraints
        let pinBottomConstraint = myPin.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -60)
        
        pinBottomConstraint.isActive = true
        myPin.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MapViewController loaded its view.")
    }
    
    //changes the map type
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
    
    //if the "My Location" button is tapped, this function is called
    //it will show my home address with a blue dot
    func myLocButtonTapped(_ button: UIButton) {
        
        print("MyLocation")
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
        myLocation.addTarget(self, action: #selector(reset(_:)), for: .touchUpInside)
        
    }
    
    
    //call load view so the display is set back to its original state
    func reset(_ button: UIButton) {
        loadView()
    }

    // This function takes in the current pin index and displays the specified pin
    func setPins(_ button: UIButton) {
        //set the coordinates of the pins
        currentLoc.coordinate = currentLocCoord
        currentLoc.title = "Current Location"
        
        poB.coordinate = poBLocCoord
        poB.title = "Place of Birth"
        
        cocoCay.coordinate = cocoCayCoord
        cocoCay.title = "Coco Cay"
        
        if(!defaultLoc) {
            lastLoc = mapView.centerCoordinate
            defaultLoc = true
        }
        
        if(mapView.showsUserLocation) {
            mapView.showsUserLocation = false
        }
        
        if(pIndex == 0) { //shows my place of birth (Franklin Square, Baltimore, MD
            mapView.removeAnnotations(self.mapView.annotations)
            mapView.addAnnotation(poB)
            mapView.setCenter(poBLocCoord, animated: false)
        } else if(pIndex == 1) { //shows my current location which is HPU
            mapView.removeAnnotations(self.mapView.annotations)
            mapView.addAnnotation(currentLoc)
            mapView.setCenter(currentLocCoord, animated: false)
        } else if(pIndex == 2) { //shows the pin at Coco Cay, Bahamas
            mapView.removeAnnotations(self.mapView.annotations)
            mapView.addAnnotation(cocoCay)
            mapView.setCenter(cocoCayCoord, animated: false)
        } else if(pIndex == 3) { //shows the current location (my home)
            mapView.showsUserLocation = true

            mapView.setCenter(lastLoc, animated: false)
            defaultLoc = false
            mapView.removeAnnotations(self.mapView.annotations)
        } else if (pIndex == 4) { //zooms out to the full map view
            mapView.showsUserLocation = true
            reset(button)
            //button.addTarget(self, action: #selector(reset(_:)), for: .touchUpInside)
            
           // mapView.setCenter(lastLoc, animated: false)
        }
        
        pIndex = (pIndex+1)%5
        print(pIndex)
    }

    func mapViewWillStartLocatingUser(_ mapView: MKMapView) {
        print("Start Loading.")
    
            if(!defaultLoc){
            lastLoc = mapView.centerCoordinate
            defaultLoc = true
        }
    }

    func mapViewDidStopLocatingUser(_ mapView: MKMapView) {
        print("Stop Loading.")
        myLocation.backgroundColor = UIColor.white
        if(calledFromLocation) {
            mapView.setCenter(lastLoc, animated: false)
            calledFromLocation = false
        }
    }

}

