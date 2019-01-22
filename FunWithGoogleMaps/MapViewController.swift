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
    
    let minLatitude = -85.0
    let maxLatitude = 85.0
    let minLongitude = -180.0
    let maxLongitude = 180.0
    
    func getInitCameraLocation() -> GMSCameraPosition {
        let location = SingaporeLocation()
        return GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: location.zoom)
    }
    
    func getRandomPosition(latitudeRange:Range<Double>, longitudeRange:Range<Double>) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: Double.random(in: latitudeRange), longitude: Double.random(in: longitudeRange))
    }
}

class MapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    let locationUtils = LocationUtils()
    var mapView: GMSMapView?
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Create a GMSCameraPosition that tells the map to display the
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: locationUtils.getInitCameraLocation())
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        mapView.delegate = self
        
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
        view = mapView
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        
        self.mapView?.animate(to: camera)
        
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
        
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
        let numberOfMarkers = 100
        let topLeft = mapView.projection.visibleRegion().farLeft
        let bottomLeft = mapView.projection.visibleRegion().nearLeft
        let topRight = mapView.projection.visibleRegion().farRight
        let bottomRight = mapView.projection.visibleRegion().nearRight
        
        print("all latitude", topLeft.latitude, topRight.latitude, bottomLeft.latitude, bottomRight.latitude)
        print("all longitude", topLeft.longitude, topRight.longitude, bottomLeft.longitude, bottomRight.longitude)
        
        let lARange: Range<Double> = min(topLeft.latitude, topRight.latitude, bottomLeft.latitude, bottomRight.latitude) ..< max(topLeft.latitude, topRight.latitude, bottomLeft.latitude, bottomRight.latitude)
        
        let lORange: Range<Double>
        let shouldTurnOver = checkVariableHasPositiveAndNegativeValuesMixed(topLeft.longitude, topRight.longitude, bottomLeft.longitude, bottomRight.longitude)
        // TODO: Update logic in next commit
//        if shouldTurnOver {
//            if Int.random(in: 0 ..< 2) == 0 {
//                lORange = locationUtils.minLongitude ..< min(topLeft.longitude, topRight.longitude, bottomLeft.longitude, bottomRight.longitude)
//            } else {
//                lORange = max(topLeft.longitude, topRight.longitude, bottomLeft.longitude, bottomRight.longitude) ..< locationUtils.maxLongitude
//            }
//        } else {
            lORange = min(topLeft.longitude, topRight.longitude, bottomLeft.longitude, bottomRight.longitude) ..< max(topLeft.longitude, topRight.longitude, bottomLeft.longitude, bottomRight.longitude)
//        }
        
        for _ in 0 ..< numberOfMarkers {
            
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
    
    func checkVariableHasPositiveAndNegativeValuesMixed(_ param: Double...) -> Bool {
        guard param.count > 2 else {
            return false
        }
        let checkPositive = param.first! < 0.0
        for i in 1 ..< param.count {
            let e = param[i]
            if checkPositive {
                if e >= 0 { return true }
            } else {
                if e < 0 { return true }
            }
        }
        return false
    }
}

