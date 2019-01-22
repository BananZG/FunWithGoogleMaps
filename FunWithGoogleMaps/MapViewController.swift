//
//  MapViewController.swift
//  FunWithGoogleMaps
//
//  Created by Gan Jun Jie on 22/01/2019.
//  Copyright © 2019 Gan Jun Jie. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

struct SingaporeLocation {
    var latitude:Double = 1.34
    var longitude:Double = 103.77
    var zoom:Float = 11
}

class LocationUtils : NSObject {
    
    func getInitCameraLocation() -> GMSCameraPosition {
        let location = SingaporeLocation()
        return GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: location.zoom)
    }
    
    func getRandomPosition(latitudeRange:Range<Double>, longitudeRange:Range<Double>) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: Double.random(in: latitudeRange), longitude: Double.random(in: longitudeRange))
    }
}

class MapViewController: UIViewController, GMSMapViewDelegate {
    let locationUtils = LocationUtils()
    var mapView: GMSMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Create a GMSCameraPosition that tells the map to display the
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: locationUtils.getInitCameraLocation())
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        mapView.delegate = self
        
        view = mapView
    }
    
    var allMarkers: [GMSMarker] = []
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        print("mapView idleAt \(position)")
//        locationUtils.generateMarkers(withNumbersOfCases: 200, forMapView: mapView)
        
        // 1. remove all previous marker
        allMarkers.forEach { $0.map = nil }
        allMarkers.removeAll()
        // mapView.clear()
        
        // 2. create marker based on current view (dummy markers a.t.m.)
        let numberOfCases = 100
        let topLeft = mapView.projection.visibleRegion().farLeft
        let BottomLeft = mapView.projection.visibleRegion().nearLeft
        let topRight = mapView.projection.visibleRegion().farRight
        
        let lARange: Range<Double>
        if topLeft.latitude > BottomLeft.latitude {
            lARange = BottomLeft.latitude ..< topLeft.latitude
        } else {
            lARange = topLeft.latitude ..< BottomLeft.latitude
        }
        
        let lORange: Range<Double>
        if topRight.longitude > BottomLeft.longitude {
            lORange = BottomLeft.longitude ..< topRight.longitude
        } else {
            lORange = topRight.longitude ..< BottomLeft.longitude
        }
        
        for _ in 0 ..< numberOfCases {
            
            // Creates markers in the map.
            let marker = GMSMarker()
            marker.position = locationUtils.getRandomPosition(latitudeRange: lARange, longitudeRange: lORange)
//            marker.title = "title"
//            marker.snippet = "description"
            marker.map = mapView
            allMarkers.append(marker)
        }
        
        // 3. Magic!
        
        
    }
}

